{******************************************************************************}
{                                                                              }
{           RESTClientLib.pas                                                  }
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
unit RESTClientLib;

interface

uses
  RESTClientLib.Types, RESTClientLib.Interfaces;

type
  TRESTClientLibRequestLibraryKind = RESTClientLib.Types.TRESTClientLibRequestLibraryKind;
  TRESTClientLibRequestMethodKind = RESTClientLib.Types.TRESTClientLibRequestMethodKind;
  TRESTClientLibHeaderOptionKind = RESTClientLib.Types.TRESTClientLibHeaderOptionKind;
  TRESTClientLibExceptionKind = RESTClientLib.Types.TRESTClientLibExceptionKind;
  ERESTClientLib = RESTClientLib.Types.ERESTClientLib;
  IRESTClientLib = RESTClientLib.Interfaces.IRESTClientLib;
  IResponse = RESTClientLib.Interfaces.IResponse;

  TRESTClientLib = class sealed(TInterfacedObject, IRESTClientLib)
  private
    { private declarations }
    FDebugLib: Boolean;
    FRequestLibrary: TRESTClientLibRequestLibraryKind;
    FRequestOptions: IRequestOptions;
    FRequestURL: IRequestURL;
    FRequestAuthentication: IRequestAuthentication;
    FRequestCookies: IRequestCookies;
    FRequestHeaders: IRequestHeaders;
    FRequestMultipartFormData: IRequestMultipartFormData;
    FRequestBody: IRequestBody;
    FRequestExecute: IRequestExecute;
    function DebugLib: Boolean; overload;
    function DebugLib(const pDebug: Boolean): IRESTClientLib; overload;
    function GetOptions: IRequestOptions;
    function GetURL: IRequestURL;
    function GetAuthentication: IRequestAuthentication;
    function GetCookies: IRequestCookies;
    function GetHeaders: IRequestHeaders;
    function GetMultipartFormData: IRequestMultipartFormData;
    function GetBody: IRequestBody;
    function GetRequest: IRequestExecute;
    function GetRequestLibrary: TRESTClientLibRequestLibraryKind;
    constructor Create(const pRequestLibrary: TRESTClientLibRequestLibraryKind); reintroduce;
  protected
    { protected declarations }
  public
    { public declarations }
    class function Build: IRESTClientLib; overload;
    class function Build(const RequestLibrary: TRESTClientLibRequestLibraryKind): IRESTClientLib; overload;
  end;

implementation

uses
  RESTClientLib.Core, RESTClientLib.Factory, RESTClientLib.Utils, RESTClientLib.Consts;

{$I RESTClientLib.inc}

{$REGION 'TRESTClientLib'}
class function TRESTClientLib.Build(const RequestLibrary: TRESTClientLibRequestLibraryKind): IRESTClientLib;
begin
  Result := Self.Create(RequestLibrary);
end;

class function TRESTClientLib.Build: IRESTClientLib;
begin
  Result := Self.Create(TRESTClientLibRequestLibraryKind.NetHTTP);
end;

constructor TRESTClientLib.Create(const pRequestLibrary: TRESTClientLibRequestLibraryKind);
begin
  try
    FDebugLib := True;
    TDebugger.Debug('*** RESTClientLib v%s ***', [RESTClientLibVersion]);

    FRequestLibrary := pRequestLibrary;
    FRequestOptions := TRequestOptions.Create(Self);
    FRequestURL := TRequestURL.Create(Self);
    FRequestHeaders := TRequestHeaders.Create(Self);
    FRequestAuthentication := TRequestAuthentication.Create(Self);
    FRequestCookies := TRequestCookies.Create(Self);
    FRequestMultipartFormData := TRequestMultipartFormData.Create(Self);
    FRequestBody := TRequestBody.Create(Self);
    FRequestExecute := TRequestExecuteFactory.Build(Self, pRequestLibrary);
  finally
    FDebugLib := False;
  end;
end;

function TRESTClientLib.DebugLib: Boolean;
begin
  Result := FDebugLib;
end;

function TRESTClientLib.DebugLib(const pDebug: Boolean): IRESTClientLib;
begin
  Result := Self;
  FDebugLib := pDebug;
end;

function TRESTClientLib.GetAuthentication: IRequestAuthentication;
begin
  Result := FRequestAuthentication;
end;

function TRESTClientLib.GetBody: IRequestBody;
begin
  Result := FRequestBody;
end;

function TRESTClientLib.GetCookies: IRequestCookies;
begin
  Result := FRequestCookies;
end;

function TRESTClientLib.GetMultipartFormData: IRequestMultipartFormData;
begin
  Result := FRequestMultipartFormData;
end;

function TRESTClientLib.GetHeaders: IRequestHeaders;
begin
  Result := FRequestHeaders;
end;

function TRESTClientLib.GetOptions: IRequestOptions;
begin
  Result := FRequestOptions;
end;

function TRESTClientLib.GetRequest: IRequestExecute;
begin
  Result := FRequestExecute;
end;

function TRESTClientLib.GetRequestLibrary: TRESTClientLibRequestLibraryKind;
begin
  Result := FRequestLibrary;
end;

function TRESTClientLib.GetURL: IRequestURL;
begin
  Result := FRequestURL;
end;
{$ENDREGION}

end.
