{******************************************************************************}
{                                                                              }
{           RESTClientLib.Core.pas                                             }
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
unit RESTClientLib.Core;

interface

uses
  System.Net.URLClient, System.Classes, System.JSON, System.Rtti, System.SysUtils,
  System.Generics.Collections, RESTClientLib.Types, RESTClientLib.Net.Mime,
  RESTClientLib.Interfaces;

type
  TEncodingHelper = class helper for TEncoding
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function EncodingText: string;
  end;

  TRequestEncoding = class(TInterfacedObjectCustom, IRequestEncoding)
  private
    { private declarations }
    [Weak] FRequestOptions: IRequestOptions;
    [Weak] FRESTClientLib: IRESTClientLib;
    FEncoding: TEncoding;
    function Reset: IRequestEncoding;
    function Encoding: TEncoding; overload;
    function Encoding(const pEncoding: TEncoding): IRequestEncoding; overload;
    function Encoding(const pCodePage: Integer): IRequestEncoding; overload;
    function Encoding(const pCharset: string): IRequestEncoding; overload;
    function &End: IRequestOptions;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions); reintroduce;
    destructor Destroy; override;
  end;

  TRequestCertificate = class(TInterfacedObjectCustom, IRequestCertificate)
  private
    { private declarations }
    [Weak] FRequestOptions: IRequestOptions;
    [Weak] FRESTClientLib: IRESTClientLib;
    FCertFile: string;
    FKeyFile: string;
    function Reset: IRequestCertificate;
    function CertFile: string; overload;
    function CertFile(const pValue: string): IRequestCertificate; overload;
    function KeyFile: string; overload;
    function KeyFile(const pValue: string): IRequestCertificate; overload;
    function &End: IRequestOptions;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions); reintroduce;
  end;

  TRequestRedirects = class(TInterfacedObjectCustom, IRequestRedirects)
  private
    { private declarations }
    [Weak] FRequestOptions: IRequestOptions;
    [Weak] FRESTClientLib: IRESTClientLib;
    FActive: Boolean;
    FMaxRedirects: Integer;
    function Reset: IRequestRedirects;
    function Active: Boolean; overload;
    function Active(const pValue: Boolean): IRequestRedirects; overload;
    function MaxRedirects: Integer; overload;
    function MaxRedirects(const pValue: Integer): IRequestRedirects; overload;
    function &End: IRequestOptions;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions); reintroduce;
  end;

  TRequestProxy = class(TInterfacedObjectCustom, IRequestProxy)
  private
    { private declarations }
    [Weak] FRequestOptions: IRequestOptions;
    [Weak] FRESTClientLib: IRESTClientLib;
    FServer: string;
    FPort: Integer;
    FUser: string;
    FPassword: string;
    function Reset: IRequestProxy;
    function Server: string; overload;
    function Server(const pValue: string): IRequestProxy; overload;
    function Port: Integer; overload;
    function Port(const pValue: Integer): IRequestProxy; overload;
    function User: string; overload;
    function User(const pValue: string): IRequestProxy; overload;
    function Password: string; overload;
    function Password(const pValue: string): IRequestProxy; overload;
    function &End: IRequestOptions;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions); reintroduce;
  end;

  TRequestOptions = class(TInterfacedObjectCustom, IRequestOptions)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FRequestCertificate: IRequestCertificate;
    FRequestEncoding: IRequestEncoding;
    FRequestProxy: IRequestProxy;
    FRequestRedirects: IRequestRedirects;
    FHeaderOptions: TRESTClientLibHeaderOptions;
    FRequestTimeout: Integer;
    FResponseTimeout: Integer;
    FRequestRetries: TRequestRetries;
    function Reset: IRequestOptions;
    function Certificate: IRequestCertificate;
    function Encoding: IRequestEncoding;
    function HeaderOptions: TRESTClientLibHeaderOptions; overload;
    function HeaderOptions(const pHeaderOptions: TRESTClientLibHeaderOptions): IRequestOptions; overload;
    function Proxy: IRequestProxy;
    function Redirects: IRequestRedirects;
    function RequestTimeout: Integer; overload;
    function RequestTimeout(const pValue: Integer): IRequestOptions; overload;
    function ResponseTimeout: Integer; overload;
    function ResponseTimeout(const pValue: Integer): IRequestOptions; overload;
    function Retries(const pTries: Integer; const pDelayInMilliseconds: Integer = 1000): IRequestOptions; overload;
    function Retries: TRequestRetries; overload;
    function &End: IRESTClientLib;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

  TRequestParamsCustom = class(TInterfacedObjectCustom, IRequestParams)
  private
    { private declarations }
    FParams: TDictionary<string, TValue>;
    function Clear: IRequestParams;
    function Find(const pName: string): TValue;
    function Contains(const pName: string): Boolean;
    function Remove(const pName: string): IRequestParams;
    function Params: TParamsValues;
    function &End: IRequestURL;
  protected
    { protected declarations }
    [Weak] FRequestURL: IRequestURL;
    [Weak] FRESTClientLib: IRESTClientLib;
    function DebugLib: Boolean; override;
    function Add(const pName: string; const pValue: TValue): IRequestParams; virtual; abstract;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pRequestURL: IRequestURL); reintroduce;
    destructor Destroy; override;
  end;

  TRequestPathParams = class(TRequestParamsCustom)
  private
    { private declarations }
  protected
    { protected declarations }
    function Add(const pName: string; const pValue: TValue): IRequestParams; override;
  public
    { public declarations }
    class function MakeParam(const pURL: string; const pName: string; const pValue: TValue): string;
  end;

  TRequestQueryParams = class(TRequestParamsCustom)
  private
    { private declarations }
  protected
    { protected declarations }
    function Add(const pName: string; const pValue: TValue): IRequestParams; override;
  public
    { public declarations }
  end;

  TRequestURL = class(TInterfacedObjectCustom, IRequestURL)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FPathParams: IRequestParams;
    FQueryParams: IRequestParams;
    FBaseURL: string;
    FResource: string;
    function Reset: IRequestURL;
    function BaseURL: string; overload;
    function BaseURL(const pValue: string): IRequestURL; overload;
    function Resource: string; overload;
    function Resource(const pValue: string): IRequestURL; overload;
    function FullURL: string;
    function FullURLWithoutQueryParams: string;
    function PathParams: IRequestParams;
    function QueryParams: IRequestParams;
    function &End: IRESTClientLib;
    function MakeURL: string;
    function MakeURLWithoutQueryParams: string;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

  TRequestAuthentication = class(TInterfacedObjectCustom, IRequestAuthentication)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    function Reset: IRequestAuthentication;
    function Basic(const pUser: string; const pPassword: string): IRESTClientLib;
    function Bearer(const pToken: string): IRESTClientLib;
    function Token(const pToken: string): IRESTClientLib;
    function MakeBasic(const pUser: string; const pPassword: string): string;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
  end;

  TRequestHeaders = class(TInterfacedObjectCustom, IRequestHeaders)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FFields: TDictionary<string, string>;
    FConnectionKeepAlive: Boolean;
    function Reset: IRequestHeaders;
    function Add(const pName: string; const pValue: string; const pEncode: Boolean = False): IRequestHeaders;
    function Find(const pName: string): string;
    function Contains(const pName: string): Boolean;
    function Remove(const pName: string): IRequestHeaders;
    function Headers: THeadersValues;
    function Accept: string; overload;
    function Accept(const pValue: string): IRequestHeaders; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const pValue: string): IRequestHeaders; overload;
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const pValue: string): IRequestHeaders; overload;
    function AcceptLanguage: string; overload;
    function AcceptLanguage(const pValue: string): IRequestHeaders; overload;
    function CacheControl: string; overload;
    function CacheControl(const pValue: string): IRequestHeaders; overload;
    function ConnectionKeepAlive: Boolean; overload;
    function ConnectionKeepAlive(const pValue: Boolean): IRequestHeaders; overload;
    function ContentEncoding: string; overload;
    function ContentEncoding(const pValue: string): IRequestHeaders; overload;
    function ContentLanguage: string; overload;
    function ContentLanguage(const pValue: string): IRequestHeaders; overload;
    function ContentType: string; overload;
    function ContentType(const pValue: string): IRequestHeaders; overload;
    function ContentType(const pValue: string; const pEncoding: TEncoding): IRequestHeaders; overload;
    function IfNoneMatch: string; overload;
    function IfNoneMatch(const pValue: string): IRequestHeaders; overload;
    function Referer: string; overload;
    function Referer(const pValue: string): IRequestHeaders; overload;
    function RequestID: string;
    function RequestTime: string;
    function RequestLib: string;
    function RequestPlatform: string;
    function UserAgent: string; overload;
    function UserAgent(const pValue: string): IRequestHeaders; overload;
    function &End: IRESTClientLib;
    procedure Default;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

  TRequestCookies = class(TInterfacedObjectCustom, IRequestCookies)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FCookies: TDictionary<string, string>;
    function Reset: IRequestCookies;
    function Cookies(const pCookies: TStrings; const pEncode: Boolean = False): IRequestCookies; overload;
    function Cookies: TCookiesValues; overload;
    function Add(const pName: string; const pValue: string; const pEncode: Boolean = False): IRequestCookies; overload;
    function Find(const pName: string): string;
    function Contains(const pName: string): Boolean;
    function Remove(const pName: string): IRequestCookies;
    function ToLine: string;
    function &End: IRESTClientLib;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

 TRequestMultipartFormData = class(TInterfacedObjectCustom, IRequestMultipartFormData)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FMultipartFormData: TMultipartFormData;
    function Reset: IRequestMultipartFormData;
    function Content: TStream;
    function ContentType: string;
    function UseMultipartFormData: Boolean;
    function Field(const pFieldName: string; const pValue: string): IRequestMultipartFormData; overload;
    function Field(const pFieldName: string; const pValue: TStream; const pContentType: string = ''; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: string): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: TBytes; const pSize: Int64): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: TObject; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: TJSONObject; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: TJSONArray; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const pFieldName: string; const pValue: TJSONValue; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function LoadFromFile(const pFieldName: string; const pFilePath: string): IRequestMultipartFormData; overload;
    function LoadFromFile(const pFieldName: string; const pFileName: string; const pValue: TStream; const pOwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function &End: IRESTClientLib;
    procedure CheckField(const pFieldName: string); overload;
    procedure CheckField(const pFunction: string; const pFieldName: string; pValue: TObject); overload;
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

  TRequestBody = class(TInterfacedObjectCustom, IRequestBody)
  private
    { private declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    FBody: TStringStream;
    function Reset: IRequestBody;
    function Content: TStream; overload;
    function Content(const pValue: string): IRESTClientLib; overload;
    function Content(const pValue: TStream; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const pValue: string): IRESTClientLib; overload;
    function JSON(const pValue: TBytes; const pSize: Int64): IRESTClientLib; overload;
    function JSON(const pValue: TJSONObject; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const pValue: TJSONArray; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const pValue: TJSONValue; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const pValue: TObject; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    function LoadFromFile(const pFilePath: string): IRESTClientLib; overload;
    function LoadFromFile(const pFileName: string; const pValue: TStream; const pOwnsObject: Boolean = True): IRESTClientLib; overload;
    procedure CheckValue(const pFunction: string; const pValue: TObject);
  protected
    { protected declarations }
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce;
    destructor Destroy; override;
  end;

  TRequestExecuteCustom = class(TInterfacedObjectCustom, IRequestExecute)
  private
    { private declarations }
    function Get: IResponse;
    function Post: IResponse;
    function Put: IResponse;
    function Patch: IResponse;
    function Delete: IResponse;
    function Merge: IResponse;
    function Head: IResponse;
    function Options: IResponse;
    function Trace: IResponse;
    function FromString(const pMethod: string): IResponse;
    function FromType(const pMethod: TRESTClientLibRequestMethodKind): IResponse;
    function GetHeaderRequestID: string;
    function GetHeaderRequestTime: string;
    function GetHeaderPlatform: string;
    function GetHeaderRequestLib: string;
    procedure SetHeaderCustom;
  protected
    { protected declarations }
    [Weak] FRESTClientLib: IRESTClientLib;
    function DebugLib: Boolean; override;
    function Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse; virtual;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib); reintroduce; virtual;
  end;

  TResponseCustom = class(TInterfacedObjectCustom, IResponse)
  private
    { private declarations }
    FDebugLib: Boolean;
    FRequestTime: Int64;
    FRequestURL: string;
    function GetHeaders: IResponseHeaders;
    function GetCookies: IResponseCookies;
    function GetBody: IResponseBody;
    function GetRequestTimeAsString: string;
    function GetRequestTime: Int64;
    function GetStatusCode: Integer;
    function GetStatusCodeAsString: string;
    function GetStatusText: string;
    function GetVersionHTTP: string;
    function GetURL: string;
  protected
    { protected declarations }
    FHeaders: IResponseHeaders;
    FCookies: IResponseCookies;
    FBody: IResponseBody;
    FStatusCode: Integer;
    FStatusText: string;
    FVersionHTTP: string;
    function DebugLib: Boolean; override;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; const pRequestTime: Int64); reintroduce;
  end;

  TResponseProcess = class(TInterfacedObjectCustom)
  private
    { private declarations }
    FDebugLib: Boolean;
  protected
    { protected declarations }
    [weak] FResponse: IResponse;
    FRequestLibrary: TRESTClientLibRequestLibraryKind;
    FRequestMethod: string;
    FRequestURL: string;
    function DebugLib: Boolean; override;
    procedure Process; virtual; abstract;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string); reintroduce; virtual;
  end;

  TResponseHeaders = class(TResponseProcess, IResponseHeaders)
  private
    { private declarations }
    function Find(const pName: string): string;
    function Contains(const pName: string): Boolean;
    function AccessControlAllowOrigin: string;
    function Age: string;
    function CacheControl: string;
    function Connection: string;
    function ContentEncoding: string;
    function ContentLength: Int64;
    function ContentType: string;
    function ContentDisposition: string;
    function Date: string;
    function Expires: string;
    function Etag: string;
    function LastModified: string;
    function Server: string;
    function Headers: THeadersValues;
  protected
    { protected declarations }
    FFields: TDictionary<string, string>;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string); override;
    destructor Destroy; override;
    function ToString: string; override;
  end;

  TResponseCookies = class(TResponseProcess, IResponseCookies)
  private
    { private declarations }
    function Find(const pName: string): string;
    function Contains(const pName: string): Boolean;
    function Cookies: TCookiesValues;
  protected
    { protected declarations }
    FCookies: TDictionary<string, string>;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string); override;
    destructor Destroy; override;
    function ToString: string; override;
  end;

  TResponseBody = class(TResponseProcess, IResponseBody)
  private
    { private declarations }
    function CharSet: string;
    function Encoding: TEncoding;
    function ContentCompression: TRESTClientLibContentCompressionKind;
    function IsEmpty: Boolean;
    function IsBinary: Boolean;
    function MIMEType: string;
    function MIMETypeExt: string;
    function Content: string; overload;
    function Content(const pEncoding: TEncoding): string; overload;
    function AsJSON(const pEncoding: TEncoding): TJSONValue; overload;
    function AsJSON: TJSONValue; overload;
    function AsStream: TStream;
    function Raw: TBytes;
    function Size: Int64;
    function SizeAsString: string;
    function GetFileNameFromContentDisposition(const pContentDisposition: string): string;
    procedure SaveToFileFromContentDisposition(const pPath: string = '');
    procedure SaveToFile(const pFilePath: string);
  protected
    { protected declarations }
    FBody: TBytesStream;
    FCharSet: string;
    FEncoding: TEncoding;
    FContentCompression: TRESTClientLibContentCompressionKind;
    FIsBinary: Boolean;
    FMIMEType: string;
    FMIMETypeExt: string;
    function GetContentType: string; virtual; abstract;
    function GetContentEncoding: string; virtual; abstract;
  public
    { public declarations }
    constructor Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string); override;
    destructor Destroy; override;
  end;

