{******************************************************************************}
{                                                                              }
{           RESTClientLib.Factory.pas                                          }
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
unit RESTClientLib.Factory;

interface

uses
  System.SysUtils, RESTClientLib.Types, RESTClientLib.Interfaces;

type
  TRequestExecuteFactory = class sealed
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function Build(pRESTClientLib: IRESTClientLib; const pRequestLibrary: TRESTClientLibRequestLibraryKind): IRequestExecute;
  end;

implementation

uses
  RESTClientLib.Request.NetHTTP, RESTClientLib.Request.Indy, RESTClientLib.Request.Synapse;

{$REGION 'TRequestExecuteFactory'}
class function TRequestExecuteFactory.Build(pRESTClientLib: IRESTClientLib; const pRequestLibrary: TRESTClientLibRequestLibraryKind): IRequestExecute;
begin
  case pRequestLibrary of
    TRESTClientLibRequestLibraryKind.NetHTTP: Result := TRequestExecuteNetHTTP.Create(pRESTClientLib);
    TRESTClientLibRequestLibraryKind.Indy: Result := TRequestExecuteIndy.Create(pRESTClientLib);
    {$IFDEF RESTClientLib_SYNAPSE}
    TRESTClientLibRequestLibraryKind.Synapse: Result := TRequestExecuteSynapse.Create(pRESTClientLib);
    {$ENDIF RESTClientLib_SYNAPSE}
  else
    raise Exception.Create('Library not implemented...');
  end;
end;
{$ENDREGION}

end.
