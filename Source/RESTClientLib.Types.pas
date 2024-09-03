{******************************************************************************}
{                                                                              }
{           RESTClientLib.Types.pas                                            }
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
unit RESTClientLib.Types;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Rtti;

type

  {$SCOPEDENUMS ON}
  TRESTClientLibExceptionKind = (E_UNKNOWN,
                                 E_OTHERS,
                                 E_REQUEST_FAIL,
                                 E_REQUEST_VALIDATION);

  TRESTClientLibRequestLibraryKind = (NetHTTP,
                                      Indy
                                      {$IFDEF RESTClientLib_SYNAPSE},Synapse{$ENDIF RESTClientLib_SYNAPSE});

  TRESTClientLibRequestMethodKind = (GET,
                                     POST,
                                     PUT,
                                     PATCH,
                                     DELETE,
                                     MERGE,
                                     HEAD,
                                     OPTIONS,
                                     TRACE);

  TRESTClientLibContentCompressionKind = (Unknown,
                                          Deflate,
                                          Gzip);
  {$SCOPEDENUMS OFF}

  TRESTClientLibHeaderOptionKind = (hoRequestID,
                                    hoRequestTime,
                                    hoRequestPlatform,
                                    hoRequestLib);
  TRESTClientLibHeaderOptions = set of TRESTClientLibHeaderOptionKind;

  TRESTClientLibExceptionKindHelper = record helper for TRESTClientLibExceptionKind
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsInteger: Integer;
    function AsString: string;
  end;

  TRESTClientLibRequestLibraryKindHelper = record helper for TRESTClientLibRequestLibraryKind
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsInteger: Integer;
    function AsString: string;
  end;

  TRESTClientLibRequestMethodKindHelper = record helper for TRESTClientLibRequestMethodKind
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsInteger: Integer;
    function AsString: string;
  end;

  TRESTClientLibContentCompressionKindHelper = record helper for TRESTClientLibContentCompressionKind
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsInteger: Integer;
    function AsString: string;
  end;

  TRequestRetries = class sealed
  private
    { private declarations }
    FDelayInMilliseconds: Integer;
    FTries: Integer;
    procedure SetDelayInMilliseconds(const Value: Integer);
    procedure SetTries(const Value: Integer);
  protected
    { protected declarations }
  public
    { public declarations }
    property Tries: Integer read FTries write SetTries;
    property DelayInMilliseconds: Integer read FDelayInMilliseconds write SetDelayInMilliseconds;
  end;

  ERESTClientLib = class(Exception)
  private
    { private declarations }
    FRequestLibrary: TRESTClientLibRequestLibraryKind;
    FType: TRESTClientLibExceptionKind;
    FTitle: string;
    FHint: string;
    FURL: string;
    FRequestMethod: string;
    FClassName: string;
    constructor Create(const RequestLibrary: TRESTClientLibRequestLibraryKind); reintroduce;
  protected
    { protected declarations }
  public
    { public declarations }
    function RequestLibrary: TRESTClientLibRequestLibraryKind;
    function &Type: TRESTClientLibExceptionKind; overload;
    function &Type(const Value: TRESTClientLibExceptionKind): ERESTClientLib; overload;
    function Title: string; overload;
    function Title(const Value: string): ERESTClientLib; overload;
    function Title(const Format: string; const Values: array of const): ERESTClientLib; overload;
    function Error: string; overload;
    function Error(const Value: string): ERESTClientLib; overload;
    function Error(const Format: string; const Values: array of const): ERESTClientLib; overload;
    function Hint: string; overload;
    function Hint(const Value: string): ERESTClientLib; overload;
    function Hint(const Format: string; const Values: array of const): ERESTClientLib; overload;
    function ClassName: string; overload;
    function ClassName(const Value: string): ERESTClientLib; overload;
    function URL: string; overload;
    function URL(const Value: string): ERESTClientLib; overload;
    function RequestMethod: string; overload;
    function RequestMethod(const Value: string): ERESTClientLib; overload;
    function ToString: string; override;
    class function Build(const RequestLibrary: TRESTClientLibRequestLibraryKind): ERESTClientLib;
  end;

  TInterfacedObjectCustom = class(TInterfacedObject)
  private
    { private declarations }
  protected
    { protected declarations }
    function DebugLib: Boolean; virtual; abstract;
  public
    { public declarations }
    procedure Debug(const pFormat: string; const pArgs: array of const);
  end;

  TCookiesValues = TArray<TPair<string, string>>;
  TParamsValues = TArray<TPair<string, TValue>>;
  THeadersValues = TArray<TPair<string, string>>;

  function RequestLibraryFromString(const RequestLibrary: string): TRESTClientLibRequestLibraryKind;
  function RequestMethodFromString(const Method: string): TRESTClientLibRequestMethodKind;
  function ContentCompressionFromString(const ContentCompression: string): TRESTClientLibContentCompressionKind;