implementation

uses
  System.Hash, System.DateUtils, REST.Json, System.NetEncoding, System.StrUtils,
  System.Generics.Defaults, System.RegularExpressions, RESTClientLib.Mime,
  RESTClientLib.Consts, RESTClientLib.Utils, RESTClientLib;

{$I RESTClientLib.inc}

{$REGION 'TEncodingHelper'}
function TEncodingHelper.EncodingText: string;
begin
  {$IF CompilerVersion >= 33}
  Result := Self.MIMEName;
  {$ELSE}
  Result := Self.EncodingName;
  {$ENDIF}
end;
{$ENDREGION}

{$REGION 'TRequestParamsCustom'}
constructor TRequestParamsCustom.Create(pRESTClientLib: IRESTClientLib; pRequestURL: IRequestURL);
begin
  FRequestURL := pRequestURL;
  FRESTClientLib := pRESTClientLib;

  Debug('Request Params: %s', ['Create']);
  FParams := TDictionary<string, TValue>.Create(1024, TIStringComparer.Ordinal); // CASE INSENSITIVE
end;

destructor TRequestParamsCustom.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

function TRequestParamsCustom.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestParamsCustom.Clear: IRequestParams;
begin
  Result := Self;
  FParams.Clear;
  Debug('Request Params: %s', ['Clear']);
end;

function TRequestParamsCustom.Find(const pName: string): TValue;
begin
  FParams.TryGetValue(pName, Result);
  Debug('Request Params: Find( %s=%s )', [pName, Result.ToString]);
end;

function TRequestParamsCustom.Contains(const pName: string): Boolean;
begin
  Result := FParams.ContainsKey(pName);
  Debug('Request Params: Contains( %s=%s )', [pName, BoolToStr(Result, True)]);
end;

function TRequestParamsCustom.Remove(const pName: string): IRequestParams;
begin
  Result := Self;
  FParams.Remove(pName);
  Debug('Request Params: Remove( %s )', [pName]);
end;

function TRequestParamsCustom.Params: TParamsValues;
begin
  Result := FParams.ToArray;
  Debug('Request Params: %s', ['ToArray']);
end;

function TRequestParamsCustom.&End: IRequestURL;
begin
  Result := FRequestURL;
  Debug('Request Params: %s', ['&End']);
end;
{$ENDREGION}

{$REGION 'TRequestPathParams'}
function TRequestPathParams.Add(const pName: string; const pValue: TValue): IRequestParams;
begin
  Result := Self;

  if pValue.IsObject then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Path params')
      .Error('Passing object is not allowed.')
      .Hint('Only primitive types are allowed.')
      .ClassName(Self.ClassName)
      .URL(FRequestURL.FullURL);

  FParams.AddOrSetValue(pName, pValue);
  Debug('Request PathParams: Add( %s=%s )', [pName, pValue.ToString]);
end;

class function TRequestPathParams.MakeParam(const pURL: string; const pName: string; const pValue: TValue): string;
begin
  Result := pURL;
  Result := StringReplace(Result, Format('{%s}', [pName]), pValue.ToString, [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, Format(':%s', [pName]), pValue.ToString, [rfReplaceAll, rfIgnoreCase]);
end;
{$ENDREGION}

{$REGION 'TRequestQueryParams'}
function TRequestQueryParams.Add(const pName: string; const pValue: TValue): IRequestParams;
begin
  Result := Self;

  if pValue.IsObject then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Query params')
      .Error('Passing object is not allowed.')
      .Hint('Only primitive types are allowed.')
      .ClassName(Self.ClassName)
      .URL(FRequestURL.FullURL);

  FParams.AddOrSetValue(pName, pValue);
  Debug('Request QueryParams: Add( %s=%s )', [pName, pValue.ToString]);
end;
{$ENDREGION}

{$REGION 'TRequestCertificate'}
constructor TRequestCertificate.Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions);
begin
  FRESTClientLib := pRESTClientLib;
  FRequestOptions := pRequestOptions;
  Debug('Request Certificate: %s', ['Create']);

  Reset;
