{******************************************************************************}
{                                                                              }
{           RESTClientLib.Response.Indy.pas                                    }
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
unit RESTClientLib.Response.Indy;

interface

uses
  IdHTTP, RESTClientLib.Interfaces, RESTClientLib.Core;

type
  TResponseIndy = class(TResponseCustom)
  private
    { private declarations }
    function ExtractResponseText(const pResponseText: string): string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; const pIdHttp: TIdHTTP; const pRequestTime: Int64; const pRequestMethod: string); reintroduce;
  end;

  TResponseHeadersIndy = class(TResponseHeaders)
  private
    { private declarations }
    FIdHttp: TIdHTTP;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string); reintroduce;
  end;

  TResponseCookiesIndy = class(TResponseCookies)
  private
    { private declarations }
    FIdHttp: TIdHTTP;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string); reintroduce;
  end;

  TResponseBodyIndy = class(TResponseBody)
  private
    { private declarations }
    FIdHttp: TIdHTTP;
  protected
    { protected declarations }
    procedure Process; override;
    function GetContentType: string; override;
    function GetContentEncoding: string; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string); reintroduce;
  end;

implementation

uses
  System.SysUtils, System.Classes, IdCookie, System.RegularExpressions,
  RESTClientLib.Utils, RESTClientLib.Mime, RESTClientLib.Types;

{$REGION 'TResponseIndy'}
constructor TResponseIndy.Create(pRESTClientLib: IRESTClientLib; const pIdHttp: TIdHTTP; const pRequestTime: Int64; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pRequestTime);

  case pIdHttp.Response.ResponseVersion of
    TIdHTTPProtocolVersion.pv1_0: FVersionHTTP := 'HTTP/1.0';
    TIdHTTPProtocolVersion.pv1_1: FVersionHTTP := 'HTTP/1.1';
  else
    FVersionHTTP := EmptyStr;
  end;
  FStatusText := ExtractResponseText(pIdHttp.Response.ResponseText);
  FStatusCode := pIdHttp.Response.ResponseCode;

  Debug('Response: Version HTTP ( %s )', [FVersionHTTP]);
  Debug('Response: Status Code ( %d )', [FStatusCode]);
  Debug('Response: Status Text ( %s )', [FStatusText]);

  FHeaders := TResponseHeadersIndy.Create(pRESTClientLib, Self, pIdHttp, pRequestMethod);
  FCookies := TResponseCookiesIndy.Create(pRESTClientLib, Self, pIdHttp, pRequestMethod);
  FBody := TResponseBodyIndy.Create(pRESTClientLib, Self, pIdHttp, pRequestMethod);
end;

function TResponseIndy.ExtractResponseText(const pResponseText: string): string;
var
  lRegex: TRegEx;
  lMatch: TMatch;
begin
  Result := pResponseText;

  lRegex := TRegEx.Create('\b\d{3}\b\s(.+)', [roIgnoreCase]);
  lMatch := lRegex.Match(pResponseText);
  if lMatch.Success then
    Result := lMatch.Groups[1].Value;
end;
{$ENDREGION}

{$REGION 'TResponseHeadersIndy'}
constructor TResponseHeadersIndy.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FIdHttp := pIdHttp;

  Process;
end;

procedure TResponseHeadersIndy.Process;
var
  I: Integer;
  lName: string;
  lValue: string;
begin
  Debug('Response: Get %s ', ['Headers']);

  FFields.Clear;
  for I := 0 to Pred(FIdHttp.Response.RawHeaders.Count) do
  begin
    lName := Trim(FIdHttp.Response.RawHeaders.Names[I]);
    lValue := Trim(FIdHttp.Response.RawHeaders.Values[lName]);
    if SameText(lName, 'Set-Cookie') then
      Continue;
    FFields.AddOrSetValue(lName, lValue);
    Debug('Response: Headers (%s: %s)', [lName, lValue]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseCookiesIndy'}
constructor TResponseCookiesIndy.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FIdHttp := pIdHttp;

  Process;
end;

procedure TResponseCookiesIndy.Process;
var
  I: Integer;
  lIdCookie: TIdCookie;
begin
  Debug('Response: Get %s ', ['Cookies']);
  if not Assigned(FIdHttp.CookieManager) then
    Exit;

  for I := 0 to Pred(FIdHttp.CookieManager.CookieCollection.Count) do
  begin
    lIdCookie := FIdHttp.CookieManager.CookieCollection.Cookies[I];
    FCookies.AddOrSetValue(lIdCookie.CookieName, lIdCookie.Value);
    Debug('Response: Cookies (%s: %s)', [lIdCookie.CookieName, lIdCookie.Value]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseBodyIndy'}
constructor TResponseBodyIndy.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pIdHttp: TIdHTTP; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FIdHttp := pIdHttp;

  Process;
end;

function TResponseBodyIndy.GetContentEncoding: string;
begin
  Result := Trim(FIdHttp.Response.ContentEncoding);
end;

function TResponseBodyIndy.GetContentType: string;
var
  lContentType: string;
begin
  lContentType := Trim(FIdHttp.Response.ContentType);
  Result := THeadersUtils.ExtractContentType(lContentType);
end;

procedure TResponseBodyIndy.Process;
var
  lContentDecompression: TBytes;
  lContentDecompressionOk: Boolean;
begin
  Debug('Response: Get %s', ['Body']);

  FMIMEType := GetContentType;
  TRESTClientLibMimeTypes.FromContentType(FMIMEType, FMIMETypeExt, FIsBinary);
  FCharSet := Trim(FIdHttp.Response.CharSet);
  if (FCharSet <> EmptyStr)  then
    FEncoding := TEncoding.GetEncoding(FCharSet)
  else
  begin
    FEncoding := TEncoding.GetEncoding(CP_UTF8);
    {$IF CompilerVersion >= 33}
    FCharSet := FEncoding.MIMEName;
    {$ELSE}
    FCharSet := FEncoding.EncodingName;
    {$ENDIF}
  end;
  FContentCompression := ContentCompressionFromString(GetContentEncoding);

  lContentDecompressionOk := False;
  case FContentCompression of
    TRESTClientLibContentCompressionKind.Deflate: lContentDecompressionOk := TZLibUtils.DecompressionDeflate(FIdHttp.Response.ContentStream, lContentDecompression);
    TRESTClientLibContentCompressionKind.Gzip: lContentDecompressionOk := TZLibUtils.DecompressionGZip(FIdHttp.Response.ContentStream, lContentDecompression);
  end;

  FIdHttp.Response.ContentStream.Position := 0;
  if lContentDecompressionOk then
    FBody := TBytesStream.Create(lContentDecompression)
  else
  begin
    FBody := TStringStream.Create;
    FBody.LoadFromStream(FIdHttp.Response.ContentStream);
  end;

  FBody.Position := 0;
  if (FBody.Size > 0) then
    Debug('Response Body: Size ( %d )', [FBody.Size])
  else
    Debug('Response Body: Size ( %s )', ['empty']);
end;
{$ENDREGION}

end.
