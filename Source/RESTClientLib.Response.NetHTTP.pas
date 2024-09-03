{******************************************************************************}
{                                                                              }
{           RESTClientLib.Response.NetHTTP.pas                                 }
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
unit RESTClientLib.Response.NetHTTP;

interface

uses
  System.Net.HttpClient, RESTClientLib.Interfaces, RESTClientLib.Core;

type
  TResponseNetHTTP = class(TResponseCustom)
  private
    { private declarations }
    FHTTPResponse: IHTTPResponse;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pHTTPResponse: IHTTPResponse; const pRequestTime: Int64; const pRequestMethod: string); reintroduce;
  end;

  TResponseHeadersNetHTTP = class(TResponseHeaders)
  private
    { private declarations }
    FHTTPResponse: IHTTPResponse;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string); reintroduce;
  end;

  TResponseCookiesNetHTTP = class(TResponseCookies)
  private
    { private declarations }
    FHTTPResponse: IHTTPResponse;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string); reintroduce;
  end;

  TResponseBodyNetHTTP = class(TResponseBody)
  private
    { private declarations }
    FHTTPResponse: IHTTPResponse;
  protected
    { protected declarations }
    procedure Process; override;
    function GetContentType: string; override;
    function GetContentEncoding: string; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string); reintroduce;
  end;

implementation

uses
  System.Net.URLClient, System.SysUtils, System.Classes,RESTClientLib.Utils,
  RESTClientLib.Mime, RESTClientLib.Types;

{$REGION 'TResponseNetHTTP'}
constructor TResponseNetHTTP.Create(pRESTClientLib: IRESTClientLib; pHTTPResponse: IHTTPResponse; const pRequestTime: Int64; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pRequestTime);
  FHTTPResponse := pHTTPResponse;

  case FHTTPResponse.Version of
    THTTPProtocolVersion.HTTP_1_0: FVersionHTTP := 'HTTP/1.0';
    THTTPProtocolVersion.HTTP_1_1: FVersionHTTP := 'HTTP/1.1';
    THTTPProtocolVersion.HTTP_2_0: FVersionHTTP := 'HTTP/2.0';
  else
    FVersionHTTP := EmptyStr;
  end;
  FStatusText := FHTTPResponse.StatusText;
  FStatusCode := FHTTPResponse.StatusCode;

  Debug('Response: Version HTTP ( %s )', [FVersionHTTP]);
  Debug('Response: Status Code ( %d )', [FStatusCode]);
  Debug('Response: Status Text ( %s )', [FStatusText]);

  FHeaders := TResponseHeadersNetHTTP.Create(pRESTClientLib, Self, pHTTPResponse, pRequestMethod);
  FCookies := TResponseCookiesNetHTTP.Create(pRESTClientLib, Self, pHTTPResponse, pRequestMethod);
  FBody := TResponseBodyNetHTTP.Create(pRESTClientLib, Self, pHTTPResponse, pRequestMethod);
end;
{$ENDREGION}

{$REGION 'TResponseHeadersNetHTTP'}
constructor TResponseHeadersNetHTTP.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPResponse := pHTTPResponse;

  Process;
end;

procedure TResponseHeadersNetHTTP.Process;
var
  lHeaderPair: TNameValuePair;
begin
  Debug('Response: Get %s ', ['Headers']);

  FFields.Clear;
  for lHeaderPair in FHTTPResponse.Headers do
  begin
    FFields.AddOrSetValue(lHeaderPair.Name, lHeaderPair.Value);
    Debug('Response: Headers (%s: %s)', [lHeaderPair.Name, lHeaderPair.Value]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseCookiesNetHTTP'}
constructor TResponseCookiesNetHTTP.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPResponse := pHTTPResponse;

  Process;
end;

procedure TResponseCookiesNetHTTP.Process;
var
  lCookie: TCookie;
begin
  Debug('Response: Get %s ', ['Cookies']);
  for lCookie in FHTTPResponse.Cookies do
  begin
    FCookies.AddOrSetValue(lCookie.Name, lCookie.Value);
    Debug('Response: Cookies (%s: %s)', [lCookie.Name, lCookie.Value]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseBodyNetHTTP'}
constructor TResponseBodyNetHTTP.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; pHTTPResponse: IHTTPResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPResponse := pHTTPResponse;

  Process;
end;

function TResponseBodyNetHTTP.GetContentEncoding: string;
begin
  Result := Trim(FHTTPResponse.ContentEncoding);
end;

function TResponseBodyNetHTTP.GetContentType: string;
begin
  Result := THeadersUtils.ExtractContentType(Trim(FHTTPResponse.MimeType));
end;

procedure TResponseBodyNetHTTP.Process;
var
  lContentDecompression: TBytes;
  lContentDecompressionOk: Boolean;
begin
  Debug('Response: Get %s', ['Body']);

  FMIMEType := GetContentType;
  TRESTClientLibMimeTypes.FromContentType(FMIMEType, FMIMETypeExt, FIsBinary);
  FCharSet := Trim(FHTTPResponse.ContentCharSet);

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
    TRESTClientLibContentCompressionKind.Deflate: lContentDecompressionOk := TZLibUtils.DecompressionDeflate(FHTTPResponse.ContentStream, lContentDecompression);
    TRESTClientLibContentCompressionKind.Gzip: lContentDecompressionOk := TZLibUtils.DecompressionGZip(FHTTPResponse.ContentStream, lContentDecompression);
  end;

  FHTTPResponse.ContentStream.Position := 0;
  if lContentDecompressionOk then
    FBody := TBytesStream.Create(lContentDecompression)
  else
  begin
    FBody := TStringStream.Create;
    FBody.LoadFromStream(FHTTPResponse.ContentStream);
  end;

  FBody.Position := 0;
  if (FBody.Size > 0) then
    Debug('Response Body: Size( %d )', [FBody.Size])
  else
    Debug('Response Body: Size( %s )', ['empty']);
end;
{$ENDREGION}

end.