end;

function TRequestCertificate.&End: IRequestOptions;
begin
  Result := FRequestOptions;
  Debug('Request Certificate: %s', ['&End']);
end;

function TRequestCertificate.KeyFile: string;
begin
  Result := FKeyFile;
  Debug('Request Certificate: Get KeyFile( %s )', [Result]);
end;

function TRequestCertificate.CertFile(const pValue: string): IRequestCertificate;
begin
  Result := Self;
  FCertFile := pValue;
  Debug('Request Certificate: Set CertFile( %s )', [FCertFile]);
end;

function TRequestCertificate.CertFile: string;
begin
  Result := FCertFile;
  Debug('Request Certificate: Get CertFile( %s )', [Result]);
end;

function TRequestCertificate.Reset: IRequestCertificate;
begin
  Result := Self;
  FCertFile := EmptyStr;
  FKeyFile := EmptyStr;
  Debug('Request Certificate: %s', ['Reset']);
end;

function TRequestCertificate.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestCertificate.KeyFile(const pValue: string): IRequestCertificate;
begin
  Result := Self;
  FKeyFile := pValue;
  Debug('Request Certificate: Set KeyFile( %s )', [FKeyFile]);
end;
{$ENDREGION}

{$REGION 'TRequestEncoding'}
constructor TRequestEncoding.Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions);
begin
  FRESTClientLib := pRESTClientLib;
  FRequestOptions := pRequestOptions;

  Debug('Request Encoding: %s', ['Create']);
  Reset;
end;

destructor TRequestEncoding.Destroy;
begin
  if Assigned(FEncoding) then
    FEncoding.Free;
  inherited Destroy;
end;

function TRequestEncoding.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestEncoding.Encoding: TEncoding;
begin
  Result := FEncoding;

  if Assigned(Result) then
    Debug('Request Encoding: Get Encoding( %s )', [FEncoding.EncodingName])
  else
    Debug('Request Encoding: Get Encoding( %s )', ['(nil)']);
end;

function TRequestEncoding.Encoding(const pCodePage: Integer): IRequestEncoding;
begin
  Result := Self;
  if (pCodePage <= 0) then
  begin
    Debug('Request Encoding: Set Encoding CodePage( %s )', ['(Empty)']);
    Exit;
  end;

  try
    Debug('Request Encoding: Set Encoding CodePage( %s )', [pCodePage.ToString]);

    if Assigned(FEncoding) then
      FreeAndNil(FEncoding);
    FEncoding := TEncoding.GetEncoding(pCodePage);

    Debug('Request Encoding: Set Encoding CodePage( %s )', [FEncoding.EncodingText]);
  except
    on E: EEncodingError do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Set Encoding CodePage( %s )', [pCodePage.ToString])
        .Error(E.Message)
        .Hint('Check the specified CodePage.')
        .ClassName(Self.ClassName);
  end;
end;

function TRequestEncoding.Encoding(const pCharset: string): IRequestEncoding;
begin
  Result := Self;
  if (Trim(pCharset) = EmptyStr) then
  begin
    Debug('Request Encoding: Set Encoding Charset( %s )', ['(Empty)']);
    Exit;
  end;

  try
    Debug('Request Encoding: Set Encoding Charset( %s )', [pCharset]);

    if Assigned(FEncoding) then
      FreeAndNil(FEncoding);
    FEncoding := TEncoding.GetEncoding(pCharset);

    Debug('Request Encoding: Set Encoding CodePage( %s )', [FEncoding.EncodingText]);
  except
    on E: EEncodingError do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Set Encoding Charset( %s )', [pCharset])
        .Error(E.Message)
        .Hint('Check the specified charset.')
        .ClassName(Self.ClassName);
  end;
end;

function TRequestEncoding.Encoding(const pEncoding: TEncoding): IRequestEncoding;
begin
  Result := Self;
  if not Assigned(pEncoding) then
  begin
    Debug('Request Encoding: Set Encoding( %s )', ['(Empty)']);
    Exit;
  end;

  try
    if Assigned(FEncoding) then
      FreeAndNil(FEncoding);
    FEncoding := TEncoding.GetEncoding(pEncoding.CodePage);

    Debug('Request Encoding: Set Encoding( %s )', [FEncoding.EncodingText]);
  except
    on E: EEncodingError do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Set Encoding')
        .Error(E.Message)
        .Hint('Check the specified charset.')
        .ClassName(Self.ClassName);
  end;
end;

function TRequestEncoding.&End: IRequestOptions;
begin
  Result := FRequestOptions;
  Debug('Request Encoding: %s', ['&End']);
end;

function TRequestEncoding.Reset: IRequestEncoding;
begin
  Result := Self;
  Debug('Request Encoding: %s', ['Reset']);

  if Assigned(FEncoding) then
    FreeAndNil(FEncoding);
  FEncoding := TEncoding.GetEncoding(CP_UTF8);

  Debug('Request Encoding: Set Default( %s )', [FEncoding.EncodingText]);
end;
{$ENDREGION}

{$REGION 'TRequestProxy'}
constructor TRequestProxy.Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions);
begin
  FRESTClientLib := pRESTClientLib;
  FRequestOptions := pRequestOptions;
  Debug('Request Proxy: %s', ['Create']);

  Reset;
end;

function TRequestProxy.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestProxy.&End: IRequestOptions;
begin
  Result := FRequestOptions;
  Debug('Request Proxy: %s', ['&End']);
end;

function TRequestProxy.Password(const pValue: string): IRequestProxy;
begin
  Result := Self;
  FPassword := Trim(pValue);
  Debug('Request Proxy: Set Password( %s )', [FPassword]);
end;

function TRequestProxy.Password: string;
begin
  Result := FPassword;
  Debug('Request Proxy: Get Password( %s )', [Result]);
end;

function TRequestProxy.Port: Integer;
begin
  Result := FPort;
  Debug('Request Proxy: Get Port( %d )', [Result]);
end;

function TRequestProxy.Port(const pValue: Integer): IRequestProxy;
begin
  Result := Self;
  FPort := pValue;
  Debug('Request Proxy: Set Port( %d )', [FPort]);
end;

function TRequestProxy.Reset: IRequestProxy;
begin
  FServer := EmptyStr;
  FPort := 0;
  FUser := EmptyStr;
  FPassword := EmptyStr;
  Debug('Request Proxy: %s', ['Reset']);
end;

function TRequestProxy.Server(const pValue: string): IRequestProxy;
begin
  Result := Self;
  FServer := Trim(pValue);
  Debug('Request Proxy: Set Server( %s )', [FServer]);
end;

function TRequestProxy.Server: string;
begin
  Result := FServer;
  Debug('Request Proxy: Get Server( %s )', [Result]);
end;

function TRequestProxy.User: string;
begin
  Result := FUser;
  Debug('Request Proxy: Get User( %s )', [Result]);
end;

function TRequestProxy.User(const pValue: string): IRequestProxy;
begin
  Result := Self;
  FUser := Trim(pValue);
  Debug('Request Proxy: Set User( %s )', [FUser]);
end;
{$ENDREGION}

{$REGION 'TRequestRedirects'}
constructor TRequestRedirects.Create(pRESTClientLib: IRESTClientLib; pRequestOptions: IRequestOptions);
begin
  FRESTClientLib := pRESTClientLib;
  FRequestOptions := pRequestOptions;
  Debug('Request Redirects: %s', ['Create']);

  Reset;
end;

function TRequestRedirects.Active(const pValue: Boolean): IRequestRedirects;
begin
  Result := Self;
  FActive := pValue;
  Debug('Request Redirects: Set Active( %s )', [BoolToStr(FActive, True)]);
end;

function TRequestRedirects.Active: Boolean;
begin
  Result := FActive;
  Debug('Request Redirects: Get Active( %s )', [BoolToStr(Result, True)]);
end;

function TRequestRedirects.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestRedirects.&End: IRequestOptions;
begin
  Result := FRequestOptions;
  Debug('Request Redirects: %s', ['&End']);
end;

function TRequestRedirects.MaxRedirects(const pValue: Integer): IRequestRedirects;
begin
  Result := Self;
  FMaxRedirects := pValue;
  Debug('Request Redirects: Set MaxRedirects( %s )', [FMaxRedirects]);
end;

function TRequestRedirects.MaxRedirects: Integer;
begin
  Result := FMaxRedirects;
  Debug('Request Redirects: Get MaxRedirects( %d )', [Result]);
end;

function TRequestRedirects.Reset: IRequestRedirects;
begin
  Debug('Request Redirects: %s', ['Reset']);
  FActive := True;
  FMaxRedirects := 5;
end;
{$ENDREGION}

{$REGION 'TRequestOptions'}
constructor TRequestOptions.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Options: %s', ['Create']);

  FRequestCertificate := TRequestCertificate.Create(pRESTClientLib, Self);
  FRequestEncoding := TRequestEncoding.Create(pRESTClientLib, Self);
  FRequestProxy := TRequestProxy.Create(pRESTClientLib, Self);
  FRequestRedirects := TRequestRedirects.Create(pRESTClientLib, Self);
  FRequestRetries := TRequestRetries.Create;
  Reset;
end;

destructor TRequestOptions.Destroy;
begin
  FRequestRetries.Free;
  inherited Destroy;
end;

function TRequestOptions.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestOptions.Certificate: IRequestCertificate;
begin
  Result := FRequestCertificate;
  Debug('Request Options: %s', ['Certificate']);
end;

