{******************************************************************************}
{                                                                              }
{           RESTClientLib.Request.Synapse.pas                                  }
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
unit RESTClientLib.Request.Synapse;

interface

{$IFDEF RESTClientLib_SYNAPSE}
uses
  httpsend, ssl_openssl, blcksock, RESTClientLib.Types, RESTClientLib.Interfaces,
  RESTClientLib.Core;

type
  TRequestExecuteSynapse = class(TRequestExecuteCustom)
  private
    { private declarations }
      FHTTPSend: THTTPSend;
      function GetResponse(const pHTTPSend: THTTPSend; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
      procedure SetConfigure;
      procedure SetHeaders;
      procedure SetCookies;
      procedure SetSecureSocketsLayer;
  protected
    { protected declarations }
    function Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); override;
    destructor Destroy; override;
  end;
{$ENDIF RESTClientLib_SYNAPSE}

implementation

uses
  System.SysUtils, System.Rtti, System.Generics.Collections, System.Classes,
  System.Diagnostics, RESTClientLib.Response.Synapse;

{$IFDEF RESTClientLib_SYNAPSE}
constructor TRequestExecuteSynapse.Create(pRESTClientLib: IRESTClientLib);
begin
  inherited Create(pRESTClientLib);
  FHTTPSend := THTTPSend.Create;
end;

destructor TRequestExecuteSynapse.Destroy;
begin
  FHTTPSend.Free;
  inherited Destroy;
end;

function TRequestExecuteSynapse.Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse;
var
  lBodyRequestTemp: TStream;
  lUseMultipartFormData: Boolean;
  lTriesCount: Integer;
  lTries: Integer;
  lRequestTime: TStopWatch;
  lRequestURL: string;
  lRequestMethod: string;
begin
  Debug('Request Execute: %s', ['Synapse']);

  Result := nil;
  lUseMultiPartFormData := False;
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

      // SET BODY
      FHTTPSend.Document.CopyFrom(lBodyRequestTemp, 0);
      FHTTPSend.Document.Position := 0;
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
    FreeAndNil(lBodyRequestTemp);
  end;
  {$ENDREGION}

  {$REGION 'EXECUTE'}
  lTries := (FRESTClientLib.Options.Retries.Tries);
  for lTriesCount := 1 to lTries do
  begin
    try
      Debug('Request Execute: %s - Tries: %.2d', ['HTTPMethod', lTriesCount]);

      // EXECUTE
      lRequestTime := TStopWatch.StartNew;
      if not FHTTPSend.HTTPMethod(lRequestMethod, lRequestURL) then
      begin
        lRequestTime.Stop;
        Debug('Request Execute: Error code: %d - %s', [FHTTPSend.Sock.LastError, FHTTPSend.Sock.LastErrorDesc]);

        if (lTriesCount < lTries) then
        begin
          TThread.Sleep(FRESTClientLib.Options.Retries.DelayInMilliseconds);
          Continue;
        end;

        raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
          .&Type(TRESTClientLibExceptionKind.E_REQUEST_FAIL)
          .Title('Request Execute fail')
          .Error('Error code: %d: %s.', [FHTTPSend.Sock.LastError, FHTTPSend.Sock.LastErrorDesc])
          .Hint('Check the error message.')
          .ClassName(FHTTPSend.Sock.ClassName)
          .RequestMethod(lRequestMethod)
          .URL(lRequestURL);
      end;
      lRequestTime.Stop;

      // RESPONSE
      Result := GetResponse(FHTTPSend, lRequestTime.ElapsedMilliseconds, lRequestMethod);
      Break;
    except
      on E: ERESTClientLib do
      begin
        lRequestTime.Stop;
        E := ERESTClientLib(AcquireExceptionObject);
        Debug('Request Execute: Error: %s', [E.Message]);
        raise E.RequestMethod(lRequestMethod).URL(lRequestURL);
      end;
      on E: Exception do
      begin
        lRequestTime.Stop;
        Debug('Request Execute: Error: %s', [E.Message]);
        raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
          .&Type(TRESTClientLibExceptionKind.E_REQUEST_FAIL)
          .Title('Request Execute fail')
          .Error(E.Message)
          .Hint('Check the error message.')
          .ClassName(E.ClassName)
          .RequestMethod(lRequestMethod)
          .URL(lRequestURL)
      end;
    end;
  end;
  {$ENDREGION}

