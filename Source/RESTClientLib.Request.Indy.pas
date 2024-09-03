{******************************************************************************}
{                                                                              }
{           RESTClientLib.Request.Indy.pas                                     }
{                                                                              }
{           Copyright (C) Antônio José Medeiros Schneider Júnior               }
{                                                                              }
{           https://github.com/antoniojmsjr/RESTClientLib                      }
{                                                                              }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Licensed under the Apache License, Version 2.0 (the "License");             }
{  you may not use this file except in compliance with the License.            }
{  You may obtain a copy of the License at                                     }
{                                                                              }
{      http://www.apache.org/licenses/LICENSE-2.0                              }
{                                                                              }
{  Unless required by applicable law or agreed to in writing, software         }
{  distributed under the License is distributed on an "AS IS" BASIS,           }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    }
{  See the License for the specific language governing permissions and         }
{  limitations under the License.                                              }
{                                                                              }
{******************************************************************************}
unit RESTClientLib.Request.Indy;

interface

uses
  System.Diagnostics, System.Classes, IdHTTP, IdServerIOHandler, IdSSL,
  IdSSLOpenSSL, IdCookieManager, RESTClientLib.Types, RESTClientLib.Interfaces,
  RESTClientLib.Core;

type
  TIdHTTPHelper = class helper for TIdCustomHTTP
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Execute(const AMethod: TIdHTTPMethod; AURL: string; ASource: TStream; AResponse: TStream);
  end;

  TRequestExecuteIndy = class(TRequestExecuteCustom)
  private
    { private declarations }
      FIdHttp: TIdHTTP;
      FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
      function GetResponse(const pIdHttp: TIdHTTP; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
      procedure SetConfigure;
      procedure SetHeaders;
      procedure SetCookies;
      procedure SetSecureSocketsLayer;
      function TranslateSocketErrorMsg(const pMessage: string): string;
  protected
    { protected declarations }
    function Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); override;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, System.Rtti, System.Generics.Collections, IdException,
  IdURI, IdStack, IdSSLOpenSSLHeaders, IdExceptionCore, RESTClientLib.Response.Indy;

{ TRequestExecuteIndy }

constructor TRequestExecuteIndy.Create(pRESTClientLib: IRESTClientLib);
begin
  inherited Create(pRESTClientLib);

  FIdHttp := TIdHTTP.Create(nil);
  FIdHttp.CookieManager := TIdCookieManager.Create(FIdHttp);
  FIdSSLIOHandlerSocketOpenSSL   := TIdSSLIOHandlerSocketOpenSSL.Create(FIdHttp);
  FIdHttp.Request.CustomHeaders.CaseSensitive := False;
end;

destructor TRequestExecuteIndy.Destroy;
begin
  FIdHttp.Free;
  inherited Destroy;
end;

function TRequestExecuteIndy.Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse;
var
  lBodyRequestTemp: TStream;
  lBodyResponse: TStream;
  lUseMultipartFormData: Boolean;
  lTriesCount: Integer;
  lTries: Integer;
  lFreeOnError: Boolean;
  lRequestTime: TStopWatch;
  lRequestURL: string;
  lRequestMethod: string;