function TRequestOptions.Encoding: IRequestEncoding;
begin
  Result := FRequestEncoding;
  Debug('Request Options: %s', ['Encoding']);
end;

function TRequestOptions.&End: IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request Options: %s', ['&End']);
end;

function TRequestOptions.HeaderOptions(const pHeaderOptions: TRESTClientLibHeaderOptions): IRequestOptions;
begin
  Result := Self;
  FHeaderOptions := [];
  FHeaderOptions := FHeaderOptions + pHeaderOptions;
  Debug('Request Options: Set %s', ['HeaderOptions']);
end;

function TRequestOptions.Proxy: IRequestProxy;
begin
  Result := FRequestProxy;
  Debug('Request Options: %s', ['Proxy']);
end;

function TRequestOptions.HeaderOptions: TRESTClientLibHeaderOptions;
begin
  Result := FHeaderOptions;
  Debug('Request Options: Get %s', ['HeaderOptions']);
end;

function TRequestOptions.RequestTimeout: Integer;
begin
  Result := FRequestTimeout;
  Debug('Request Options: Get RequestTimeout( %d )', [Result]);
end;

function TRequestOptions.Redirects: IRequestRedirects;
begin
  Result := FRequestRedirects;
  Debug('Request Options: %s', ['Redirects']);
end;

function TRequestOptions.RequestTimeout(const pValue: Integer): IRequestOptions;
begin
  Result := Self;
  FRequestTimeout := pValue;
  Debug('Request Options: Set RequestTimeout( %d )', [FRequestTimeout]);
end;

function TRequestOptions.ResponseTimeout: Integer;
begin
  Result := FResponseTimeout;
  Debug('Request Options: Get ResponseTimeout( %d )', [Result]);
end;

function TRequestOptions.ResponseTimeout(const pValue: Integer): IRequestOptions;
begin
  Result := Self;
  FResponseTimeout := pValue;
  Debug('Request Options: Set ResponseTimeout( %d )', [FResponseTimeout]);
end;

function TRequestOptions.Retries: TRequestRetries;
begin
  Result := FRequestRetries;
  Debug('Request Options: Get Retries( %d, %d )', [FRequestRetries.Tries, FRequestRetries.DelayInMilliseconds]);
end;

function TRequestOptions.Retries(const pTries: Integer; const pDelayInMilliseconds: Integer): IRequestOptions;
begin
  Result := Self;

  if (pTries <= 0) then
    FRequestRetries.Tries := 1
  else
  FRequestRetries.Tries := pTries;
  FRequestRetries.DelayInMilliseconds := pDelayInMilliseconds;

  Debug('Request Options: Set Retries( %d, %d )', [FRequestRetries.Tries, FRequestRetries.DelayInMilliseconds]);
end;

function TRequestOptions.Reset: IRequestOptions;
begin
  Result := Self;
  Debug('Request Options: %s', ['Reset']);

  FHeaderOptions := [];
  Include(FHeaderOptions, hoRequestID);
  Include(FHeaderOptions, hoRequestLib);
  RequestTimeout(15000); // ms default
  ResponseTimeout(15000); // ms default
  FRequestEncoding.Reset;
  FRequestCertificate.Reset;
  FRequestProxy.Reset;
  FRequestRedirects.Reset;
  FRequestRetries.Tries := 1;
  FRequestRetries.DelayInMilliseconds := 1000; // 1 sg
end;
{$ENDREGION}

{$REGION 'TRequestURL'}
constructor TRequestURL.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request URL: %s', ['Create']);

  FPathParams := TRequestPathParams.Create(pRESTClientLib, Self);
  FQueryParams := TRequestQueryParams.Create(pRESTClientLib, Self);
  Reset;
end;

function TRequestURL.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

destructor TRequestURL.Destroy;
begin
  inherited Destroy;
end;

function TRequestURL.&End: IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request URL: %s', ['&End']);
end;

function TRequestURL.Reset: IRequestURL;
begin
  FBaseURL := EmptyStr;
  FResource := EmptyStr;
  FPathParams.Clear;
  FQueryParams.Clear;
  Debug('Request URL: %s', ['Reset']);
end;

function TRequestURL.MakeURL: string;
var
  lURI: TURI;
  lQueries: TPair<string, TValue>;
  lURL: string;
begin
  lURL := MakeURLWithoutQueryParams;

  try
    lURI := TURI.Create(lURL);

    // Query Strings/Query Parameters/Query Params
    for lQueries in FQueryParams.Params do
      lURI.AddParameter(lQueries.Key, lQueries.Value.ToString);

    Result := lURI.ToString;
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Get FullURL')
        .Error('URL is invalid.')
        .Hint('Check the URL structure.')
        .ClassName(Self.ClassName);
  end;
end;

function TRequestURL.MakeURLWithoutQueryParams: string;
var
  lURI: TURI;
  lURLSchemeIsValid: Boolean;
  lBaseURL: string;
  lURL: string;
  lParams: TPair<string, TValue>;
begin
  if (FBaseURL = EmptyStr) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Get FullURL')
      .Error('BaseURL is invalid.')
      .Hint('Enter a value for BaseURL.')
      .ClassName(Self.ClassName);

  lBaseURL := LowerCase(FBaseURL);
  lURLSchemeIsValid := (Pos('http://', lBaseURL) > 0)
                    or (Pos('https://', lBaseURL) > 0)
                    or (Pos('ws://', lBaseURL) > 0)
                    or (Pos('ftp://', lBaseURL) > 0);

  if not lURLSchemeIsValid then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Get FullURL')
      .Error('BaseURL is invalid.')
      .Hint('Enter a valid scheme: [http://, https://, ws://, ftp://].')
      .ClassName(Self.ClassName);

  lBaseURL := FBaseURL;
  if (FResource <> EmptyStr) then
    if not lBaseURL.EndsWith('/') then
      lBaseURL := (lBaseURL + '/');

  lURL := Format('%s%s', [lBaseURL, FResource]);

  // Path Parameters/Path Variables/Path Segments/URL Params
  if (Length(FPathParams.Params) > 0) then
  begin
    if not lURL.EndsWith('/') then
      lURL := (lURL + '/');

    for lParams in FPathParams.Params do
      lURL := TRequestPathParams.MakeParam(lURL, lParams.Key, lParams.Value);
  end;

  // Query Strings/Query Parameters/Query Params
  if (Length(FQueryParams.Params) > 0) then
    if lURL.EndsWith('/') then
      Delete(lURL, Length(lURL), 1);

  try
    lURI := TURI.Create(lURL);
    Result := lURI.ToString;
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Get FullURL')
        .Error('URL is invalid.')
        .Hint('Check the URL structure.')
        .ClassName(Self.ClassName);
  end;
end;

function TRequestURL.BaseURL(const pValue: string): IRequestURL;
begin
  Result := Self;

  FBaseURL := Trim(pValue);
  Debug('Request URL: Set BaseURL( %s )', [FBaseURL]);
end;

function TRequestURL.BaseURL: string;
begin
  Result := FBaseURL;
  Debug('Request URL: Get BaseURL( %s )', [FBaseURL]);
end;

function TRequestURL.FullURL: string;
begin
  Result := MakeURL;
  Debug('Request URL: Get FullURL( %s )', [Result]);
end;

function TRequestURL.FullURLWithoutQueryParams: string;
begin
  Result := MakeURLWithoutQueryParams;
  Debug('Request URL: Get FullURLWithoutQueryParams( %s )', [Result]);
end;

function TRequestURL.PathParams: IRequestParams;
begin
  Result := FPathParams;
  Debug('Request URL: Get %s', ['PathParams']);
end;

function TRequestURL.QueryParams: IRequestParams;
begin
  Result := FQueryParams;
  Debug('Request URL: Get %s', ['QueryParams']);
end;

function TRequestURL.Resource(const pValue: string): IRequestURL;
begin
  Result := Self;
  FResource := Trim(pValue);
  Debug('Request URL: Set Resource( %s )', [FResource]);
end;

function TRequestURL.Resource: string;
begin
  Result := FResource;
  Debug('Request URL: Get Resource( %s )', [FResource]);
end;
{$ENDREGION}

{$REGION 'TRequestAuthentication'}
constructor TRequestAuthentication.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Authentication: %s', ['Create']);
end;

function TRequestAuthentication.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestAuthentication.Reset: IRequestAuthentication;
begin
  Result := Self;
  FRESTClientLib.Headers.Remove('Authorization');
  Debug('Request Authentication: %s', ['Reset']);
end;

function TRequestAuthentication.Basic(const pUser: string; const pPassword: string): IRESTClientLib;
var
  lBasicEncode: string;
  lValue: string;
begin
  Result := FRESTClientLib;

  lBasicEncode := MakeBasic(pUser, pPassword);
  lValue := Format('Basic %s', [lBasicEncode]);

  FRESTClientLib.Headers.Add('Authorization', lValue);
  Debug('Request Authentication: Basic( %s=%s )', ['Authorization', lValue]);
end;

function TRequestAuthentication.Bearer(const pToken: string): IRESTClientLib;
var
  lValue: string;
begin
  Result := FRESTClientLib;

  lValue := Format('Bearer %s', [pToken]);
  FRESTClientLib.Headers.Add('Authorization', lValue);
  Debug('Request Authentication: Bearer( %s=%s )', ['Authorization', lValue]);
end;

function TRequestAuthentication.Token(const pToken: string): IRESTClientLib;
begin
  Result := FRESTClientLib;

  FRESTClientLib.Headers.Add('Authorization', pToken);
  Debug('Request Authentication: Token( %s=%s )', ['Authorization', pToken]);
end;

function TRequestAuthentication.MakeBasic(const pUser: string; const pPassword: string): string;
var
  lText: string;
begin
  lText := Format('%s:%s', [pUser, pPassword]);
  Result := TNetEncoding.Base64.Encode(lText);
end;
{$ENDREGION}