end;

function TRequestExecuteSynapse.GetResponse(const pHTTPSend: THTTPSend; const pRequestTime: Int64; const pRequestMethod: string): IResponse;
begin
  Debug('Request Execute: Synapse ( %s )', ['GetResponse']);
  Result := TResponseSynapse.Create(FRESTClientLib, pHTTPSend, pRequestTime, pRequestMethod);
end;

procedure TRequestExecuteSynapse.SetConfigure;
begin
  Debug('Request Execute: Synapse ( %s )', ['SetConfigure']);

  FHTTPSend.Clear;
  FHTTPSend.Protocol := '1.1';
  FHTTPSend.Headers.NameValueSeparator := ':';
  FHTTPSend.Headers.CaseSensitive := False;

  FHTTPSend.Timeout := FRESTClientLib.Options.RequestTimeout;
  FHTTPSend.Sock.ConnectionTimeout := FRESTClientLib.Options.RequestTimeout;
  FHTTPSend.Sock.NonblockSendTimeout := FRESTClientLib.Options.RequestTimeout;
  FHTTPSend.Sock.SocksTimeout := FRESTClientLib.Options.RequestTimeout;
  FHTTPSend.Sock.HTTPTunnelTimeout := FRESTClientLib.Options.RequestTimeout;
  FHTTPSend.Sock.InterPacketTimeout := False;

  if (FRESTClientLib.Options.Proxy.Server <> EmptyStr) then
  begin
    FHTTPSend.ProxyHost := FRESTClientLib.Options.Proxy.Server;
    FHTTPSend.ProxyPort := FRESTClientLib.Options.Proxy.Port.ToString;
    FHTTPSend.ProxyUser := FRESTClientLib.Options.Proxy.User;
    FHTTPSend.ProxyPass := FRESTClientLib.Options.Proxy.Password;
  end;
end;

procedure TRequestExecuteSynapse.SetCookies;
begin
  Debug('Request Execute: Synapse ( %s )', ['SetCookies']);

  FHTTPSend.Cookies.Clear;
  FHTTPSend.Cookies.Text := FRESTClientLib.Cookies.ToLine;
end;

procedure TRequestExecuteSynapse.SetHeaders;
var
  lHeader: TPair<string, string>;
  lConnection: string;

  procedure DeleteHeader(const pIndex: Integer);
  begin
    if (pIndex < 0) then
      Exit;

    FHTTPSend.Headers.Delete(pIndex);
  end;
begin
  Debug('Request Execute: Synapse ( %s )', ['SetHeaders']);

  FHTTPSend.Headers.Clear;
  FHTTPSend.MimeType := FRESTClientLib.Headers.ContentType;
  FHTTPSend.UserAgent := FRESTClientLib.Headers.UserAgent;

  lConnection := Trim(FRESTClientLib.Headers.Find('Connection'));
  if (lConnection <> EmptyStr) then
    FHTTPSend.KeepAlive := SameText(lConnection, 'keep-alive')
  else
    FHTTPSend.KeepAlive := FRESTClientLib.Headers.ConnectionKeepAlive;

  for lHeader in FRESTClientLib.Headers.Headers do
    FHTTPSend.Headers.Add(Format('%s: %s', [lHeader.Key, lHeader.Value]));

  DeleteHeader(FHTTPSend.Headers.IndexOfName('Connection'));
  DeleteHeader(FHTTPSend.Headers.IndexOfName('Content-Type'));
  DeleteHeader(FHTTPSend.Headers.IndexOfName('User-Agent'));
end;

procedure TRequestExecuteSynapse.SetSecureSocketsLayer;
begin
  Debug('Request Execute: Synapse ( %s )', ['SetSecureSocketsLayer']);

  FHTTPSend.Sock.SSL.SSLType := TSSLType.LT_all;
  FHTTPSend.Sock.SSL.CertificateFile := FRESTClientLib.Options.Certificate.CertFile;
  FHTTPSend.Sock.SSL.PrivateKeyFile := FRESTClientLib.Options.Certificate.KeyFile;
end;
{$ENDIF RESTClientLib_SYNAPSE}

end.
