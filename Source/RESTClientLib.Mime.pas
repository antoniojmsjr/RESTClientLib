{******************************************************************************}
{                                                                              }
{           RESTClientLib.Mime.pas                                             }
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
unit RESTClientLib.Mime;

interface

type
  TRESTClientLibMimeTypes = class
  public
    class function FileType(const FileName: string): string; overload;
    class function FileType(const FileName: string; out IsBinary: Boolean): string; overload;
    class function FileExtType(const FileExt: string): string; overload; static;
    class function FileExtType(const FileExt: string; out IsBinary: Boolean): string; overload;
    class function FromContentType(const &Type: string; out FileExt: string): Boolean; overload;
    class function FromContentType(const &Type: string; out FileExt: string; out IsBinary: Boolean): Boolean; overload;
    class procedure AddType(const FileExt: string; const &Type: string; const IsBinary: Boolean);
  end;

implementation

uses
  RESTClientLib.Net.Mime;

{$REGION 'TRESTClientLibMimeTypes'}
class function TRESTClientLibMimeTypes.FileType(const FileName: string): string;
var
  lKind: TMimeTypes.TKind;
begin
  TMimeTypes.Default.GetFileInfo(FileName, Result, lKind);
end;

class function TRESTClientLibMimeTypes.FileType(const FileName: string; out IsBinary: Boolean): string;
var
  lKind: TMimeTypes.TKind;
begin
  TMimeTypes.Default.GetFileInfo(FileName, Result, lKind);
  IsBinary := (lKind = TMimeTypes.TKind.Binary);
end;

class function TRESTClientLibMimeTypes.FileExtType(const FileExt: string): string;
var
  lKind: TMimeTypes.TKind;
begin
  TMimeTypes.Default.GetExtInfo(FileExt, Result, lKind);
end;

class procedure TRESTClientLibMimeTypes.AddType(const FileExt: string; const &Type: string; const IsBinary: Boolean);
var
  lKind: TMimeTypes.TKind;
begin
  lKind := TMimeTypes.TKind.Text;
  if IsBinary then
    lKind := TMimeTypes.TKind.Binary;
  TMimeTypes.Default.AddType(FileExt, &Type, lKind);
end;

class function TRESTClientLibMimeTypes.FileExtType(const FileExt: string; out IsBinary: Boolean): string;
var
  lKind: TMimeTypes.TKind;
begin
  TMimeTypes.Default.GetExtInfo(FileExt, Result, lKind);
  IsBinary := (lKind = TMimeTypes.TKind.Binary);
end;

class function TRESTClientLibMimeTypes.FromContentType(const &Type: string; out FileExt: string): Boolean;
var
  lKind: TMimeTypes.TKind;
begin
  Result := TMimeTypes.Default.GetTypeInfo(&Type, FileExt, lKind);
end;

class function TRESTClientLibMimeTypes.FromContentType(const &Type: string; out FileExt: string; out IsBinary: Boolean): Boolean;
var
  lKind: TMimeTypes.TKind;
begin
  Result := TMimeTypes.Default.GetTypeInfo(&Type, FileExt, lKind);
  IsBinary := (lKind = TMimeTypes.TKind.Binary);
end;

{$ENDREGION}

end.