{$REGION 'TRequestCookies'}
constructor TRequestCookies.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Cookies: %s', ['Create']);

  FCookies := TDictionary<string, string>.Create(1024, TIStringComparer.Ordinal); // CASE INSENSITIVE
end;

destructor TRequestCookies.Destroy;
begin
  FCookies.Free;
  inherited Destroy;
end;

function TRequestCookies.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestCookies.&End: IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request Cookies: %s', ['&End']);
end;

function TRequestCookies.Add(const pName: string; const pValue: string; const pEncode: Boolean): IRequestCookies;
var
  lValue: string;
begin
  Result := Self;

  lValue := pValue;
  if pEncode then
    lValue := TNetEncoding.URL.Encode(pValue);

  FCookies.AddOrSetValue(pName, lValue);
  Debug('Request Cookies: Add( %s=%s )', [pName, lValue]);
end;

function TRequestCookies.Reset: IRequestCookies;
begin
  Result := Self;
  FCookies.Clear;
  Debug('Request Cookies: %s', ['Reset']);
end;

function TRequestCookies.Cookies(const pCookies: TStrings; const pEncode: Boolean): IRequestCookies;
var
  I: Integer;
begin
  Result := Self;

  if not Assigned(pCookies) then
    Exit;

  Debug('Request Cookies: %s', ['Import']);
  for I := 0 to Pred(pCookies.Count) do
    Add(pCookies.Names[I], pCookies.Strings[I], pEncode);
end;

function TRequestCookies.Contains(const pName: string): Boolean;
begin
  Result := FCookies.ContainsKey(pName);
  Debug('Request Cookies: Contains( %s=%s )', [pName, BoolToStr(Result, True)]);
end;

function TRequestCookies.Cookies: TCookiesValues;
begin
  Debug('Request Cookies: %s', ['TCookiesValues']);
  Result := FCookies.ToArray;
end;

function TRequestCookies.Find(const pName: string): string;
begin
  FCookies.TryGetValue(pName, Result);
  Debug('Request Cookies: Find( %s=%s )', [pName, Result]);
end;

function TRequestCookies.Remove(const pName: string): IRequestCookies;
begin
  Result := Self;

  FCookies.Remove(pName);
  Debug('Request Cookies: Remove( %s )', [pName]);
end;

function TRequestCookies.ToLine: string;
var
  lResult: TStringBuilder;
  lCookie: TPair<string, string>;
begin
  Debug('Request Cookies: %s', ['ToLine']);
  lResult := TStringBuilder.Create;
  try
    for lCookie in FCookies do
      lResult.AppendFormat('%s=%s%s', [lCookie.Key, lCookie.Value, ';']);
    Result := lResult.ToString;
  finally
    lResult.Free;
  end;
  if Result.EndsWith(';') then
    Delete(Result, Length(Result), 1);
end;
{$ENDREGION}

{$REGION 'TRequestHeaders'}
constructor TRequestHeaders.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Headers: %s', ['Create']);

  FFields := TDictionary<string, string>.Create(1024, TIStringComparer.Ordinal); // CASE INSENSITIVE
  Default;
end;

destructor TRequestHeaders.Destroy;
begin
  FFields.Free;
  inherited Destroy;
end;

function TRequestHeaders.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

procedure TRequestHeaders.Default;
begin
  Debug('Request Headers: %s', ['Default']);

  Add('User-Agent', Format('RestClientLib/%s', [RESTClientLibVersion]));
  Add('Accept', '*/*');
  FConnectionKeepAlive := True;
end;

function TRequestHeaders.Reset: IRequestHeaders;
begin
  Result := Self;
  Debug('Request Headers: %s', ['Reset']);

  FFields.Clear;
  Default;
end;

function TRequestHeaders.Add(const pName: string; const pValue: string; const pEncode: Boolean): IRequestHeaders;
var
  lValue: string;
begin
  Result := Self;

  lValue := pValue;
  if pEncode then
    lValue := TNetEncoding.URL.Encode(pValue);
  FFields.AddOrSetValue(pName, lValue);
  Debug('Request Headers: Add( %s: %s )', [pName, lValue]);
end;

function TRequestHeaders.Find(const pName: string): string;
begin
  FFields.TryGetValue(pName, Result);
  Debug('Request Headers: Find( %s: %s )', [pName, Result]);
end;

function TRequestHeaders.Headers: THeadersValues;
begin
  Result := FFields.ToArray;
  Debug('Request Headers: %s', ['ToArray']);
end;

function TRequestHeaders.Remove(const pName: string): IRequestHeaders;
begin
  FFields.Remove(pName);
  Debug('Request Headers: Remove( %s )', [pName]);
end;

function TRequestHeaders.RequestID: string;
begin
  Result := Find(C_APP_HEADER_REQUEST_ID);
end;

function TRequestHeaders.RequestLib: string;
begin
  Result := Find(C_APP_HEADER_REQUEST_LIB);
end;

function TRequestHeaders.RequestTime: string;
begin
  Result := Find(C_APP_HEADER_REQUEST_TIME);
end;

function TRequestHeaders.&End: IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request Headers: %s', ['&End']);
end;