implementation

uses
  RESTClientLib.Utils, System.TypInfo;

function RequestLibraryFromString(const RequestLibrary: string): TRESTClientLibRequestLibraryKind;
begin
  Result := TRESTClientLibRequestLibraryKind(GetEnumValue(TypeInfo(TRESTClientLibRequestLibraryKind), RequestLibrary));
end;

function RequestMethodFromString(const Method: string): TRESTClientLibRequestMethodKind;
begin
  Result := TRESTClientLibRequestMethodKind(GetEnumValue(TypeInfo(TRESTClientLibRequestMethodKind), Method));
end;

function ContentCompressionFromString(const ContentCompression: string): TRESTClientLibContentCompressionKind;
var
  lGetEnumValue: Integer;
begin
  Result := TRESTClientLibContentCompressionKind.Unknown;
  lGetEnumValue := GetEnumValue(TypeInfo(TRESTClientLibContentCompressionKind), ContentCompression);
  if (lGetEnumValue > -1) then
    Result := TRESTClientLibContentCompressionKind(lGetEnumValue);
end;

{$REGION 'TRESTClientLibExceptionKindHelper'}
function TRESTClientLibExceptionKindHelper.AsInteger: Integer;
begin
  Result := Ord(Self);
end;

function TRESTClientLibExceptionKindHelper.AsString: string;
begin
  case Self of
    TRESTClientLibExceptionKind.E_UNKNOWN: Result := 'E_UNKNOWN';
    TRESTClientLibExceptionKind.E_OTHERS: Result := 'E_OTHERS';
    TRESTClientLibExceptionKind.E_REQUEST_FAIL: Result := 'E_REQUEST_FAIL';
    TRESTClientLibExceptionKind.E_REQUEST_VALIDATION: Result := 'E_REQUEST_VALIDATION';
  end;
end;
{$ENDREGION}

{$REGION 'TRESTClientLibRequestLibraryKindHelper'}
function TRESTClientLibRequestLibraryKindHelper.AsInteger: Integer;
begin
  Result := Ord(Self);
end;

function TRESTClientLibRequestLibraryKindHelper.AsString: string;
begin
  case Self of
    TRESTClientLibRequestLibraryKind.NetHTTP: Result := 'NetHTTP';
    TRESTClientLibRequestLibraryKind.Indy: Result := 'Indy';
    {$IFDEF RESTClientLib_SYNAPSE}TRESTClientLibRequestLibraryKind.Synapse: Result := 'Synapse';{$ENDIF RESTClientLib_SYNAPSE}
  end;
end;
{$ENDREGION}

{$REGION 'TRESTClientLibRequestMethodKindHelper'}
function TRESTClientLibRequestMethodKindHelper.AsInteger: Integer;
begin
  Result := Ord(Self);
end;

function TRESTClientLibRequestMethodKindHelper.AsString: string;
begin
  case Self of
    TRESTClientLibRequestMethodKind.GET: Result := 'GET';
    TRESTClientLibRequestMethodKind.POST: Result := 'POST';
    TRESTClientLibRequestMethodKind.PUT: Result := 'PUT';
    TRESTClientLibRequestMethodKind.PATCH: Result := 'PATCH';
    TRESTClientLibRequestMethodKind.DELETE: Result := 'DELETE';
    TRESTClientLibRequestMethodKind.MERGE: Result := 'MERGE';
    TRESTClientLibRequestMethodKind.HEAD: Result := 'HEAD';
    TRESTClientLibRequestMethodKind.OPTIONS: Result := 'OPTIONS';
    TRESTClientLibRequestMethodKind.TRACE: Result := 'TRACE';
  end;
end;
{$ENDREGION}

{$REGION 'TRESTClientLibContentCompressionKindHelper'}
function TRESTClientLibContentCompressionKindHelper.AsInteger: Integer;
begin
  Result := Ord(Self);
end;

function TRESTClientLibContentCompressionKindHelper.AsString: string;
begin
  //https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding
  case Self of
    TRESTClientLibContentCompressionKind.Unknown: Result := 'Unknown';
    TRESTClientLibContentCompressionKind.Deflate: Result := 'Deflate';
    TRESTClientLibContentCompressionKind.Gzip: Result := 'Gzip';
  end;
