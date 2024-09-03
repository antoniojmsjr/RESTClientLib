{******************************************************************************}
{                                                                              }
{           RESTClientLib.Response.Synapse.pas                                 }
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
unit RESTClientLib.Response.Synapse;

interface

{$IFDEF RESTClientLib_SYNAPSE}
uses
  httpsend, RESTClientLib.Interfaces, RESTClientLib.Core;

type
  TResponseSynapse = class(TResponseCustom)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; const pHTTPSend: THTTPSend; const pRequestTime: Int64; const pRequestMethod: string); reintroduce;
  end;

  TResponseHeadersSynapse = class(TResponseHeaders)
  private
    { private declarations }
    FHTTPSend: THTTPSend;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pHTTPSend: THTTPSend; const pRequestMethod: string); reintroduce;
  end;

  TResponseCookiesSynapse = class(TResponseCookies)
  private
    { private declarations }
    FHTTPSend: THTTPSend;
  protected
    { protected declarations }
    procedure Process; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pHTTPSend: THTTPSend; const pRequestMethod: string); reintroduce;
  end;

  TResponseBodySynapse = class(TResponseBody)
  private
    { private declarations }
    FHTTPSend: THTTPSend;
  protected
    { protected declarations }
    procedure Process; override;
    function GetContentType: string; override;
    function GetContentEncoding: string; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pHTTPSend: THTTPSend; const pRequestMethod: string); reintroduce;
  end;
{$ENDIF RESTClientLib_SYNAPSE}

implementation

uses
  System.SysUtils, System.Classes, RESTClientLib.Utils, RESTClientLib.Mime,
  RESTClientLib.Types;

{$IFDEF RESTClientLib_SYNAPSE}

{$REGION 'TResponseSynapse'}
constructor TResponseSynapse.Create(pRESTClientLib: IRESTClientLib;
  const pHTTPSend: THTTPSend; const pRequestTime: Int64;
  const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pRequestTime);

  FVersionHTTP := Format('HTTP/%s', [pHTTPSend.Protocol]);
  FStatusCode := pHTTPSend.ResultCode;
  FStatusText := pHTTPSend.ResultString;

  Debug('Response: Version HTTP ( %s )', [FVersionHTTP]);
  Debug('Response: Status Code ( %d )', [FStatusCode]);
  Debug('Response: Status Text ( %s )', [FStatusText]);

  FHeaders := TResponseHeadersSynapse.Create(pRESTClientLib, Self, pHTTPSend, pRequestMethod);
  FCookies := TResponseCookiesSynapse.Create(pRESTClientLib, Self, pHTTPSend, pRequestMethod);
  FBody := TResponseBodySynapse.Create(pRESTClientLib, Self, pHTTPSend, pRequestMethod);
end;
{$ENDREGION}

{$REGION 'TResponseHeadersSynapse'}
constructor TResponseHeadersSynapse.Create(pRESTClientLib: IRESTClientLib;
  pResponse: IResponse; const pHTTPSend: THTTPSend;
  const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPSend := pHTTPSend;
  FHTTPSend.Headers.CaseSensitive := False;

  Process;
end;

procedure TResponseHeadersSynapse.Process;
var
  I: Integer;
  lName: string;
  lValue: string;
begin
  Debug('Response: Get %s', ['Headers']);

  FFields.Clear;
  for I := 0 to Pred(FHTTPSend.Headers.Count) do
  begin
    lName := Trim(FHTTPSend.Headers.Names[I]);
    lValue := Trim(FHTTPSend.Headers.ValueFromIndex[I]);
    if ((lName = EmptyStr) or SameText(lName, 'Set-Cookie')) then
      Continue;
    FFields.AddOrSetValue(lName, lValue);
    Debug('Response: Headers ( %s: %s)', [lName, lValue]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseCookiesSynapse'}
constructor TResponseCookiesSynapse.Create(pRESTClientLib: IRESTClientLib;
  pResponse: IResponse; const pHTTPSend: THTTPSend;
  const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPSend := pHTTPSend;

  Process;
end;

procedure TResponseCookiesSynapse.Process;
var
  I: Integer;
  lName: string;
  lValue: string;
begin
  Debug('Response: Get %s', ['Cookies']);

  FCookies.Clear;
  for I := 0 to Pred(FHTTPSend.Cookies.Count) do
  begin
    lName := Trim(FHTTPSend.Cookies.Names[I]);
    lValue := Trim(FHTTPSend.Cookies.ValueFromIndex[I]);
    if (lName = EmptyStr) then
      Continue;
    FCookies.AddOrSetValue(lName, lValue);
    Debug('Response: Cookies ( %s=%s)', [lName, lValue]);
  end;
end;
{$ENDREGION}

{$REGION 'TResponseBodySynapse'}
constructor TResponseBodySynapse.Create(pRESTClientLib: IRESTClientLib;
  pResponse: IResponse; const pHTTPSend: THTTPSend;
  const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  FHTTPSend := pHTTPSend;

  Process;
end;

function TResponseBodySynapse.GetContentEncoding: string;
begin
  Result := Trim(FHTTPSend.Headers.Values['Content-Encoding']);
end;

function TResponseBodySynapse.GetContentType: string;
begin
  Result := Trim(FHTTPSend.MimeType);
end;

procedure TResponseBodySynapse.Process;
var
  lContentType: string;
  lContentDecompression: TBytes;
  lContentDecompressionOk: Boolean;
begin
  Debug('Response: Get %s', ['Body']);

  lContentType := GetContentType;
  FMIMEType := THeadersUtils.ExtractContentType(lContentType);
  FCharSet := THeadersUtils.ExtractCharsetContentType(lContentType);
  TRESTClientLibMimeTypes.FromContentType(FMIMEType, FMIMETypeExt, FIsBinary);
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
    TRESTClientLibContentCompressionKind.Deflate: lContentDecompressionOk := TZLibUtils.DecompressionDeflate(FHTTPSend.Document, lContentDecompression);
    TRESTClientLibContentCompressionKind.Gzip: lContentDecompressionOk := TZLibUtils.DecompressionGZip(FHTTPSend.Document, lContentDecompression);
  end;

  FHTTPSend.Document.Position := 0;
  if lContentDecompressionOk then
    FBody := TBytesStream.Create(lContentDecompression)
  else
  begin
    FBody := TStringStream.Create;
    FBody.LoadFromStream(FHTTPSend.Document);
  end;

  FBody.Position := 0;
  if (FBody.Size > 0) then
    Debug('Response Body: Size ( %d )', [FBody.Size])
  else
    Debug('Response Body: Size ( %s )', ['empty']);
end;
{$ENDREGION}

{$ENDIF RESTClientLib_SYNAPSE}

end.
