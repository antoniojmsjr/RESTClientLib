{******************************************************************************}
{                                                                              }
{           RESTClientLib.Utils.pas                                            }
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
unit RESTClientLib.Utils;

interface

uses
  System.Classes, System.JSON, System.SysUtils;

type
  TDebugger = class sealed
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure Debug(const pFormat: string; const pArgs: array of const); overload;
    class procedure Debug(const pMessage: string); overload;
  end;

  THeadersUtils = class sealed
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function ExtractCharsetContentType(const pContentType: string): string;
    class function ExtractContentType(const pContentType: string): string;
    class function MakeContentTypeValue(const pContentType: string; const pEncoding: TEncoding): string;
  end;

  TJSONUtils = class sealed
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function ToString(const pJSON: TJSONValue; const pEncoding: TEncoding): string; reintroduce;
    class function ToBytes(const pJSON: TJSONValue; const pEncoding: TEncoding): TBytes;
    class function ToJSONValue(const pJSON: TBytes; const pSize: Int64; const pEncoding: TEncoding): TJSONValue; overload;
    class function ToJSONValue(const pJSON: string; const pEncoding: TEncoding): TJSONValue; overload;
  end;

  TExceptionUtils = class sealed
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function TranslateErrorMsg(const pException: string): string;
  end;

  TZLibUtils = class sealed
  private
    { private declarations }
    class function Decompression(pInput: TStream; const pWindowBits: Integer; var pOutput: TBytes): Boolean; static;
  protected
    { protected declarations }
  public
    { public declarations }
    class function DecompressionDeflate(pInput: TStream; var pOutput: TBytes): Boolean;
    class function DecompressionGZip(pInput: TStream; var pOutput: TBytes): Boolean;
  end;

implementation

uses
  {$IFNDEF MSWINDOWS} FMX.Types, {$ENDIF} Winapi.Windows,
  System.RegularExpressions, System.ZLib;

{ TDebugger }

class procedure TDebugger.Debug(const pMessage: string);
var
  lHour: Word;
  lMin: Word;
  lSec: Word;
  lMSec: Word;
  lText: string;
begin
  DecodeTime(Time, lHour, lMin, lSec, lMSec);
  lText := Format('%.2d:%.2d:%.2d.%.2d=%s', [lHour, lMin, lSec, lMSec, pMessage]);

  {$IFDEF MSWINDOWS}
  Winapi.Windows.OutputDebugString(PWideChar(lText));
  {$ELSE}
  FMX.Types.Log.d(lText);
  {$ENDIF}
end;

class procedure TDebugger.Debug(const pFormat: string; const pArgs: array of const);
var
  lText: string;
begin
  lText := System.SysUtils.Format(pFormat, pArgs, FormatSettings);
  Debug(lText);
end;

{ TJSONUtils }

class function TJSONUtils.ToBytes(const pJSON: TJSONValue; const pEncoding: TEncoding): TBytes;
begin
  Result := pEncoding.GetBytes(pJSON.ToString);
end;

class function TJSONUtils.ToJSONValue(const pJSON: TBytes; const pSize: Int64; const pEncoding: TEncoding): TJSONValue;
var
  lJSONString: string;
begin
  Result := nil;
  if (not Assigned(pEncoding) or (Length(pJSON) = 0)) then
    Exit;

  lJSONString := pEncoding.GetString(pJSON, 0, pSize);
  Result := TJSONUtils.ToJSONValue(lJSONString, pEncoding);
end;

class function TJSONUtils.ToJSONValue(const pJSON: string; const pEncoding: TEncoding): TJSONValue;
var
  {$IF CompilerVersion >= 33}
  lJSONParseOptions: TJSONObject.TJSONParseOptions;
  {$ENDIF}
  lJSONBytes: TBytes;