function TRequestHeaders.Accept(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Accept', pValue);
end;

function TRequestHeaders.Accept: string;
begin
  Result := Find('Accept');
end;

function TRequestHeaders.AcceptCharset: string;
begin
  Result := Find('Accept-Charset');
end;

function TRequestHeaders.AcceptCharset(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Accept-Charset', pValue);
end;

function TRequestHeaders.AcceptEncoding(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Accept-Encoding', pValue);
end;

function TRequestHeaders.AcceptEncoding: string;
begin
  Result := Find('Accept-Encoding');
end;

function TRequestHeaders.AcceptLanguage(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Accept-Language', pValue);
end;

function TRequestHeaders.AcceptLanguage: string;
begin
  Result := Find('Accept-Language');
end;

function TRequestHeaders.CacheControl(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Cache-Control', pValue);
end;

function TRequestHeaders.CacheControl: string;
begin
  Result := Find('Cache-Control');
end;

function TRequestHeaders.ConnectionKeepAlive: Boolean;
begin
  Result := FConnectionKeepAlive;
  Debug('Request Headers: Get ConnectionKeepAlive( %s )', [IfThen(Result, 'True', 'False')]);
end;

function TRequestHeaders.ConnectionKeepAlive(const pValue: Boolean): IRequestHeaders;
begin
  Result := Self;
  FConnectionKeepAlive := pValue;
  Debug('Request Headers: Set ConnectionKeepAlive( %s )', [IfThen(FConnectionKeepAlive, 'True', 'False')]);
end;

function TRequestHeaders.Contains(const pName: string): Boolean;
begin
  Result := FFields.ContainsKey(pName);
  Debug('Request Headers: Contains( %s=%s )', [pName, BoolToStr(Result, True)]);
end;

function TRequestHeaders.ContentEncoding(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Content-Encoding', pValue);
end;

function TRequestHeaders.ContentLanguage(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Content-Language', pValue);
end;

function TRequestHeaders.ContentLanguage: string;
begin
  Result := Find('Content-Language');
end;

function TRequestHeaders.ContentEncoding: string;
begin
  Result := Find('Content-Encoding');
end;

function TRequestHeaders.ContentType(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Content-Type', pValue);
end;

function TRequestHeaders.ContentType(const pValue: string; const pEncoding: TEncoding): IRequestHeaders;
var
  lValue: string;
begin
  Result := Self;
  lValue := THeadersUtils.MakeContentTypeValue(pValue, pEncoding);
  Add('Content-Type', lValue);
end;

function TRequestHeaders.ContentType: string;
begin
  Result := Find('Content-Type');
end;

function TRequestHeaders.IfNoneMatch(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('If-None-Match', pValue);
end;

function TRequestHeaders.RequestPlatform: string;
begin
  Result := Find(C_APP_HEADER_REQUEST_PLATFORM);
end;

function TRequestHeaders.IfNoneMatch: string;
begin
  Result := Find('If-None-Match');
end;

function TRequestHeaders.Referer(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('Referer', pValue);
end;

function TRequestHeaders.Referer: string;
begin
  Result := Find('Referer');
end;

function TRequestHeaders.UserAgent: string;
begin
  Result := Find('User-Agent');
end;

function TRequestHeaders.UserAgent(const pValue: string): IRequestHeaders;
begin
  Result := Self;
  Add('User-Agent', pValue);
end;
{$ENDREGION}

{$REGION 'TRequestMultipartFormData'}
constructor TRequestMultipartFormData.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request MultipartFormData: %s', ['Create']);

  FMultipartFormData := TMultipartFormData.Create;
end;

destructor TRequestMultipartFormData.Destroy;
begin
  FMultipartFormData.Free;
  inherited Destroy;
end;

function TRequestMultipartFormData.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

procedure TRequestMultipartFormData.CheckField(const pFieldName: string);
begin
  if (Trim(pFieldName) = EmptyStr) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Field')
      .Error('Parameter "FieldName" is empty.')
      .Hint('Field name is required.')
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);
end;

procedure TRequestMultipartFormData.CheckField(const pFunction: string; const pFieldName: string; pValue: TObject);
begin
  CheckField(pFieldName);

  if not Assigned(pValue) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Request MultipartFormData: %s', [pFunction])
      .Error('Parameter "Value" not initialized.')
      .Hint(Format('Check the "object" of the field [%s]', [pFieldName]))
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);
end;

function TRequestMultipartFormData.Reset: IRequestMultipartFormData;
begin
  Result := Self;
  Debug('Request MultipartFormData: %s', ['Reset']);

  if Assigned(FMultipartFormData) then
    FreeAndNil(FMultipartFormData);
  FMultipartFormData := TMultipartFormData.Create;
end;

function TRequestMultipartFormData.Content: TStream;
begin
  Debug('Request MultipartFormData: Get %s', ['Content']);
  Result := FMultipartFormData.Stream;
end;

function TRequestMultipartFormData.ContentType: string;
begin
  Result := FMultipartFormData.MimeTypeHeader;
  Debug('Request MultipartFormData: Get ContentType( %s )', [Result]);
end;

function TRequestMultipartFormData.&End: IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request MultipartFormData: %s', ['&End']);
end;

function TRequestMultipartFormData.Field(const pFieldName: string; const pValue: string): IRequestMultipartFormData;
begin
  Result := Self;
  Debug('Request MultipartFormData: Field( %s=%s )', [pFieldName, 'String']);

  CheckField(pFieldName);
  FMultipartFormData.AddField(pFieldName, pValue);
end;

function TRequestMultipartFormData.Field(const pFieldName: string; const pValue: TStream; const pContentType: string; const pOwnsObject: Boolean): IRequestMultipartFormData;
begin
  Result := Self;
  Debug('Request MultipartFormData: Field( %s=%s )', [pFieldName, 'TStream']);

  CheckField('Add Field', pFieldName, pValue);
  FMultipartFormData.AddStream(pFieldName, pValue, pFieldName, pContentType);

  if pOwnsObject then
    pValue.Free;
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: TJSONValue; const pOwnsObject: Boolean): IRequestMultipartFormData;
var
  lValue: string;
begin
  Result := Self;
  Debug('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'TJSONValue']);

  CheckField('Add JSON', pFieldName, pValue);

  lValue := TJSONUtils.ToString(pValue, FRESTClientLib.Options.Encoding.Encoding);
  FMultipartFormData.AddField(pFieldName, lValue);

  if pOwnsObject then
    pValue.Free;
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: TBytes; const pSize: Int64): IRequestMultipartFormData;
var
  lJSONValue: TJSONValue;
begin
  Result := Self;
  Debug('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'TBytes']);

  if (Length(pValue) = 0) then
    Exit;

  try
    lJSONValue := TJSONUtils.ToJSONValue(pValue, pSize, FRESTClientLib.Options.Encoding.Encoding);
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'TBytes'])
        .Error(TExceptionUtils.TranslateErrorMsg(E.Message))
        .Hint('Error parsing the JSON.')
        .ClassName(Self.ClassName)
        .URL(FRESTClientLib.URL.FullURL);
  end;

  Result := JSON(pFieldName, lJSONValue, True);
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: string): IRequestMultipartFormData;
var
  lJSONValue: TJSONValue;
begin
  Result := Self;
  Debug('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'String']);

  if (Trim(pValue) = EmptyStr) then
    Exit;

  try
    lJSONValue := TJSONUtils.ToJSONValue(pValue, FRESTClientLib.Options.Encoding.Encoding);
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'string'])
        .Error(TExceptionUtils.TranslateErrorMsg(E.Message))
        .Hint('Error parsing the JSON.')
        .ClassName(Self.ClassName)
        .URL(FRESTClientLib.URL.FullURL);
  end;

  Result := Self.JSON(pFieldName, lJSONValue, True);
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: TJSONArray; const pOwnsObject: Boolean): IRequestMultipartFormData;
begin
  Result := Self.JSON(pFieldName, TJSONValue(pValue), pOwnsObject);
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: TJSONObject; const pOwnsObject: Boolean): IRequestMultipartFormData;
begin
  Result := Self.JSON(pFieldName, TJSONValue(pValue), pOwnsObject);
end;

function TRequestMultipartFormData.JSON(const pFieldName: string; const pValue: TObject; const pOwnsObject: Boolean): IRequestMultipartFormData;
var
  lJSONObject: TJSONObject;
begin
  Result := Self;
  Debug('Request MultipartFormData: JSON( %s=%s )', [pFieldName, 'TObject']);

  CheckField('Add JSON', pFieldName, pValue);
  lJSONObject := TJson.ObjectToJsonObject(pValue);
  Result := Self.JSON(pFieldName, lJSONObject, True);

  if pOwnsObject then
    pValue.Free;
end;

function TRequestMultipartFormData.LoadFromFile(const pFieldName: string; const pFileName: string; const pValue: TStream; const pOwnsObject: Boolean): IRequestMultipartFormData;
var
  lFileName: string;
begin
  Result := Self;
  Debug('Request MultipartFormData: LoadFromFile( %s )', [lFileName]);

  CheckField('Add LoadFromFile', pFieldName, pValue);
  lFileName := ExtractFileName(pFileName);
  if (lFileName = EmptyStr) then
    lFileName := pFieldName;

  FMultipartFormData.AddStream(pFieldName, pValue, lFileName, EmptyStr);

  if pOwnsObject then
    pValue.Free;
end;

function TRequestMultipartFormData.UseMultipartFormData: Boolean;
begin
  Result := FMultipartFormData.UseMultipartFormData;
end;

function TRequestMultipartFormData.LoadFromFile(const pFieldName: string; const pFilePath: string): IRequestMultipartFormData;
begin
  Result := Self;
  Debug('Request MultipartFormData: LoadFromFile( %s )', [pFilePath]);

  CheckField(pFieldName);

  if not FileExists(pFilePath) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Request MultipartFormData: LoadFromFile( %s )', [pFilePath])
      .Error('File not found.')
      .Hint(Format('Check the file "%s" of the field [%s].', [pFilePath, pFieldName]))
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);

  FMultipartFormData.AddFile(pFieldName, pFilePath, EmptyStr);
end;
{$ENDREGION}

{$REGION 'TRequestBody'}
constructor TRequestBody.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Body: %s', ['Create']);

  Reset;
end;

destructor TRequestBody.Destroy;
begin
  if Assigned(FBody)  then
    FreeAndNil(FBody);
  inherited Destroy;
end;

function TRequestBody.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

procedure TRequestBody.CheckValue(const pFunction: string; const pValue: TObject);
begin
  if not Assigned(pValue) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Body: ' + pFunction)
      .Error('Parameter "Value" not initialized.')
      .Hint('Check the object specified in the parameter.')
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);
end;

function TRequestBody.Reset: IRequestBody;
begin
  Debug('Request Body: %s', ['Reset']);
  if Assigned(FBody) then
    FreeAndNil(FBody);
  FBody := TStringStream.Create(EmptyStr, FRESTClientLib.Options.Encoding.Encoding, False);
end;

function TRequestBody.Content: TStream;
begin
  Debug('Request Body: Get %s', ['Content']);
  Result := FBody;
end;

function TRequestBody.Content(const pValue: string): IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['String']);

  FBody.WriteString(pValue);
  FBody.Position := 0;
end;

function TRequestBody.Content(const pValue: TStream; const pOwnsObject: Boolean): IRESTClientLib;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['TStream']);

  CheckValue('Content( TStream )', pValue);

  FBody.CopyFrom(pValue, 0);
  FBody.Position := 0;

  if pOwnsObject then
    pValue.Free;
end;

function TRequestBody.JSON(const pValue: string): IRESTClientLib;
var
  lJSONValue: TJSONValue;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['JSON(string)']);

  if (Trim(pValue) = EmptyStr) then
    Exit;

  try
    lJSONValue := TJSONUtils.ToJSONValue(pValue, FRESTClientLib.Options.Encoding.Encoding);
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Add Body: JSON(string)')
        .Error(TExceptionUtils.TranslateErrorMsg(E.Message))
        .Hint('Error parsing the JSON.')
        .ClassName(Self.ClassName)
        .URL(FRESTClientLib.URL.FullURL);
  end;

  Self.JSON(lJSONValue, True);
end;

function TRequestBody.JSON(const pValue: TJSONValue; const pOwnsObject: Boolean): IRESTClientLib;
var
  lJSONString: string;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['JSON(TJSONValue)']);

  if not Assigned(pValue) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Body: %s', ['JSON(TJSONValue)'])
      .Error('Invalid JSON or not initialized.')
      .Hint('Check the object specified in the parameter.')
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);

  FRESTClientLib.Headers.ContentType('application/json', FRESTClientLib.Options.Encoding.Encoding);
  lJSONString := TJSONUtils.ToString(pValue, FRESTClientLib.Options.Encoding.Encoding);
  FBody.WriteString(lJSONString);
  FBody.Position := 0;

  if pOwnsObject then
    pValue.Free;
end;

function TRequestBody.JSON(const pValue: TJSONObject; const pOwnsObject: Boolean): IRESTClientLib;
begin
  Debug('Request Body: Set Content( %s )', ['JSON(TJSONObject)']);
  Result := Self.JSON(TJSONvalue(pValue), pOwnsObject);
end;

function TRequestBody.JSON(const pValue: TJSONArray; const pOwnsObject: Boolean): IRESTClientLib;
begin
  Debug('Request Body: Set Content( %s )', ['JSON(TJSONArray)']);
  Result := Self.JSON(TJSONvalue(pValue), pOwnsObject);
end;

function TRequestBody.JSON(const pValue: TObject; const pOwnsObject: Boolean): IRESTClientLib;
var
  lJSONObject: TJSONObject;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['JSON(TObject)']);

  CheckValue('Content JSON(TObject)', pValue);
  lJSONObject := TJson.ObjectToJsonObject(pValue);
  Self.JSON(lJSONObject, True);

  if pOwnsObject then
    pValue.Free;
end;

function TRequestBody.JSON(const pValue: TBytes; const pSize: Int64): IRESTClientLib;
var
  lJSONValue: TJSONValue;
begin
  Result := FRESTClientLib;
  Debug('Request Body: Set Content( %s )', ['JSON(TBytes)']);

  if (Length(pValue) = 0) then
    Exit;

  try
    lJSONValue := TJSONUtils.ToJSONValue(pValue, pSize, FRESTClientLib.Options.Encoding.Encoding);
  except
    on E: Exception do
      raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Add Body: JSON(TBytes)')
        .Error(TExceptionUtils.TranslateErrorMsg(E.Message))
        .Hint('Error parsing the JSON.')
        .ClassName(Self.ClassName)
        .URL(FRESTClientLib.URL.FullURL);
  end;

  Self.JSON(lJSONValue, True);
