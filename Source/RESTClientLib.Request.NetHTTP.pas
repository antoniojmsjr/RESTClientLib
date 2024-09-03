{******************************************************************************}
{                                                                              }
{           RESTClientLib.Request.NetHTTP.pas                                  }
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
unit RESTClientLib.Request.NetHTTP;

interface

uses
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  System.Diagnostics, System.Classes, RESTClientLib.Types,
  RESTClientLib.Interfaces, RESTClientLib.Core;

type
  TRequestExecuteNetHTTP = class(TRequestExecuteCustom)
  private
    { private declarations }
    FHttpRequest: TNetHTTPRequest;
    procedure SetCookies;
    procedure SetConfigure;
    function GetHeaders: TNetHeaders;
    function GetResponse(pHTTPResponse: IHTTPResponse; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
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
  System.SysUtils, System.Rtti, System.NetEncoding, System.Generics.Collections,
  RESTClientLib.Response.NetHTTP;

{$REGION 'TRequestExecuteNetHTTP'}
constructor TRequestExecuteNetHTTP.Create(pRESTClientLib: IRESTClientLib);
begin
  inherited Create(pRESTClientLib);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  FHttpRequest.Client := TNetHTTPClient.Create(FHttpRequest);
  FHttpRequest.Client.CookieManager := TCookieManager.Create;
end;

destructor TRequestExecuteNetHTTP.Destroy;
begin
  FHttpRequest.Free;
  FHttpRequest.Client.CookieManager.Free;
  inherited Destroy;
end;

function TRequestExecuteNetHTTP.GetResponse(pHTTPResponse: IHTTPResponse; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
begin
  Debug('Request Execute: NetHTTP ( %s )', ['GetResponse']);
  Result := TResponseNetHTTP.Create(FRESTClientLib, pHTTPResponse, pRequestTime, pRequestMethod);
end;

function TRequestExecuteNetHTTP.Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse;
var
  lHTTPResponse: IHTTPResponse;
  lBodyRequestTemp: TStream;
  lUseMultipartFormData: Boolean;
  lTriesCount: Integer;
  lTries: Integer;
  lFreeOnError: Boolean;
  lRequestHeaders: TNetHeaders;
  lRequestTime: TStopWatch;
  lRequestURL: string;
  lRequestMethod: string;
  lRaiseException: Boolean;
begin
  Debug('Request Execute: NetHTTP ( %s )', ['Execute']);

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

        FHttpRequest.SourceStream := lBodyRequestTemp;
        FHttpRequest.SourceStream.Position := 0;
      end;

      // GET BODY
      if (Assigned(FRESTClientLib.Body.Content) and (lUseMultiPartFormData = False)) then
      begin
        FRESTClientLib.Body.Content.Position := 0;
        if (FRESTClientLib.Body.Content.Size > 0) then
        begin
          lBodyRequestTemp.CopyFrom(FRESTClientLib.Body.Content, 0);
          lBodyRequestTemp.Position := 0;

          FHttpRequest.SourceStream := lBodyRequestTemp;
          FHttpRequest.SourceStream.Position := 0;
        end;
      end;

      if Assigned(FHttpRequest.SourceStream) then
        Debug('Request Execute: Body ( %d )', [FHttpRequest.SourceStream.Size])
      else
        Debug('Request Execute: Body ( %s )', ['empty']);

      SetConfigure;
      SetCookies;
      lRequestHeaders := GetHeaders;

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
    begin
      FreeAndNil(lBodyRequestTemp);
      FHttpRequest.SourceStream := nil;
    end;
  end;
  {$ENDREGION}

  {$REGION 'EXECUTE'}
  lTries := (FRESTClientLib.Options.Retries.Tries);
  FHttpRequest.MethodString := lRequestMethod;
  FHttpRequest.URL := lRequestURL;
  try
    for lTriesCount := 1 to lTries do
    begin
      try
        Debug('Request Execute: %s - Tries: %.2d', ['HttpRequest.Execute', lTriesCount]);

        // EXECUTE
        lRequestTime := TStopWatch.StartNew;
        lHTTPResponse := FHttpRequest.Execute(lRequestHeaders);
        lRequestTime.Stop;

        // RESPONSE
        if Assigned(lHTTPResponse) then
          Result := GetResponse(lHTTPResponse, lRequestTime.ElapsedMilliseconds, lRequestMethod);
        Break;
      except
        on E: ERESTClientLib do
        begin
          lRequestTime.Stop;
          E := ERESTClientLib(AcquireExceptionObject);
          Debug('Request Execute: Error: %s', [E.Message]);
          raise E.RequestMethod(lRequestMethod);
        end;
        on E: ENetHTTPClientException do
        begin
          lRequestTime.Stop;
          Debug('Request Execute: Error: %s', [E.Message]);
          lRaiseException := (Pos('Maximum number of redirections', E.Message) > 0);

          if (lTriesCount < lTries) and (lRaiseException = False) then
          begin
            TThread.Sleep(FRESTClientLib.Options.Retries.DelayInMilliseconds);
            Continue;
          end;

          raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
            .&Type(TRESTClientLibExceptionKind.E_REQUEST_FAIL)
            .Title('Request Execute fail')
            .Error(E.Message)
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
    FHttpRequest.SourceStream := nil;
  end;
  {$ENDREGION}

end;

procedure TRequestExecuteNetHTTP.SetConfigure;
begin
  Debug('Request Execute: NetHTTP ( %s )', ['SetConfigure']);

  FHttpRequest.Asynchronous := False;
  {$IF CompilerVersion >= 32}
  FHttpRequest.Client.SecureProtocols := [];
  FHttpRequest.Client.SecureProtocols := [THTTPSecureProtocol.SSL3,
                                          THTTPSecureProtocol.TLS1,
                                          THTTPSecureProtocol.TLS11,
                                          THTTPSecureProtocol.TLS12];
  FHttpRequest.Client.RedirectsWithGET := [];
  {$ENDIF}

  FHttpRequest.Client.HandleRedirects := FRESTClientLib.Options.Redirects.Active;
  FHttpRequest.Client.MaxRedirects := FRESTClientLib.Options.Redirects.MaxRedirects;

  FHttpRequest.ConnectionTimeout := FRESTClientLib.Options.RequestTimeout;
  FHttpRequest.ResponseTimeout := FRESTClientLib.Options.ResponseTimeout;

  if (FRESTClientLib.Options.Proxy.Server <> EmptyStr) then
  begin
    FHttpRequest.Client.ProxySettings :=
      TProxySettings.Create(FRESTClientLib.Options.Proxy.Server, FRESTClientLib.Options.Proxy.Port,
                            FRESTClientLib.Options.Proxy.User, FRESTClientLib.Options.Proxy.Password,
                            EmptyStr);
  end;

  if ((FRESTClientLib.Options.Certificate.CertFile <> EmptyStr)
  or (FRESTClientLib.Options.Certificate.KeyFile <> EmptyStr)) then
  begin
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_OTHERS)
      .Title('Request Execute fail')
      .Error('NetHTTP does not support using certificates.')
      .Hint('Use Indy or Synapse, which have support.')
      .ClassName(Self.Classname);
  end;
end;

procedure TRequestExecuteNetHTTP.SetCookies;
var
  lURL: string;
  lCookies: string;
begin
  Debug('Request Execute: NetHTTP ( %s )', ['SetCookies']);

  lCookies := FRESTClientLib.Cookies.ToLine;
  lURL := FRESTClientLib.URL.FullURLWithoutQueryParams;

  if (lCookies = EmptyStr) then
    Exit;

  {$IF CompilerVersion >= 33}
  FHttpRequest.Client.CookieManager.Clear;
  {$ENDIF}
  FHttpRequest.Client.CookieManager.AddServerCookie(lCookies, lURL);
end;

function TRequestExecuteNetHTTP.GetHeaders: TNetHeaders;
var
  lHeader: TPair<string, string>;
  lConnection: string;
begin
  Debug('Request Execute: NetHTTP ( %s )', ['GetHeaders']);

  for lHeader in FRESTClientLib.Headers.Headers do
    Result := Result + [TNetHeader.Create(lHeader.Key, lHeader.Value)];

  lConnection := Trim(FRESTClientLib.Headers.Find('Connection'));
  if (lConnection = EmptyStr) then
    if FRESTClientLib.Headers.ConnectionKeepAlive then
      Result := Result + [TNetHeader.Create('Connection', 'keep-alive')]
    else
      Result := Result + [TNetHeader.Create('Connection', 'close')];
end;
{$ENDREGION}

end.