begin
  Result := nil;
  if (not Assigned(pEncoding) or (Length(pJSON) = 0)) then
    Exit;

  lJSONBytes := pEncoding.GetBytes(pJSON);

  {$IF CompilerVersion >= 33}
  lJSONParseOptions := [];
  Include(lJSONParseOptions, TJSONObject.TJSONParseOption.UseBool);
  Include(lJSONParseOptions, TJSONObject.TJSONParseOption.RaiseExc);
  // UTF-8?
  if (pEncoding.CodePage = CP_UTF8) then
    Include(lJSONParseOptions, TJSONObject.TJSONParseOption.IsUTF8);
  Result := TJSONObject.ParseJSONValue(lJSONBytes, 0, Length(lJSONBytes), lJSONParseOptions);
  {$ELSE}
  if (pEncoding.CodePage = CP_UTF8) then
    Result := TJSONObject.ParseJSONValue(lJSONBytes, 0, Length(lJSONBytes), True)
  else
    Result := TJSONObject.ParseJSONValue(lJSONBytes, 0, Length(lJSONBytes), False);
  {$ENDIF}
end;

class function TJSONUtils.ToString(const pJSON: TJSONValue; const pEncoding: TEncoding): string;
// Refer: System.JSON.ToJSON: string;
var
  lBytes: TBytes;
begin
  Result := EmptyStr;
  if not Assigned(pJSON) or not Assigned(pEncoding) then
    Exit;

  SetLength(lBytes, pJSON.EstimatedByteSize);
  SetLength(lBytes, pJSON.ToBytes(lBytes, 0));
  Result := pEncoding.GetString(lBytes);
end;

{ THeadersUtils }

class function THeadersUtils.MakeContentTypeValue(const pContentType: string; const pEncoding: TEncoding): string;
begin
  Result := Format('%s', [pContentType]);
  if Assigned(pEncoding) then
  {$IF CompilerVersion >= 33}
    Result := Format('%s; charset=%s', [pContentType, pEncoding.MIMEName]);
  {$ELSE}
    Result := Format('%s; charset=%s', [pContentType, pEncoding.EncodingName]);
  {$ENDIF}
end;

class function THeadersUtils.ExtractCharsetContentType(const pContentType: string): string;
var
  lRegex: TRegEx;
  lMatch: TMatch;
begin
  Result := EmptyStr;

  lRegex := TRegEx.Create('charset\s*=\s*"?([^";\s]+)"?', [roIgnoreCase]);
  lMatch := lRegex.Match(pContentType);
  if lMatch.Success then
    Result := lMatch.Groups[1].Value;
end;

class function THeadersUtils.ExtractContentType(const pContentType: string): string;
var
  lRegex: TRegEx;
  lMatch: TMatch;
begin
  Result := EmptyStr;

  lRegex := TRegEx.Create('^([\w\/\+-]+)', [roIgnoreCase]);
  lMatch := lRegex.Match(pContentType);
  if lMatch.Success then
    Result := lMatch.Groups[1].Value;
end;

{ TExceptionUtils }

class function TExceptionUtils.TranslateErrorMsg(const pException: string): string;
begin
  Result := StringReplace(pException, sLineBreak, ' ', [rfReplaceAll, rfIgnoreCase]);
end;

{ TZLibUtils }

class function TZLibUtils.Decompression(pInput: TStream; const pWindowBits: Integer; var pOutput: TBytes): Boolean;
var
  lZDecompressionStream: TZDecompressionStream;
  lOutput: TBytesStream;
begin
  pInput.Position := 0;
  lZDecompressionStream := TZDecompressionStream.Create(pInput, pWindowBits);
  try
    lOutput := TBytesStream.Create;
    try
      lZDecompressionStream.Position := 0;
      lOutput.LoadFromStream(lZDecompressionStream);
      lOutput.Position := 0;

      SetLength(pOutput, 0);
      pOutput := Copy(lOutput.Bytes, 0, lOutput.Size);
      Result := (Length(pOutput) > 0);
    finally
      lOutput.Free;
    end;
  finally
    lZDecompressionStream.Free;
  end;
end;

class function TZLibUtils.DecompressionDeflate(pInput: TStream; var pOutput: TBytes): Boolean;
begin
  Result := Decompression(pInput, 15, pOutput);
end;

class function TZLibUtils.DecompressionGZip(pInput: TStream; var pOutput: TBytes): Boolean;
begin
  Result := Decompression(pInput, 31, pOutput);
end;

end.