end;

function TRequestBody.LoadFromFile(const pFileName: string; const pValue: TStream; const pOwnsObject: Boolean): IRESTClientLib;
var
  lContentType: string;
  lFileName: string;
begin
  Result := FRESTClientLib;
  lFileName := ExtractFileName(pFileName);
  Debug('Request Body: LoadFromFile( %s )', [lFileName]);

  CheckValue('Content ( LoadFromFile )', pValue);

  lContentType := TRESTClientLibMimeTypes.FileType(lFileName);
  FRESTClientLib.Headers.ContentType(lContentType);

  FBody.CopyFrom(pValue, 0);
  FBody.Position := 0;

  if pOwnsObject then
    pValue.Free;
end;

function TRequestBody.LoadFromFile(const pFilePath: string): IRESTClientLib;
var
  lContentType: string;
begin
  Result := FRESTClientLib;
  Debug('Request Body: LoadFromFile( %s )', [pFilePath]);

  if not FileExists(pFilePath) then
    raise ERESTClientLib.Build(FRESTClientLib.RequestLibrary)
      .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
      .Title('Add Body: LoadFromFile( %s )', [pFilePath])
      .Error('File not exists.')
      .Hint('Check the file specified in the parameter.')
      .ClassName(Self.ClassName)
      .URL(FRESTClientLib.URL.FullURL);

  lContentType := TRESTClientLibMimeTypes.FileType(pFilePath);
  FRESTClientLib.Headers.ContentType(lContentType);

  FBody.LoadFromFile(pFilePath);
  FBody.Position := 0;
end;
{$ENDREGION}

{$REGION 'TRequestExecuteCustom'}
constructor TRequestExecuteCustom.Create(pRESTClientLib: IRESTClientLib);
begin
  FRESTClientLib := pRESTClientLib;
  Debug('Request Execute: %s', ['Create']);
end;

function TRequestExecuteCustom.GetHeaderPlatform: string;
begin
  Result := Format('%s ', [TOSVersion.ToString]);
end;

function TRequestExecuteCustom.GetHeaderRequestID: string;
var
  lValue: string;
begin
  Sleep(1);
  lValue := FormatDateTime('yyyyMMddHHnnss.zzz', Now());
  Result := THashMD5.GetHashString(lValue);
end;

function TRequestExecuteCustom.GetHeaderRequestLib: string;
begin
  Result := FRESTClientLib.RequestLibrary.AsString;
end;

function TRequestExecuteCustom.GetHeaderRequestTime: string;
begin
  Result := DateToISO8601(Now, False);
end;

function TRequestExecuteCustom.Execute(const pRequestMethod: TRESTClientLibRequestMethodKind): IResponse;
begin
  SetHeaderCustom;
  Debug('Request Execute: ( %s )', [pRequestMethod.AsString]);
end;

function TRequestExecuteCustom.FromString(const pMethod: string): IResponse;
begin
  Result := Execute(RequestMethodFromString(pMethod));
end;

function TRequestExecuteCustom.FromType(const pMethod: TRESTClientLibRequestMethodKind): IResponse;
begin
  Result := Execute(pMethod);
end;

function TRequestExecuteCustom.DebugLib: Boolean;
begin
  Result := FRESTClientLib.DebugLib;
end;

function TRequestExecuteCustom.Delete: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.DELETE);
end;

function TRequestExecuteCustom.Get: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.GET);
end;

function TRequestExecuteCustom.Head: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.HEAD);
end;

function TRequestExecuteCustom.Merge: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.MERGE);
end;

function TRequestExecuteCustom.Options: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.OPTIONS);
end;

function TRequestExecuteCustom.Patch: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.PATCH);
end;

function TRequestExecuteCustom.Post: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.POST);
end;

function TRequestExecuteCustom.Put: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.PUT);
end;

function TRequestExecuteCustom.Trace: IResponse;
begin
  Result := Execute(TRESTClientLibRequestMethodKind.TRACE);
end;

procedure TRequestExecuteCustom.SetHeaderCustom;
begin
  if (hoRequestID in FRESTClientLib.Options.HeaderOptions) then
    FRESTClientLib.Headers.Add(C_APP_HEADER_REQUEST_ID, GetHeaderRequestID);
  if (hoRequestTime in FRESTClientLib.Options.HeaderOptions) then
    FRESTClientLib.Headers.Add(C_APP_HEADER_REQUEST_TIME, GetHeaderRequestTime);
  if (hoRequestPlatform in FRESTClientLib.Options.HeaderOptions) then
    FRESTClientLib.Headers.Add(C_APP_HEADER_REQUEST_PLATFORM, GetHeaderPlatform);
  if (hoRequestLib in FRESTClientLib.Options.HeaderOptions) then
    FRESTClientLib.Headers.Add(C_APP_HEADER_REQUEST_LIB, GetHeaderRequestLib);
end;
{$ENDREGION}

{$REGION 'TResponseCustom'}
constructor TResponseCustom.Create(pRESTClientLib: IRESTClientLib; const pRequestTime: Int64);
begin
  FRequestTime := pRequestTime;
  FDebugLib := pRESTClientLib.DebugLib;
  FRequestURL := pRESTClientLib.URL.FullURL;
  Debug('Response: Set RequestTime( %s )', [Format('%dms', [FRequestTime])]);
  Debug('Response: Set URL( %s )', [FRequestURL]);
end;

function TResponseCustom.DebugLib: Boolean;
begin
  Result := FDebugLib;
end;

function TResponseCustom.GetBody: IResponseBody;
begin
  Result := FBody;
end;

function TResponseCustom.GetCookies: IResponseCookies;
begin
  Result := FCookies;
end;

function TResponseCustom.GetHeaders: IResponseHeaders;
begin
  Result := FHeaders;
end;
function TResponseCustom.GetRequestTime: Int64;
begin
  Result := FRequestTime;
end;

function TResponseCustom.GetRequestTimeAsString: string;
begin
  Result := Format('%dms', [FRequestTime]);
  Debug('Response: Get RequestTime( %s )', [Result]);
end;

function TResponseCustom.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TResponseCustom.GetStatusCodeAsString: string;
begin
  Result := IntToStr(FStatusCode);
end;

function TResponseCustom.GetStatusText: string;
begin
  Result := FStatusText;
end;

function TResponseCustom.GetURL: string;
begin
  Result := FRequestURL;
  Debug('Response: Get URL( %s )', [Result]);
end;

function TResponseCustom.GetVersionHTTP: string;
begin
  Result := FVersionHTTP;
end;
{$ENDREGION}

{$REGION 'TResponseProcess'}
constructor TResponseProcess.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string);
begin
  FResponse := pResponse;
  FRequestMethod := pRequestMethod;
  FDebugLib := pRESTClientLib.DebugLib;
  FRequestLibrary := pRESTClientLib.RequestLibrary;
  FRequestURL := pRESTClientLib.URL.FullURL;
end;

function TResponseProcess.DebugLib: Boolean;
begin
  Result := FDebugLib;
end;
{$ENDREGION}

{$REGION 'TResponseHeaders'}
constructor TResponseHeaders.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  Debug('Response Headers: %s', ['Create']);
  FFields := TDictionary<string, string>.Create(1024, TIStringComparer.Ordinal); // CASE INSENSITIVE
end;

destructor TResponseHeaders.Destroy;
begin
  FFields.Free;
  inherited Destroy;
end;

function TResponseHeaders.AccessControlAllowOrigin: string;
begin
  Result := Find('Access-Control-Allow-Origin');
end;

function TResponseHeaders.Age: string;
begin
  Result := Find('Age');
end;

function TResponseHeaders.CacheControl: string;
begin
  Result := Find('Cache-Control');
end;

function TResponseHeaders.Connection: string;
begin
  Result := Find('Connection');
end;

function TResponseHeaders.Contains(const pName: string): Boolean;
begin
  Result := FFields.ContainsKey(pName);
end;

function TResponseHeaders.ContentDisposition: string;
begin
  Result := Find('Content-Disposition');
end;

function TResponseHeaders.ContentEncoding: string;
begin
  Result := Find('Content-Encoding');
end;

function TResponseHeaders.ContentLength: Int64;
var
  lContentLength: string;
begin
  lContentLength := Find('Content-Length');
  Result := StrToInt64Def(lContentLength, 0);
end;

function TResponseHeaders.ContentType: string;
begin
  Result := Find('Content-Type');
end;

function TResponseHeaders.Date: string;
begin
  Result := Find('Date');
end;

function TResponseHeaders.Etag: string;
begin
  Result := Find('Etag');
end;

function TResponseHeaders.Expires: string;
begin
  Result := Find('Expires');
end;

function TResponseHeaders.Find(const pName: string): string;
begin
  FFields.TryGetValue(pName, Result);
  Debug('Response Headers: Find( %s=%s )', [pName, Result]);
end;

function TResponseHeaders.Headers: THeadersValues;
begin
  Debug('Response Headers: %s', ['ToArray']);
  Result := FFields.ToArray;
end;

function TResponseHeaders.LastModified: string;
begin
  Result := Find('Last-Modified');
end;

function TResponseHeaders.Server: string;
begin
  Result := Find('Server');
end;

function TResponseHeaders.ToString: string;
var
  lResult: TStringBuilder;
  lField: TPair<string, string>;
begin
  Debug('Response Headers: %s', ['ToString']);
  lResult := TStringBuilder.Create;
  try
    for lField in FFields do
      lResult.AppendFormat('%s: %s%s', [lField.Key, lField.Value, sLineBreak]);
    Result := lResult.ToString;
  finally
    lResult.Free;
  end;
  if Result.EndsWith(sLineBreak) then
    Delete(Result, Length(Result)-1, 2);