begin
  Debug('Request Execute: Indy ( %s )', ['Execute']);

  Result := nil;
  lUseMultiPartFormData := False;
  lFreeOnError := True;
  lBodyRequestTemp := nil;

  {$REGION 'CONFIG'}
  try
    try
      inherited Execute(pRequestMethod);

      // BODY TEMP
      lBodyRequestTemp := TMemoryStream.Create;

      // GET MULTIPARTFORMDATA
      if (FRESTClientLib.MultipartFormData.UseMultipartFormData) then
      begin
        lUseMultipartFormData := True;
        FRESTClientLib.Headers.ContentType(FRESTClientLib.MultipartFormData.ContentType);

        FRESTClientLib.MultipartFormData.Content.Position := 0;
        lBodyRequestTemp.CopyFrom(FRESTClientLib.MultipartFormData.Content, 0);
        lBodyRequestTemp.Position := 0;
      end;

      // GET BODY
      if (Assigned(FRESTClientLib.Body.Content) and (lUseMultiPartFormData = False)) then
      begin
        FRESTClientLib.Body.Content.Position := 0;
        if (FRESTClientLib.Body.Content.Size > 0) then
        begin
          lBodyRequestTemp.CopyFrom(FRESTClientLib.Body.Content, 0);
          lBodyRequestTemp.Position := 0;
        end;
      end;

      if (lBodyRequestTemp.Size > 0) then
        Debug('Request Execute: Body ( %d )', [lBodyRequestTemp.Size])
      else
        Debug('Request Execute: Body ( %s )', ['empty']);

      SetConfigure;
      SetCookies;
      SetHeaders;
      SetSecureSocketsLayer;

      // SET URL/METHOD
      lRequestURL := FRESTClientLib.URL.FullURL;
      lRequestMethod := pRequestMethod.AsString;

      lFreeOnError := False;
    except
      on E: ERESTClientLib do
      begin
        E := ERESTClientLib(AcquireExceptionObject);
        Debug('Request Execute: Error: %s', [E.Message]);
        raise E.RequestMethod(lRequestMethod).URL(lRequestURL);
      end;
      on E: Exception do
      begin
        Debug('Request Execute: Error: %s', [E.Message]);
        raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
          .&Type(TRESTClientLibExceptionKind.E_OTHERS)
          .Title('Request Execute fail')
          .Error(E.Message)
          .Hint('Check the error message.')
          .ClassName(E.ClassName)
          .RequestMethod(lRequestMethod)
          .URL(lRequestURL);
      end;
    end;
  finally
    if lFreeOnError then
      FreeAndNil(lBodyRequestTemp);
  end;
  {$ENDREGION}

  {$REGION 'EXECUTE'}
  lBodyResponse := TMemoryStream.Create;
  lTries := (FRESTClientLib.Options.Retries.Tries);
  try
    for lTriesCount := 1 to lTries do
    begin
      try
        Debug('Request Execute: %s - Tries: %.2d', ['IdHttp.Execute', lTriesCount]);

        // EXECUTE
        lRequestTime := TStopWatch.StartNew;
        FIdHttp.Execute(lRequestMethod, lRequestURL, lBodyRequestTemp, lBodyResponse);
        lRequestTime.Stop;

        // RESPONSE
        if Assigned(FIdHttp.Response) then
          Result := GetResponse(FIdHttp, lRequestTime.ElapsedMilliseconds, lRequestMethod);
        Break;
      except
        on E: ERESTClientLib do
        begin
          lRequestTime.Stop;
          E := ERESTClientLib(AcquireExceptionObject);
          Debug('Request Execute: Error: %s', [E.Message]);
          raise E.RequestMethod(lRequestMethod).URL(lRequestURL);
        end;
        on E: EIdConnClosedGracefully do // EIdConnClosedGracefully is raised when remote side closes connection normally
        begin
          lRequestTime.Stop;
          Debug('Request Execute: EIdConnClosedGracefully: %s', [TranslateSocketErrorMsg(E.Message)]);
        end;
        on E: EIdOpenSSLError do
        begin
          lRequestTime.Stop;
          Debug('Request Execute: Error: %s - %s', [TranslateSocketErrorMsg(E.Message), 'Enter the OpenSSL DLLs']);
          if (E is EIdOSSLCouldNotLoadSSLLibrary) then
            raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
              .&Type(TRESTClientLibExceptionKind.E_REQUEST_FAIL)
              .Title('Request Execute fail')
              .Error(TranslateSocketErrorMsg(E.Message))
              .Hint('Enter the OpenSSL DLLs. [ https://docwiki.embarcadero.com/RADStudio/Athens/en/Securing_Indy_Network_Connections ]')
              .ClassName(E.ClassName)
              .RequestMethod(lRequestMethod)
              .URL(lRequestURL);
        end;
        on E: EIdException do
        begin
          lRequestTime.Stop;
          FIdHttp.Disconnect;
          Debug('Request Execute: Error: %s', [TranslateSocketErrorMsg(E.Message)]);

          if (E is EIdSocketError)
          or (E is EIdConnectTimeout) then
            if (lTriesCount < lTries) then
            begin
              TThread.Sleep(FRESTClientLib.Options.Retries.DelayInMilliseconds);
              Continue;
            end;

          raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
            .&Type(TRESTClientLibExceptionKind.E_REQUEST_FAIL)
            .Title('Request Execute fail')
            .Error(TranslateSocketErrorMsg(E.Message))
            .Hint('Check the error message.')
            .ClassName(E.ClassName)
            .RequestMethod(lRequestMethod)
            .URL(lRequestURL);
        end;
        on E: Exception do
        begin
          lRequestTime.Stop;
          Debug('Request Execute: Error: %s', [E.Message]);
          raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
            .&Type(TRESTClientLibExceptionKind.E_OTHERS)
            .Title('Request Execute fail')
            .Error(E.Message)
            .Hint('Check the error message.')
            .ClassName(E.ClassName)
            .RequestMethod(lRequestMethod)
            .URL(lRequestURL);
        end;
      end;
    end;
  finally
    FreeAndNil(lBodyRequestTemp);
    FreeAndNil(lBodyResponse);
  end;
  {$ENDREGION}

end;