end;
{$ENDREGION}

{$REGION 'ERESTClientLib'}
constructor ERESTClientLib.Create(const RequestLibrary: TRESTClientLibRequestLibraryKind);
begin
  inherited Create(EmptyStr);
  FRequestLibrary := RequestLibrary;
end;

class function ERESTClientLib.Build(const RequestLibrary: TRESTClientLibRequestLibraryKind): ERESTClientLib;
begin
  Result := Create(RequestLibrary);
end;

function ERESTClientLib.ClassName: string;
begin
  Result := FClassName;
end;

function ERESTClientLib.ClassName(const Value: string): ERESTClientLib;
begin
  Result := Self;
  FClassName := Value;
end;

function ERESTClientLib.Error: string;
begin
  Result := Self.Message;
end;

function ERESTClientLib.Error(const Value: string): ERESTClientLib;
begin
  Result := Self;
  Self.Message := Value;
end;

function ERESTClientLib.Error(const Format: string; const Values: array of const): ERESTClientLib;
begin
  Result := Self;
  Self.Message := System.SysUtils.Format(Format, Values, FormatSettings);
end;

function ERESTClientLib.Hint(const Value: string): ERESTClientLib;
begin
  Result := Self;
  FHint := Value;
end;

function ERESTClientLib.Hint(const Format: string; const Values: array of const): ERESTClientLib;
begin
  Result := Self;
  FHint := System.SysUtils.Format(Format, Values, FormatSettings);
end;

function ERESTClientLib.RequestLibrary: TRESTClientLibRequestLibraryKind;
begin
  Result := FRequestLibrary;
end;

function ERESTClientLib.RequestMethod(const Value: string): ERESTClientLib;
begin
  Result := Self;
  FRequestMethod := Value;
end;

function ERESTClientLib.RequestMethod: string;
begin
  Result := FRequestMethod;
end;

function ERESTClientLib.Hint: string;
begin
  Result := FHint;
end;

function ERESTClientLib.Title(const Value: string): ERESTClientLib;
begin
  Result := Self;
  FTitle := Trim(Value);
end;

function ERESTClientLib.Title(const Format: string; const Values: array of const): ERESTClientLib;
begin
  Result := Self;
  FTitle := System.SysUtils.Format(Format, Values, FormatSettings);
end;

function ERESTClientLib.Title: string;
begin
  Result := FTitle;
end;

function ERESTClientLib.&Type(const Value: TRESTClientLibExceptionKind): ERESTClientLib;
begin
  Result := Self;
  FType := Value;
end;

function ERESTClientLib.&Type: TRESTClientLibExceptionKind;
begin
  Result := FType;
end;

function ERESTClientLib.URL: string;
begin
  Result := FURL;
end;

function ERESTClientLib.URL(const Value: string): ERESTClientLib;
begin
  Result := Self;
  FURL := Value;
end;

function ERESTClientLib.ToString: string;
var
  lResult: TStringBuilder;
begin
  Result := EmptyStr;

  lResult := TStringBuilder.Create;
  try
    lResult.AppendFormat('Title: %s%s', [Self.Title, sLineBreak]);
    lResult.AppendFormat('Error: %s%s', [Self.Error, sLineBreak]);
    lResult.AppendFormat('Hint: %s%s', [Self.Hint, sLineBreak]);
    lResult.AppendFormat('Type: %s%s', [Self.&Type.AsString, sLineBreak]);
    lResult.AppendFormat('Class Name: %s%s', [Self.ClassName, sLineBreak]);
    lResult.AppendFormat('Request Library: %s%s', [Self.RequestLibrary.AsString, sLineBreak]);
    lResult.AppendFormat('Request Method: %s%s', [Self.RequestMethod, sLineBreak]);
    lResult.AppendFormat('URL: %s', [Self.URL]);

    Result := lResult.ToString;
    TDebugger.Debug(Result);
  finally
    lResult.Free;
  end;
end;
{$ENDREGION}

{$REGION 'TRequestRetries'}
procedure TRequestRetries.SetDelayInMilliseconds(const Value: Integer);
begin
  FDelayInMilliseconds := Value;
end;

procedure TRequestRetries.SetTries(const Value: Integer);
begin
  FTries := Value;
end;
{$ENDREGION}

{$REGION 'TInterfacedObjectCustom'}
procedure TInterfacedObjectCustom.Debug(const pFormat: string; const pArgs: array of const);
begin
  if DebugLib then
    TDebugger.Debug(pFormat, pArgs);
end;
{$ENDREGION}

end.
