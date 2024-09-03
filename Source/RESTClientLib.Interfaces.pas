{******************************************************************************}
{                                                                              }
{           RESTClientLib.Interfaces.pas                                       }
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
unit RESTClientLib.Interfaces;

interface

uses
  System.Classes, System.JSON, System.Rtti, System.SysUtils, RESTClientLib.Types;

type
  IRequestOptions = interface;
  IRequestURL = interface;
  IRequestAuthentication = interface;
  IRequestCookies = interface;
  IRequestHeaders = interface;
  IRequestMultipartFormData = interface;
  IRequestBody = interface;
  IRequestExecute = interface;

  IRESTClientLib = interface
    ['{658FE527-DB54-4B65-AB4F-2DA2ECD755E3}']
    function GetOptions: IRequestOptions;
    function GetURL: IRequestURL;
    function GetAuthentication: IRequestAuthentication;
    function GetCookies: IRequestCookies;
    function GetHeaders: IRequestHeaders;
    function GetBody: IRequestBody;
    function GetMultipartFormData: IRequestMultipartFormData;
    function GetRequest: IRequestExecute;
    function DebugLib: Boolean; overload;
    function DebugLib(const Debug: Boolean): IRESTClientLib; overload;
    function GetRequestLibrary: TRESTClientLibRequestLibraryKind;

    property RequestLibrary: TRESTClientLibRequestLibraryKind read GetRequestLibrary;
    property Options: IRequestOptions read GetOptions;
    property URL: IRequestURL read GetURL;
    property Authentication: IRequestAuthentication read GetAuthentication;
    property Cookies: IRequestCookies read GetCookies;
    property Headers: IRequestHeaders read GetHeaders;
    property MultipartFormData: IRequestMultipartFormData read GetMultipartFormData;
    property Body: IRequestBody read GetBody;
    property Request: IRequestExecute read GetRequest;
  end;

  IRequestEncoding = interface
    ['{74FA259D-551F-4BD5-BA47-285E70D9C0B5}']
    function Reset: IRequestEncoding;
    function Encoding: TEncoding; overload;
    function Encoding(const Encoding: TEncoding): IRequestEncoding; overload;
    function Encoding(const CodePage: Integer): IRequestEncoding; overload;
    function Encoding(const Charset: string): IRequestEncoding; overload;
    function &End: IRequestOptions;
  end;

  IRequestCertificate = interface
    ['{E39C781B-1F1C-4596-985A-AEF5C03F4E5D}']
    function Reset: IRequestCertificate;
    function CertFile: string; overload;
    function CertFile(const Value: string): IRequestCertificate; overload;
    function KeyFile: string; overload;
    function KeyFile(const Value: string): IRequestCertificate; overload;
    function &End: IRequestOptions;
  end;

  IRequestRedirects = interface
    ['{A1905A02-4CE2-4EF6-B3F5-615FEF5F9200}']
    function Reset: IRequestRedirects;
    function Active: Boolean; overload;
    function Active(const Value: Boolean): IRequestRedirects; overload;
    function MaxRedirects: Integer; overload;
    function MaxRedirects(const Value: Integer): IRequestRedirects; overload;
    function &End: IRequestOptions;
  end;

  IRequestProxy = interface
    ['{E39C781B-1F1C-4596-985A-AEF5C03F4E5D}']
    function Reset: IRequestProxy;
    function Server: string; overload;
    function Server(const Value: string): IRequestProxy; overload;
    function Port: Integer; overload;
    function Port(const Value: Integer): IRequestProxy; overload;
    function User: string; overload;
    function User(const Value: string): IRequestProxy; overload;
    function Password: string; overload;
    function Password(const Value: string): IRequestProxy; overload;
    function &End: IRequestOptions;
  end;

  IRequestOptions = interface
    ['{7B3A2C3A-9881-414F-A811-58C42FCDCE45}']
    function Reset: IRequestOptions;
    function Certificate: IRequestCertificate;
    function Encoding: IRequestEncoding;
    function HeaderOptions: TRESTClientLibHeaderOptions; overload;
    function HeaderOptions(const HeaderOptions: TRESTClientLibHeaderOptions): IRequestOptions; overload;
    function Proxy: IRequestProxy;
    function Redirects: IRequestRedirects;
    function RequestTimeout: Integer; overload;
    function RequestTimeout(const Value: Integer): IRequestOptions; overload;
    function ResponseTimeout: Integer; overload;
    function ResponseTimeout(const Value: Integer): IRequestOptions; overload;
    function Retries(const Tries: Integer; const DelayInMilliseconds: Integer = 1000): IRequestOptions; overload;
    function Retries: TRequestRetries; overload;
    function &End: IRESTClientLib;
  end;

  IRequestAuthentication = interface
    ['{8F90BA3B-C416-43F4-88B2-6F1A121A1D9F}']
    function Reset: IRequestAuthentication;
    function Basic(const User: string; const Password: string): IRESTClientLib;
    function Bearer(const Token: string): IRESTClientLib;
    function Token(const Token: string): IRESTClientLib;
  end;

  IRequestCookies = interface
    ['{1363978C-9743-404B-92DA-D1413C5E9D74}']
    function Reset: IRequestCookies;
    function Add(const Name: string; const Value: string; const Encode: Boolean = False): IRequestCookies; overload;
    function Find(const Name: string): string;
    function Contains(const Name: string): Boolean;
    function Remove(const Name: string): IRequestCookies;
    function Cookies(const Cookies: TStrings; const Encode: Boolean = False): IRequestCookies; overload;
    function Cookies: TCookiesValues; overload;
    function ToLine: string;
    function &End: IRESTClientLib;
  end;

  IRequestParams = interface;
  IRequestURL = interface
    ['{229F3014-0746-4D99-956E-D6CAAA11CDB7}']
    function Reset: IRequestURL;
    function BaseURL: string; overload;
    function BaseURL(const Value: string): IRequestURL; overload;
    function Resource: string; overload;
    function Resource(const Value: string): IRequestURL; overload;
    function FullURL: string;
    function FullURLWithoutQueryParams: string;
    function PathParams: IRequestParams;
    function QueryParams: IRequestParams;
    function &End: IRESTClientLib;
  end;

  IRequestParams = interface
    ['{F8CC5EFD-1239-42FD-B4BE-15F3008BC714}']
    function Clear: IRequestParams;
    function Add(const Name: string; const Value: TValue): IRequestParams;
    function Find(const Name: string): TValue;
    function Contains(const Name: string): Boolean;
    function Remove(const Name: string): IRequestParams;
    function Params: TParamsValues;
    function &End: IRequestURL;
  end;

  // https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
  IRequestHeaders = interface
    ['{74264A75-F4D6-4C1B-8F2F-CEEF489E3D73}']
    function Reset: IRequestHeaders;
    function Add(const Name: string; const Value: string; const Encode: Boolean = False): IRequestHeaders;
    function Find(const Name: string): string;
    function Contains(const Name: string): Boolean;
    function Remove(const Name: string): IRequestHeaders;
    function Headers: THeadersValues;
    function Accept: string; overload;
    function Accept(const Value: string): IRequestHeaders; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const Value: string): IRequestHeaders; overload;
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const Value: string): IRequestHeaders; overload;
    function AcceptLanguage: string; overload;
    function AcceptLanguage(const Value: string): IRequestHeaders; overload;
    function CacheControl: string; overload;
    function CacheControl(const Value: string): IRequestHeaders; overload;
    function ConnectionKeepAlive: Boolean; overload;
    function ConnectionKeepAlive(const Value: Boolean): IRequestHeaders; overload;
    function ContentEncoding: string; overload;
    function ContentEncoding(const Value: string): IRequestHeaders; overload;
    function ContentLanguage: string; overload;
    function ContentLanguage(const Value: string): IRequestHeaders; overload;
    function ContentType: string; overload;
    function ContentType(const Value: string): IRequestHeaders; overload;
    function ContentType(const Value: string; const Encoding: TEncoding): IRequestHeaders; overload;
    function IfNoneMatch: string; overload;
    function IfNoneMatch(const Value: string): IRequestHeaders; overload;
    function Referer: string; overload;
    function Referer(const Value: string): IRequestHeaders; overload;
    function RequestID: string;
    function RequestTime: string;
    function RequestLib: string;
    function RequestPlatform: string;
    function UserAgent: string; overload;
    function UserAgent(const Value: string): IRequestHeaders; overload;
    function &End: IRESTClientLib;
  end;

  IRequestMultipartFormData = interface
    ['{16560AC3-4C7D-4183-8D9E-FE5FF783E82C}']
    function Reset: IRequestMultipartFormData;
    function Content: TStream; overload;
    function ContentType: string;
    function UseMultipartFormData: Boolean;
    function Field(const FieldName: string; const Value: string): IRequestMultipartFormData; overload;
    function Field(const FieldName: string; const Value: TStream; const ContentType: string = ''; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: string): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: TBytes; const Size: Int64): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: TObject; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: TJSONObject; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: TJSONArray; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function JSON(const FieldName: string; const Value: TJSONValue; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function LoadFromFile(const FieldName: string; const FilePath: string): IRequestMultipartFormData; overload;
    function LoadFromFile(const FieldName: string; const FileName: string; const Value: TStream; const OwnsObject: Boolean = True): IRequestMultipartFormData; overload;
    function &End: IRESTClientLib;
  end;

  IRequestBody = interface
    ['{5BE1B266-FAE6-44D2-9642-4CA33BFBD621}']
    function Reset: IRequestBody;
    function Content: TStream; overload;
    function Content(const Value: string): IRESTClientLib; overload;
    function Content(const Value: TStream; const OwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const Value: string): IRESTClientLib; overload;
    function JSON(const Value: TBytes; const Size: Int64): IRESTClientLib; overload;
    function JSON(const Value: TJSONValue; const OwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const Value: TJSONObject; const OwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const Value: TJSONArray; const OwnsObject: Boolean = True): IRESTClientLib; overload;
    function JSON(const Value: TObject; const OwnsObject: Boolean = True): IRESTClientLib; overload;
    function LoadFromFile(const FilePath: string): IRESTClientLib; overload;
    function LoadFromFile(const FileName: string; const Value: TStream; const OwnsObject: Boolean = True): IRESTClientLib; overload;
  end;

  IResponse = interface;
  IRequestExecute = interface
    ['{25744B6D-AE5F-4155-8B47-81646F99CEE2}']
    function Get: IResponse;
    function Post: IResponse;
    function Put: IResponse;
    function Patch: IResponse;
    function Delete: IResponse;
    function Merge: IResponse;
    function Head: IResponse;
    function Options: IResponse;
    function Trace: IResponse;
    function FromString(const Method: string): IResponse;
    function FromType(const Method: TRESTClientLibRequestMethodKind): IResponse;
  end;

  IResponseHeaders = interface;
  IResponseCookies = interface;
  IResponseBody = interface;

  IResponse = interface
    ['{6A684C01-E406-4EB3-A9F1-83D613D1998C}']
    function GetHeaders: IResponseHeaders;
    function GetCookies: IResponseCookies;
    function GetBody: IResponseBody;
    function GetRequestTime: Int64;
    function GetRequestTimeAsString: string;
    function GetStatusCode: Integer;
    function GetStatusCodeAsString: string;
    function GetStatusText: string;
    function GetVersionHTTP: string;
    function GetURL: string;

    property Headers: IResponseHeaders read GetHeaders;
    property Cookies: IResponseCookies read GetCookies;
    property Body: IResponseBody read GetBody;
    property RequestTime: Int64 read GetRequestTime;
    property RequestTimeAsString: string read GetRequestTimeAsString;
    property StatusCode: Integer read GetStatusCode;
    property StatusCodeAsString: string read GetStatusCodeAsString;
    property StatusText: string read GetStatusText;
    property VersionHTTP: string read GetVersionHTTP;
    property URL: string read GetURL;
  end;

  IResponseHeaders = interface
    ['{3EBBAE30-E70E-4E2D-8C63-F4DF6FB0A1E8}']
    function Find(const Name: string): string;
    function Contains(const Name: string): Boolean;
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
    function ToString: string;
  end;

  IResponseCookies = interface
    ['{1363978C-9743-404B-92DA-D1413C5E9D74}']
    function Find(const Name: string): string;
    function Contains(const Name: string): Boolean;
    function Cookies: TCookiesValues; overload;
    function ToString: string;
  end;

  IResponseBody = interface
    ['{D8D83389-6659-4222-A267-85FFEDCB4B8F}']
    function CharSet: string;
    function Encoding: TEncoding;
    function ContentCompression: TRESTClientLibContentCompressionKind;
    function IsEmpty: Boolean;
    function IsBinary: Boolean;
    function MIMEType: string;
    function MIMETypeExt: string;
    function Content: string; overload;
    function Content(const Encoding: TEncoding): string; overload;
    function AsJSON(const Encoding: TEncoding): TJSONValue; overload;
    function AsJSON: TJSONValue; overload;
    function AsStream: TStream;
    function Raw: TBytes;
    function Size: Int64;
    function SizeAsString: string;
    procedure SaveToFileFromContentDisposition(const Path: string = '');
    procedure SaveToFile(const FilePath: string);
  end;

implementation

end.