function TRequestExecuteIndy.GetResponse(const pIdHttp: TIdHTTP; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
begin
  Debug('Request Execute: Indy ( %s )', ['GetResponse']);
  Result := TResponseIndy.Create(FRESTClientLib, pIdHttp, pRequestTime, pRequestMethod);
end;

procedure TRequestExecuteIndy.SetConfigure;
begin
  Debug('Request Execute: Indy ( %s )', ['SetConfigure']);

  FIdHttp.Request.Clear;
  FIdHttp.HTTPOptions := [];
  FIdHttp.HTTPOptions := [hoKeepOrigProtocol, hoInProcessAuth, hoNoProtocolErrorException];
  FIdHttp.ProtocolVersion := TIdHTTPProtocolVersion.pv1_1;
  FIdHttp.AllowCookies := True;
  FIdHttp.HandleRedirects := FRESTClientLib.Options.Redirects.Active;
  FIdHttp.RedirectMaximum := FRESTClientLib.Options.Redirects.MaxRedirects;
  FIdHttp.ConnectTimeout := FRESTClientLib.Options.RequestTimeout;
  FIdHttp.ReadTimeout := FRESTClientLib.Options.ResponseTimeout;

  if (FRESTClientLib.Options.Proxy.Server <> EmptyStr) then
  begin
    FIdHttp.ProxyParams.ProxyServer := FRESTClientLib.Options.Proxy.Server;
    FIdHttp.ProxyParams.ProxyPort := FRESTClientLib.Options.Proxy.Port;
    FIdHttp.ProxyParams.ProxyUsername := FRESTClientLib.Options.Proxy.User;
    FIdHttp.ProxyParams.ProxyPassword := FRESTClientLib.Options.Proxy.Password;
  end;
end;

procedure TRequestExecuteIndy.SetSecureSocketsLayer;
begin
  Debug('Request Execute: Indy ( %s )', ['SetSecureSocketsLayer']);

  FIdHttp.IOHandler := nil;
  if FRESTClientLib.URL.BaseURL.Contains('https') then
  begin
    FIdHttp.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [];
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := sslmClient;
    FIdSSLIOHandlerSocketOpenSSL.IsPeer := False;

    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.CertFile := FRESTClientLib.Options.Certificate.CertFile;
    FIdSSLIOHandlerSocketOpenSSL.SSLOptions.KeyFile := FRESTClientLib.Options.Certificate.KeyFile;
  end;
end;

procedure TRequestExecuteIndy.SetCookies;
var
  lURI: TIdURI;
  lURL: string;
  lCookies: string;
begin
  Debug('Request Execute: Indy ( %s )', ['SetCookies']);

  lCookies := FRESTClientLib.Cookies.ToLine;
  lURL := FRESTClientLib.URL.FullURLWithoutQueryParams;

  if (lCookies = EmptyStr) then
    Exit;

  lURI := TIdURI.Create(lURL);
  try
    FIdHttp.CookieManager.AddServerCookie(lCookies, lURI);
  finally
    lURI.Free;
  end;
end;

procedure TRequestExecuteIndy.SetHeaders;
var
  lHeader: TPair<string, string>;
  lConnection: string;
begin
  Debug('Request Execute: Indy ( %s )', ['SetHeaders']);

  FIdHttp.Request.CustomHeaders.Clear;

  lConnection := Trim(FRESTClientLib.Headers.Find('Connection'));
  if (lConnection = EmptyStr) then
    if FRESTClientLib.Headers.ConnectionKeepAlive then
      FIdHttp.Request.CustomHeaders.AddValue('Connection', 'keep-alive')
    else
      FIdHttp.Request.CustomHeaders.AddValue('Connection', 'close');

  for lHeader in FRESTClientLib.Headers.Headers do
    FIdHttp.Request.CustomHeaders.AddValue(lHeader.Key, lHeader.Value);

  FIdHttp.Request.Accept := Trim(FRESTClientLib.Headers.Find('Accept'));
  FIdHttp.Request.AcceptCharSet := Trim(FRESTClientLib.Headers.Find('Accept-Charset'));
  //FIdHttp.Request.AcceptEncoding := Trim(FRESTClientLib.Headers.Find('Accept-Encoding'));
  FIdHttp.Request.AcceptLanguage := Trim(FRESTClientLib.Headers.Find('Accept-Language'));
  FIdHttp.Request.Referer := Trim(FRESTClientLib.Headers.Find('Referer'));
  FIdHttp.Request.UserAgent := Trim(FRESTClientLib.Headers.Find('User-Agent'));
end;

function TRequestExecuteIndy.TranslateSocketErrorMsg(const pMessage: string): string;
var
  lMessage: string;
begin
  lMessage := Trim(pMessage);
  lMessage := StringReplace(lMessage, sLineBreak, ': ', [rfIgnoreCase]);
  Result := StringReplace(lMessage, sLineBreak, '', [rfReplaceAll, rfIgnoreCase]);
end;

{ TIdHTTPHelper }

procedure TIdHTTPHelper.Execute(const AMethod: TIdHTTPMethod; AURL: string; ASource: TStream; AResponse: TStream);
begin
  DoRequest(AMethod, AURL, ASource, AResponse, []);
end;

end.