end;
{$ENDREGION}

{$REGION 'TResponseCookies'}
constructor TResponseCookies.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  Debug('Response Cookies: %s', ['Create']);
  FCookies := TDictionary<string, string>.Create(1024, TIStringComparer.Ordinal); // CASE INSENSITIVE
end;

destructor TResponseCookies.Destroy;
begin
  FCookies.Free;
  inherited Destroy;
end;

function TResponseCookies.Contains(const pName: string): Boolean;
begin
  Result := FCookies.ContainsKey(pName);
  Debug('Response Cookies: Contains( %s=%s )', [pName, BoolToStr(Result, True)]);
end;

function TResponseCookies.Cookies: TCookiesValues;
begin
  Debug('Response Cookies: %s', ['Get Values']);
  Result := FCookies.ToArray;
end;

function TResponseCookies.Find(const pName: string): string;
begin
  FCookies.TryGetValue(pName, Result);
  Debug('Response Cookies: Find( %s=%s )', [pName, Result]);
end;

function TResponseCookies.ToString: string;
var
  lResult: TStringBuilder;
  lCookie: TPair<string, string>;
begin
  Debug('Response Cookies: %s', ['ToString']);
  lResult := TStringBuilder.Create;
  try
    for lCookie in FCookies do
      lResult.AppendFormat('%s=%s%s', [lCookie.Key, lCookie.Value, sLineBreak]);
    Result := lResult.ToString;
  finally
    lResult.Free;
  end;
  if Result.EndsWith(sLineBreak) then
    Delete(Result, Length(Result)-1, 2);
end;
{$ENDREGION}

{$REGION 'TResponseBody'}
constructor TResponseBody.Create(pRESTClientLib: IRESTClientLib; pResponse: IResponse; const pRequestMethod: string);
begin
  inherited Create(pRESTClientLib, pResponse, pRequestMethod);
  Debug('Response Body: %s', ['Create']);
end;

destructor TResponseBody.Destroy;
begin
  if Assigned(FEncoding) then
    FreeAndNil(FEncoding);

  if Assigned(FBody) then
    FreeAndNil(FBody);
  inherited Destroy;
end;

function TResponseBody.CharSet: string;
begin
  Result := FCharSet;
  Debug('Response Body: CharSet( %s )', [Result]);
end;

function TResponseBody.Encoding: TEncoding;
begin
  Result := FEncoding;
  if Assigned(FEncoding) then
    Debug('Response Body: Encoding( %s )', [FEncoding.EncodingText]);
end;

function TResponseBody.GetFileNameFromContentDisposition(const pContentDisposition: string): string;
var
  lRegex: TRegEx;
  lMatch: TMatch;
begin
  Result := EmptyStr;

  // Define the regex pattern to extract the filename
  lRegex := TRegEx.Create('filename="([^"]+)"');

  // Perform the regex match
  lMatch := lRegex.Match(pContentDisposition);
  if lMatch.Success then
    // Extract the captured group which contains the filename
    Result := Trim(lMatch.Groups[1].Value);
end;

function TResponseBody.AsJSON: TJSONValue;
begin
  Debug('Response Body: %s', ['AsJSON']);
  Result := Self.AsJSON(FEncoding);
end;

function TResponseBody.AsJSON(const pEncoding: TEncoding): TJSONValue;
begin
  Result := nil;
  if not Assigned(pEncoding) then
    Exit;

  Debug('Response Body: AsJSON( %s )', [FEncoding.EncodingText]);

  try
    Result := TJSONUtils.ToJSONValue(FBody.Bytes, FBody.Size, pEncoding);
  except
    on E: Exception do
    begin
      raise ERESTClientLib.Build(FRequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Response Body: AsJSON( %s )', [pEncoding.EncodingText])
        .Error(TExceptionUtils.TranslateErrorMsg(E.Message))
        .Hint('Error parsing the JSON.')
        .ClassName(Self.ClassName)
        .RequestMethod(FRequestMethod)
        .URL(FRequestURL);
    end;
  end;
end;

function TResponseBody.AsStream: TStream;
var
  lResult: TMemoryStream;
begin
  Debug('Response Body: %s', ['AsStream']);
  Result := nil;

  FBody.Position := 0;
  if (FBody.Size = 0) then
    Exit;

  lResult := TMemoryStream.Create;
  lResult.LoadFromStream(FBody);
  lResult.Position := 0;

  Result := lResult;
end;

function TResponseBody.Content: string;
begin
  Debug('Response Body: Content( %s )', ['String']);
  try
    FBody.Position := 0;
    Result := FEncoding.GetString(FBody.Bytes, 0, FBody.Size);
  except
    on E: Exception do
    begin
      raise ERESTClientLib.Build(FRequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Response Body: %s', ['Content'])
        .Error(E.Message)
        .Hint('Check the error message.')
        .ClassName(Self.ClassName)
        .RequestMethod(FRequestMethod)
        .URL(FRequestURL);
    end;
  end;
end;

function TResponseBody.Content(const pEncoding: TEncoding): string;
begin
  Result := EmptyStr;
  if not Assigned(pEncoding) then
    Exit;

  Debug('Response Body: Content Encoding( %s )', [FEncoding.EncodingText]);

  try
    FBody.Position := 0;
    Result := FEncoding.GetString(FBody.Bytes, 0, FBody.Size);
  except
    on E: Exception do
    begin
      raise ERESTClientLib.Build(FRequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_REQUEST_VALIDATION)
        .Title('Response Body: Content Encoding( %s )', [pEncoding.EncodingText])
        .Error(E.Message)
        .Hint('Check the error message.')
        .ClassName(Self.ClassName)
        .RequestMethod(FRequestMethod)
        .URL(FRequestURL);
    end;
  end;
end;

function TResponseBody.ContentCompression: TRESTClientLibContentCompressionKind;
begin
  Result := FContentCompression;
  Debug('Response Body: ContentCompression( %s )', [Result.AsString]);
end;

function TResponseBody.IsBinary: Boolean;
begin
  Result := FIsBinary;
  Debug('Response Body: IsBinary( %s )', [BoolToStr(Result, True)]);
end;

function TResponseBody.IsEmpty: Boolean;
begin
  FBody.Position := 0;
  Result := (FBody.Size = 0);
  Debug('Response Body: IsEmpty( %s )', [BoolToStr(Result, True)]);
end;

function TResponseBody.MIMEType: string;
begin
  Result := FMIMEType;
  Debug('Response Body: MIMEType( %s )', [Result]);
end;

function TResponseBody.MIMETypeExt: string;
begin
  Result := FMIMETypeExt;
  Debug('Response Body: MIMETypeExt( %s )', [Result]);
end;

function TResponseBody.Raw: TBytes;
begin
  Debug('Response Body: %s', ['Raw']);
  Result := FBody.Bytes;
end;

procedure TResponseBody.SaveToFile(const pFilePath: string);
begin
  Debug('Response Body: SaveToFile( %s )', [pFilePath]);
  try
    FBody.Position := 0;
    FBody.SaveToFile(pFilePath);
  except
    on E: Exception do
    begin
      raise ERESTClientLib.Build(FRequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_OTHERS)
        .Title('Response Body: SaveToFile( %s )', [pFilePath])
        .Error(E.Message)
        .Hint('Check the error message.')
        .ClassName(Self.ClassName)
        .RequestMethod(FRequestMethod)
        .URL(FRequestURL);
    end;
  end;
end;

procedure TResponseBody.SaveToFileFromContentDisposition(const pPath: string);
var
  lFileName: string;
  lFilePath: string;
  lPath: string;
begin
  Debug('Response Body: %s', ['SaveToFileFromContentDisposition']);
  FBody.Position := 0;
  if (FBody.Size = 0) then
    Exit;

  lFileName := GetFileNameFromContentDisposition(FResponse.Headers.ContentDisposition);
  if (lFileName = EmptyStr) then
    Exit;

  lPath := Trim(pPath);
  if (lPath = EmptyStr) then
    lPath := GetCurrentDir;

  lFilePath := Format('%s%s', [IncludeTrailingPathDelimiter(lPath), lFileName]);
  Debug('Response Body: SaveToFileFromContentDisposition( %s )', [lFilePath]);
  try
    FBody.SaveToFile(lFilePath);
  except
    on E: Exception do
    begin
      raise ERESTClientLib.Build(FRequestLibrary)
        .&Type(TRESTClientLibExceptionKind.E_OTHERS)
        .Title('Response Body: SaveToFileFromContentDisposition( %s )', [lFilePath])
        .Error(E.Message)
        .Hint('Check the error message.')
        .ClassName(Self.ClassName)
        .RequestMethod(FRequestMethod)
        .URL(FRequestURL);
    end;
  end;
end;

function TResponseBody.Size: Int64;
begin
  FBody.Position := 0;
  Result := FBody.Size;
  Debug('Response Body: Size( %d )', [Result]);
end;

function TResponseBody.SizeAsString: string;
const
  KB = 1024;
  MB = KB * KB;
  GB = Int64(MB) * KB;
  TB = Int64(GB) * KB;
var
  lSize: Int64;
  lAbsSize: Int64;
begin
  lSize := Self.Size;
  lAbsSize := Abs(lSize);

  if (lAbsSize < (2 * KB)) then
    Result := Format('%d bytes', [lSize])
  else if (lAbsSize < (2 * MB)) then
    Result := Format('%.3f KB', [(lSize / KB)])
  else if (lAbsSize < (2 * GB)) then
    Result := Format('%.3f MB', [(lSize / MB)])
  else if (lAbsSize < (2 * TB)) then
    Result := Format('%.3f GB', [(lSize / GB)])
  else
    Result := Format('%.3f TB', [(lSize / TB)]);

  Debug('Response Body: SizeAsString( %s )', [Result]);
end;
{$ENDREGION}

end.
