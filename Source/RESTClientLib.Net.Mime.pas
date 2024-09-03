{*******************************************************}
{                                                       }
{           CodeGear Delphi 10.3.3 Runtime Library      }
{ Copyright(c) 2014-2019 Embarcadero Technologies, Inc. }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

/// <summary>Unit that holds functionality relative to process MIME parts from/to a network message</summary>
unit RESTClientLib.Net.Mime;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Sysutils, System.Generics.Collections, System.Generics.Defaults;

type
  /// <summary>Class to manage multipart form data</summary>
  TMultipartFormData = class (TObject)
  private
    FOwnsOutputStream: Boolean;
    FBoundary: string;
    FStream: TMemoryStream;
    FLastBoundaryWrited: Boolean;
    FUseMultipartFormData: Boolean;
    function GetMimeTypeHeader: string;
    function GenerateBoundary: string;
    procedure WriteStringLn(const AString: string);
    function GetStream: TMemoryStream;
    procedure AdjustLastBoundary;
  public
    /// <summary>Create a multipart form data object</summary>
    constructor Create(AOwnsOutputStream: Boolean = True);
    destructor Destroy; override;
    /// <summary>Add a form data field</summary>
    procedure AddField(const AField, AValue: string);
    /// <summary>Add a form data stream</summary>
    procedure AddStream(const AField: string; AStream: TStream; const AFileName: string = ''; const AContentType: string = '');
    /// <summary>Add a form data file</summary>
    procedure AddFile(const AField, AFilePath: string; const AContentType: string = '');
    /// <summary>Add a form data bytes</summary>
    procedure AddBytes(const AField: string; const ABytes: TBytes; const AFileName: string = ''; const AContentType: string = '');
    /// <summary>Property to access to the stream which will be sent</summary>
    property Stream: TMemoryStream read GetStream;
    /// <summary>Return mime type to be sent in http headers</summary>
    property MimeTypeHeader: string read GetMimeTypeHeader;
    property UseMultipartFormData: Boolean read FUseMultipartFormData;
  end;

  TMimeTypes = class (TObject)
  public type
    TKind = (Undefined, Binary, Text);
    TIterateFunc = reference to function (const AExt, AType: string; AKind: TKind): Boolean;
  private type
    TInfo = class
      FExt: string;
      FType: string;
      FKind: TKind;
    end;
  strict private
    class var
      FLock: TObject;
      FDefault: TMimeTypes;
    class constructor Create;
    class destructor Destroy;
    class function GetDefault: TMimeTypes; static;
  private
    FExtDict: TDictionary<string, TInfo>;
    FTypeDict: TDictionary<string, TInfo>;
    FInfos: TObjectDictionary<string, TInfo>;
    function NormalizeExt(const AExt: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function GetFileInfo(const AFileName: string; out AType: string; out AKind: TKind): Boolean;
    function GetExtInfo(const AExt: string; out AType: string; out AKind: TKind): Boolean;
    function GetTypeInfo(const AType: string; out AExt: string; out AKind: TKind): Boolean;
    procedure Clear;
    procedure AddDefTypes;
    procedure AddOSTypes;
    procedure AddType(const AExt, AType: string; AKind: TKind = TKind.Undefined; AIgnoreDups: Boolean = False);
    procedure ForAll(const AExtMask, ATypeMask: string; AFunc: TIterateFunc);
    procedure ForExts(const AExtMask: string; AFunc: TIterateFunc);
    procedure ForTypes(const ATypeMask: string; AFunc: TIterateFunc);
    class property Default: TMimeTypes read GetDefault;
  end;

  TAcceptValueItem = class (TObject)
  private
    FName: string;
    FWeight: Double;
    FOrder: Integer;
    FParams: TStrings;
    function GetParams: TStrings;
  protected
    procedure Parse; virtual;
  public
    destructor Destroy; override;
    property Name: string read FName;
    property Weight: Double read FWeight;
    property Order: Integer read FOrder;
    property Params: TStrings read GetParams;
  end;

  TAcceptValueListBase<T: TAcceptValueItem, constructor> = class (TObject)
  public type
    TAcceptFunc = reference to function (const AName: string; AWeight: Double;
      AItem: T): Boolean;
  private type
    TMatchMode = (Forward, Reverse, Intersect);
  private
    FInvariant: TFormatSettings;
    FItems: TObjectList<T>;
    FUpdates: Integer;
    function GetCount: Integer;
    function GetNames(AIndex: Integer): string;
    function GetWeights(AIndex: Integer): Double;
    function GetItems(AIndex: Integer): T;
    function InternalNegotiate(AAcceptList: TAcceptValueListBase<T>;
      AAcceptFunc: TAcceptFunc; var AMode: TMatchMode; out AWeight: Double): string;
  public
    constructor Create; overload;
    constructor Create(const AValue: string); overload;
    destructor Destroy; override;
    function GetEnumerator: TEnumerator<T>;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    procedure Add(const AName: string; AWeight: Double = 1; AExtra: TStrings = nil);
    procedure Assign(const AAcceptList: TAcceptValueListBase<T>);
    procedure Parse(const AValue: string);
    function ToString: string; override;
    function Negotiate(const AAcceptList: TAcceptValueListBase<T>; out AWeight: Double;
      AAcceptFunc: TAcceptFunc): string; overload;
    function Negotiate(const AAcceptList: string; out AWeight: Double;
      AAcceptFunc: TAcceptFunc): string; overload;
    procedure Intersect(const AAcceptList: TAcceptValueListBase<T>);
    class function CompareWeights(AWeight1, AWeight2: Double): Integer; static;
    property Count: Integer read GetCount;
    property Names[AIndex: Integer]: string read GetNames; default;
    property Weights[AIndex: Integer]: Double read GetWeights;
    property Items[AIndex: Integer]: T read GetItems;
  end;

  TAcceptValueList = TAcceptValueListBase<TAcceptValueItem>;

  THeaderValueList = class (TObject)
  private type
    TFlag = (Quoted, KeyOnly);
    TFlags = set of TFlag;
    TItem = record
      FName, FValue: string;
      FFlags: TFlags;
    end;
  private
    FItems: TList<TItem>;
    FSubject: string;
    function GetNames(AIndex: Integer): string;
    function GetValue(const AName: string): string;
    function GetValues(AIndex: Integer): string;
    function IndexOfName(const AName: string): Integer;
    procedure Add(const AItem: TItem); overload;
    function GetCount: Integer;
  public
    constructor Create; overload;
    constructor Create(const AValue: string); overload;
    destructor Destroy; override;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    procedure Add(const AName: string); overload;
    procedure Add(const AName, AValue: string; AQuoteVal: Boolean = True); overload;
    procedure Assign(const AValueList: THeaderValueList);
    procedure Parse(const AValue: string);
    function ToString: string; override;
    procedure Merge(const AValueList: THeaderValueList); overload;
    procedure Merge(const AValue: string); overload;
    property Count: Integer read GetCount;
    property Subject: string read FSubject write FSubject;
    property Names[AIndex: Integer]: string read GetNames;
    property Values[AIndex: Integer]: string read GetValues;
    property Value[const AName: string]: string read GetValue; default;
  end;

// -------------------------------------------------------------------------------- //
// -------------------------------------------------------------------------------- //

implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry,
{$ENDIF}
{$IFDEF POSIX}
  System.IOUtils,
{$ENDIF}
  System.Masks;

{ TMultipartFormData }

constructor TMultipartFormData.Create(AOwnsOutputStream: Boolean);
begin
  inherited Create;
  FUseMultipartFormData := False;
  FOwnsOutputStream := AOwnsOutputStream;
  FBoundary := GenerateBoundary;
  FStream := TMemoryStream.Create;
end;

destructor TMultipartFormData.Destroy;
begin
  if FOwnsOutputStream then
    FStream.Free
  else
    // Check that last boundary is written
    GetStream;
  inherited;
end;

procedure TMultipartFormData.AddField(const AField, AValue: string);
begin
  FUseMultipartFormData := True;
  AdjustLastBoundary;
  WriteStringLn('--' + FBoundary);
  // We need 2 line breaks here
  WriteStringLn('Content-Disposition' + ': form-data; name="' + AField + '"' + #13#10); // do not localize
  WriteStringLn(AValue);
end;

procedure TMultipartFormData.AddStream(const AField: string; AStream: TStream;
  const AFileName: string; const AContentType: string);
var
  LLine, LType: string;
  LKind: TMimeTypes.TKind;
begin
  FUseMultipartFormData := True;
  AdjustLastBoundary;
  WriteStringLn('--' + FBoundary);
  LLine := 'Content-Disposition' + ': form-data; name="' + AField + '"'; // do not localize
  if AFileName <> '' then
    LLine := LLine + '; filename="' + AFileName + '"'; // do not localize
  WriteStringLn(LLine);
  LType := AContentType;
  if LType = '' then
    TMimeTypes.Default.GetFileInfo(AFileName, LType, LKind);
  // We need 2 line breaks here
  WriteStringLn('Content-Type' + ': ' + LType + #13#10);
  FStream.CopyFrom(AStream, 0);
  WriteStringLn('');
end;

procedure TMultipartFormData.AddFile(const AField, AFilePath: string;
  const AContentType: string);
var
  LFileStream: TFileStream;
begin
  FUseMultipartFormData := True;
  LFileStream := TFileStream.Create(AFilePath, fmOpenRead or fmShareDenyWrite);
  try
    AddStream(AField, LFileStream, ExtractFileName(AFilePath), AContentType);
  finally
    LFileStream.Free;
  end;
end;

procedure TMultipartFormData.AddBytes(const AField: string;
  const ABytes: TBytes; const AFileName, AContentType: string);
var
  LBytesStream: TBytesStream;
begin
  FUseMultipartFormData := True;
  LBytesStream := TBytesStream.Create(ABytes);
  try
    AddStream(AField, LBytesStream, AFileName, AContentType);
  finally
    LBytesStream.Free;
  end;
end;

procedure TMultipartFormData.AdjustLastBoundary;
begin
  if FLastBoundaryWrited then
  begin
    FStream.Position := FStream.Size - (Length(FBoundary) + 4);
    FLastBoundaryWrited := False;
  end;
end;

function TMultipartFormData.GetMimeTypeHeader: string;
begin
  Result := 'multipart/form-data; boundary=' + FBoundary; // do not localize
end;

function TMultipartFormData.GetStream: TMemoryStream;
begin
  if not FLastBoundaryWrited then
  begin
    WriteStringLn('--' + FBoundary + '--');
    FLastBoundaryWrited := True;
  end;
  Result := FStream;
end;

procedure TMultipartFormData.WriteStringLn(const AString: string);
var
  Buff: TBytes;
begin
  Buff := TEncoding.UTF8.GetBytes(AString + #13#10);
  FStream.WriteBuffer(Buff, Length(Buff));
end;

function TMultipartFormData.GenerateBoundary: string;
begin
  Randomize;
  Result := '-------Embt-Boundary--' + IntToHex(Random(MaxInt), 8) + IntToHex(Random(MaxInt), 8); // do not localize
end;

{ TMimeTypes }

constructor TMimeTypes.Create;
begin
  inherited Create;
  FExtDict := TDictionary<string, TInfo>.Create(1024);
  FTypeDict := TDictionary<string, TInfo>.Create(1024);
  FInfos := TObjectDictionary<string, TInfo>.Create([doOwnsValues], 1024);
end;

destructor TMimeTypes.Destroy;
begin
  Clear;
  FTypeDict.Free;
  FExtDict.Free;
  FInfos.Free;
  inherited Destroy;
end;

class function TMimeTypes.GetDefault: TMimeTypes;
var
  LMime: TMimeTypes;
begin
  if FDefault = nil then
  begin
    TMonitor.Enter(FLock);
    try
      if FDefault = nil then
      begin
        LMime := TMimeTypes.Create;
        LMime.AddDefTypes;
        LMime.AddOSTypes;
        FDefault := LMime;
      end;
    finally
      TMonitor.Exit(FLock);
    end;
  end;
  Result := FDefault;
end;

class constructor TMimeTypes.Create;
begin
  FLock := TObject.Create;
end;

class destructor TMimeTypes.Destroy;
begin
  FreeAndNil(FDefault);
  FreeAndNil(FLock);
end;

procedure TMimeTypes.AddDefTypes;
begin
 {$REGION 'MIME CONST'}
  AddType('ez', 'application/andrew-inset'); // do not localize
  AddType('aw', 'application/applixware'); // do not localize
  AddType('atom', 'application/atom+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('atomcat', 'application/atomcat+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('atomsvc', 'application/atomsvc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('bson', 'application/bson', TMimeTypes.TKind.Binary); // do not localize
  AddType('ccxml', 'application/ccxml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('cdmia', 'application/cdmi-capability'); // do not localize
  AddType('cdmic', 'application/cdmi-container'); // do not localize
  AddType('cdmid', 'application/cdmi-domain'); // do not localize
  AddType('cdmio', 'application/cdmi-object'); // do not localize
  AddType('cdmiq', 'application/cdmi-queue'); // do not localize
  AddType('cu', 'application/cu-seeme'); // do not localize
  AddType('davmount', 'application/davmount+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dbk', 'application/docbook+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dssc', 'application/dssc+der'); // do not localize
  AddType('xdssc', 'application/dssc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ecma', 'application/ecmascript', TMimeTypes.TKind.Text); // do not localize
  AddType('emma', 'application/emma+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('epub', 'application/epub+zip', TMimeTypes.TKind.Binary); // do not localize
  AddType('exi', 'application/exi'); // do not localize
  AddType('pfr', 'application/font-tdpfr'); // do not localize
  AddType('gml', 'application/gml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('gpx', 'application/gpx+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('gxf', 'application/gxf'); // do not localize
  AddType('stk', 'application/hyperstudio'); // do not localize
  AddType('ink', 'application/inkml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('inkml', 'application/inkml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ipfix', 'application/ipfix'); // do not localize
  AddType('jar', 'application/java-archive', TMimeTypes.TKind.Binary); // do not localize
  AddType('ser', 'application/java-serialized-object', TMimeTypes.TKind.Binary); // do not localize
  AddType('class', 'application/java-vm', TMimeTypes.TKind.Binary); // do not localize
  AddType('js', 'application/javascript', TMimeTypes.TKind.Text); // do not localize
  AddType('js', 'application/x-javascript', TMimeTypes.TKind.Text); // do not localize
  AddType('js', 'text/javascript', TMimeTypes.TKind.Text); // do not localize
  AddType('json', 'application/json', TMimeTypes.TKind.Text); // do not localize
  AddType('jsonml', 'application/jsonml+json', TMimeTypes.TKind.Text); // do not localize
  AddType('lostxml', 'application/lost+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('hqx', 'application/mac-binhex40'); // do not localize
  AddType('cpt', 'application/mac-compactpro'); // do not localize
  AddType('mads', 'application/mads+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mrc', 'application/marc'); // do not localize
  AddType('mrcx', 'application/marcxml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ma', 'application/mathematica'); // do not localize
  AddType('nb', 'application/mathematica'); // do not localize
  AddType('mb', 'application/mathematica'); // do not localize
  AddType('mathml', 'application/mathml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mbox', 'application/mbox'); // do not localize
  AddType('mscml', 'application/mediaservercontrol+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('metalink', 'application/metalink+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('meta4', 'application/metalink4+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mets', 'application/mets+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mods', 'application/mods+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('m21', 'application/mp21'); // do not localize
  AddType('mp21', 'application/mp21'); // do not localize
  AddType('mp4s', 'application/mp4'); // do not localize
  AddType('doc', 'application/msword'); // do not localize
  AddType('dot', 'application/msword'); // do not localize
  AddType('mxf', 'application/mxf'); // do not localize
  AddType('bin', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('bpk', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('class', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('deploy', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('dist', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('distz', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('dmg', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('dms', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('dump', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('elc', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('iso', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('lha', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('lrf', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('lzh', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('mar', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('pkg', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('so', 'application/octet-stream', TMimeTypes.TKind.Binary); // do not localize
  AddType('oda', 'application/oda'); // do not localize
  AddType('opf', 'application/oebps-package+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ogx', 'application/ogg'); // do not localize
  AddType('omdoc', 'application/omdoc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('onetoc', 'application/onenote'); // do not localize
  AddType('onetoc2', 'application/onenote'); // do not localize
  AddType('onetmp', 'application/onenote'); // do not localize
  AddType('onepkg', 'application/onenote'); // do not localize
  AddType('oxps', 'application/oxps'); // do not localize
  AddType('xer', 'application/patch-ops-error+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('pdf', 'application/pdf', TMimeTypes.TKind.Binary); // do not localize
  AddType('pgp', 'application/pgp-encrypted'); // do not localize
  AddType('asc', 'application/pgp-signature'); // do not localize
  AddType('sig', 'application/pgp-signature'); // do not localize
  AddType('prf', 'application/pics-rules'); // do not localize
  AddType('p10', 'application/pkcs10'); // do not localize
  AddType('p7m', 'application/pkcs7-mime'); // do not localize
  AddType('p7c', 'application/pkcs7-mime'); // do not localize
  AddType('p7s', 'application/pkcs7-signature'); // do not localize
  AddType('p8', 'application/pkcs8'); // do not localize
  AddType('ac', 'application/pkix-attr-cert'); // do not localize
  AddType('cer', 'application/pkix-cert'); // do not localize
  AddType('crl', 'application/pkix-crl'); // do not localize
  AddType('pkipath', 'application/pkix-pkipath'); // do not localize
  AddType('pki', 'application/pkixcmp'); // do not localize
  AddType('pls', 'application/pls+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ai', 'application/postscript'); // do not localize
  AddType('eps', 'application/postscript'); // do not localize
  AddType('ps', 'application/postscript'); // do not localize
  AddType('cww', 'application/prs.cww'); // do not localize
  AddType('pskcxml', 'application/pskc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rdf', 'application/rdf+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rif', 'application/reginfo+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rnc', 'application/relax-ng-compact-syntax'); // do not localize
  AddType('rl', 'application/resource-lists+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rld', 'application/resource-lists-diff+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rs', 'application/rls-services+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('gbr', 'application/rpki-ghostbusters'); // do not localize
  AddType('mft', 'application/rpki-manifest'); // do not localize
  AddType('roa', 'application/rpki-roa'); // do not localize
  AddType('rsd', 'application/rsd+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rss', 'application/rss+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rtf', 'application/rtf'); // do not localize
  AddType('sbml', 'application/sbml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('scq', 'application/scvp-cv-request'); // do not localize
  AddType('scs', 'application/scvp-cv-response'); // do not localize
  AddType('spq', 'application/scvp-vp-request'); // do not localize
  AddType('spp', 'application/scvp-vp-response'); // do not localize
  AddType('sdp', 'application/sdp'); // do not localize
  AddType('setpay', 'application/set-payment-initiation'); // do not localize
  AddType('setreg', 'application/set-registration-initiation'); // do not localize
  AddType('shf', 'application/shf+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('smi', 'application/smil+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('smil', 'application/smil+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('soap', 'application/soap+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('rq', 'application/sparql-query'); // do not localize
  AddType('srx', 'application/sparql-results+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('gram', 'application/srgs'); // do not localize
  AddType('grxml', 'application/srgs+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('sru', 'application/sru+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ssdl', 'application/ssdl+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ssml', 'application/ssml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('tei', 'application/tei+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('teicorpus', 'application/tei+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('tfi', 'application/thraud+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('tsd', 'application/timestamped-data'); // do not localize
  AddType('plb', 'application/vnd.3gpp.pic-bw-large'); // do not localize
  AddType('psb', 'application/vnd.3gpp.pic-bw-small'); // do not localize
  AddType('pvb', 'application/vnd.3gpp.pic-bw-var'); // do not localize
  AddType('tcap', 'application/vnd.3gpp2.tcap'); // do not localize
  AddType('pwn', 'application/vnd.3m.post-it-notes'); // do not localize
  AddType('aso', 'application/vnd.accpac.simply.aso'); // do not localize
  AddType('imp', 'application/vnd.accpac.simply.imp'); // do not localize
  AddType('acu', 'application/vnd.acucobol'); // do not localize
  AddType('atc', 'application/vnd.acucorp'); // do not localize
  AddType('acutc', 'application/vnd.acucorp'); // do not localize
  AddType('air', 'application/vnd.adobe.air-application-installer-package+zip'); // do not localize
  AddType('fcdt', 'application/vnd.adobe.formscentral.fcdt'); // do not localize
  AddType('fxp', 'application/vnd.adobe.fxp'); // do not localize
  AddType('fxpl', 'application/vnd.adobe.fxp'); // do not localize
  AddType('xdp', 'application/vnd.adobe.xdp+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xfdf', 'application/vnd.adobe.xfdf'); // do not localize
  AddType('ahead', 'application/vnd.ahead.space'); // do not localize
  AddType('azf', 'application/vnd.airzip.filesecure.azf'); // do not localize
  AddType('azs', 'application/vnd.airzip.filesecure.azs'); // do not localize
  AddType('azw', 'application/vnd.amazon.ebook'); // do not localize
  AddType('acc', 'application/vnd.americandynamics.acc'); // do not localize
  AddType('ami', 'application/vnd.amiga.ami'); // do not localize
  AddType('apk', 'application/vnd.android.package-archive'); // do not localize
  AddType('cii', 'application/vnd.anser-web-certificate-issue-initiation'); // do not localize
  AddType('fti', 'application/vnd.anser-web-funds-transfer-initiation'); // do not localize
  AddType('atx', 'application/vnd.antix.game-component'); // do not localize
  AddType('mpkg', 'application/vnd.apple.installer+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('m3u8', 'application/vnd.apple.mpegurl'); // do not localize
  AddType('swi', 'application/vnd.aristanetworks.swi'); // do not localize
  AddType('iota', 'application/vnd.astraea-software.iota'); // do not localize
  AddType('aep', 'application/vnd.audiograph'); // do not localize
  AddType('mpm', 'application/vnd.blueice.multipass'); // do not localize
  AddType('bmi', 'application/vnd.bmi'); // do not localize
  AddType('rep', 'application/vnd.businessobjects'); // do not localize
  AddType('cdxml', 'application/vnd.chemdraw+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mmd', 'application/vnd.chipnuts.karaoke-mmd'); // do not localize
  AddType('cdy', 'application/vnd.cinderella'); // do not localize
  AddType('cla', 'application/vnd.claymore'); // do not localize
  AddType('rp9', 'application/vnd.cloanto.rp9'); // do not localize
  AddType('c4g', 'application/vnd.clonk.c4group'); // do not localize
  AddType('c4d', 'application/vnd.clonk.c4group'); // do not localize
  AddType('c4f', 'application/vnd.clonk.c4group'); // do not localize
  AddType('c4p', 'application/vnd.clonk.c4group'); // do not localize
  AddType('c4u', 'application/vnd.clonk.c4group'); // do not localize
  AddType('c11amc', 'application/vnd.cluetrust.cartomobile-config'); // do not localize
  AddType('c11amz', 'application/vnd.cluetrust.cartomobile-config-pkg'); // do not localize
  AddType('csp', 'application/vnd.commonspace'); // do not localize
  AddType('cdbcmsg', 'application/vnd.contact.cmsg'); // do not localize
  AddType('cmc', 'application/vnd.cosmocaller'); // do not localize
  AddType('clkx', 'application/vnd.crick.clicker'); // do not localize
  AddType('clkk', 'application/vnd.crick.clicker.keyboard'); // do not localize
  AddType('clkp', 'application/vnd.crick.clicker.palette'); // do not localize
  AddType('clkt', 'application/vnd.crick.clicker.template'); // do not localize
  AddType('clkw', 'application/vnd.crick.clicker.wordbank'); // do not localize
  AddType('wbs', 'application/vnd.criticaltools.wbs+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('pml', 'application/vnd.ctc-posml'); // do not localize
  AddType('ppd', 'application/vnd.cups-ppd'); // do not localize
  AddType('car', 'application/vnd.curl.car'); // do not localize
  AddType('pcurl', 'application/vnd.curl.pcurl'); // do not localize
  AddType('dart', 'application/vnd.dart'); // do not localize
  AddType('rdz', 'application/vnd.data-vision.rdz'); // do not localize
  AddType('uvf', 'application/vnd.dece.data'); // do not localize
  AddType('uvvf', 'application/vnd.dece.data'); // do not localize
  AddType('uvd', 'application/vnd.dece.data'); // do not localize
  AddType('uvvd', 'application/vnd.dece.data'); // do not localize
  AddType('uvt', 'application/vnd.dece.ttml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('uvvt', 'application/vnd.dece.ttml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('uvx', 'application/vnd.dece.unspecified'); // do not localize
  AddType('uvvx', 'application/vnd.dece.unspecified'); // do not localize
  AddType('uvz', 'application/vnd.dece.zip'); // do not localize
  AddType('uvvz', 'application/vnd.dece.zip'); // do not localize
  AddType('fe_launch', 'application/vnd.denovo.fcselayout-link'); // do not localize
  AddType('dna', 'application/vnd.dna'); // do not localize
  AddType('mlp', 'application/vnd.dolby.mlp'); // do not localize
  AddType('dpg', 'application/vnd.dpgraph'); // do not localize
  AddType('dfac', 'application/vnd.dreamfactory'); // do not localize
  AddType('kpxx', 'application/vnd.ds-keypoint'); // do not localize
  AddType('ait', 'application/vnd.dvb.ait'); // do not localize
  AddType('svc', 'application/vnd.dvb.service'); // do not localize
  AddType('geo', 'application/vnd.dynageo'); // do not localize
  AddType('mag', 'application/vnd.ecowin.chart'); // do not localize
  AddType('nml', 'application/vnd.enliven'); // do not localize
  AddType('esf', 'application/vnd.epson.esf'); // do not localize
  AddType('msf', 'application/vnd.epson.msf'); // do not localize
  AddType('qam', 'application/vnd.epson.quickanime'); // do not localize
  AddType('slt', 'application/vnd.epson.salt'); // do not localize
  AddType('ssf', 'application/vnd.epson.ssf'); // do not localize
  AddType('es3', 'application/vnd.eszigno3+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('et3', 'application/vnd.eszigno3+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('ez2', 'application/vnd.ezpix-album'); // do not localize
  AddType('ez3', 'application/vnd.ezpix-package'); // do not localize
  AddType('fdf', 'application/vnd.fdf'); // do not localize
  AddType('mseed', 'application/vnd.fdsn.mseed'); // do not localize
  AddType('seed', 'application/vnd.fdsn.seed'); // do not localize
  AddType('dataless', 'application/vnd.fdsn.seed'); // do not localize
  AddType('gph', 'application/vnd.flographit'); // do not localize
  AddType('ftc', 'application/vnd.fluxtime.clip'); // do not localize
  AddType('fm', 'application/vnd.framemaker'); // do not localize
  AddType('frame', 'application/vnd.framemaker'); // do not localize
  AddType('maker', 'application/vnd.framemaker'); // do not localize
  AddType('book', 'application/vnd.framemaker'); // do not localize
  AddType('fnc', 'application/vnd.frogans.fnc'); // do not localize
  AddType('ltf', 'application/vnd.frogans.ltf'); // do not localize
  AddType('fsc', 'application/vnd.fsc.weblaunch'); // do not localize
  AddType('oas', 'application/vnd.fujitsu.oasys'); // do not localize
  AddType('oa2', 'application/vnd.fujitsu.oasys2'); // do not localize
  AddType('oa3', 'application/vnd.fujitsu.oasys3'); // do not localize
  AddType('fg5', 'application/vnd.fujitsu.oasysgp'); // do not localize
  AddType('bh2', 'application/vnd.fujitsu.oasysprs'); // do not localize
  AddType('ddd', 'application/vnd.fujixerox.ddd'); // do not localize
  AddType('xdw', 'application/vnd.fujixerox.docuworks'); // do not localize
  AddType('xbd', 'application/vnd.fujixerox.docuworks.binder'); // do not localize
  AddType('fzs', 'application/vnd.fuzzysheet'); // do not localize
  AddType('txd', 'application/vnd.genomatix.tuxedo'); // do not localize
  AddType('ggb', 'application/vnd.geogebra.file'); // do not localize
  AddType('ggt', 'application/vnd.geogebra.tool'); // do not localize
  AddType('gex', 'application/vnd.geometry-explorer'); // do not localize
  AddType('gre', 'application/vnd.geometry-explorer'); // do not localize
  AddType('gxt', 'application/vnd.geonext'); // do not localize
  AddType('g2w', 'application/vnd.geoplan'); // do not localize
  AddType('g3w', 'application/vnd.geospace'); // do not localize
  AddType('gmx', 'application/vnd.gmx'); // do not localize
  AddType('kml', 'application/vnd.google-earth.kml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('kmz', 'application/vnd.google-earth.kmz'); // do not localize
  AddType('gqf', 'application/vnd.grafeq'); // do not localize
  AddType('gqs', 'application/vnd.grafeq'); // do not localize
  AddType('gac', 'application/vnd.groove-account'); // do not localize
  AddType('ghf', 'application/vnd.groove-help'); // do not localize
  AddType('gim', 'application/vnd.groove-identity-message'); // do not localize
  AddType('grv', 'application/vnd.groove-injector'); // do not localize
  AddType('gtm', 'application/vnd.groove-tool-message'); // do not localize
  AddType('tpl', 'application/vnd.groove-tool-template'); // do not localize
  AddType('vcg', 'application/vnd.groove-vcard'); // do not localize
  AddType('hal', 'application/vnd.hal+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('zmm', 'application/vnd.handheld-entertainment+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('hbci', 'application/vnd.hbci'); // do not localize
  AddType('les', 'application/vnd.hhe.lesson-player'); // do not localize
  AddType('hpgl', 'application/vnd.hp-hpgl'); // do not localize
  AddType('hpid', 'application/vnd.hp-hpid'); // do not localize
  AddType('hps', 'application/vnd.hp-hps'); // do not localize
  AddType('jlt', 'application/vnd.hp-jlyt'); // do not localize
  AddType('pcl', 'application/vnd.hp-pcl'); // do not localize
  AddType('pclxl', 'application/vnd.hp-pclxl'); // do not localize
  AddType('sfd-hdstx', 'application/vnd.hydrostatix.sof-data'); // do not localize
  AddType('mpy', 'application/vnd.ibm.minipay'); // do not localize
  AddType('afp', 'application/vnd.ibm.modcap'); // do not localize
  AddType('listafp', 'application/vnd.ibm.modcap'); // do not localize
  AddType('list3820', 'application/vnd.ibm.modcap'); // do not localize
  AddType('irm', 'application/vnd.ibm.rights-management'); // do not localize
  AddType('sc', 'application/vnd.ibm.secure-container'); // do not localize
  AddType('icc', 'application/vnd.iccprofile'); // do not localize
  AddType('icm', 'application/vnd.iccprofile'); // do not localize
  AddType('igl', 'application/vnd.igloader'); // do not localize
  AddType('ivp', 'application/vnd.immervision-ivp'); // do not localize
  AddType('ivu', 'application/vnd.immervision-ivu'); // do not localize
  AddType('igm', 'application/vnd.insors.igm'); // do not localize
  AddType('xpw', 'application/vnd.intercon.formnet'); // do not localize
  AddType('xpx', 'application/vnd.intercon.formnet'); // do not localize
  AddType('i2g', 'application/vnd.intergeo'); // do not localize
  AddType('qbo', 'application/vnd.intu.qbo'); // do not localize
  AddType('qfx', 'application/vnd.intu.qfx'); // do not localize
  AddType('rcprofile', 'application/vnd.ipunplugged.rcprofile'); // do not localize
  AddType('irp', 'application/vnd.irepository.package+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xpr', 'application/vnd.is-xpr'); // do not localize
  AddType('fcs', 'application/vnd.isac.fcs'); // do not localize
  AddType('jam', 'application/vnd.jam'); // do not localize
  AddType('rms', 'application/vnd.jcp.javame.midlet-rms'); // do not localize
  AddType('jisp', 'application/vnd.jisp'); // do not localize
  AddType('joda', 'application/vnd.joost.joda-archive'); // do not localize
  AddType('ktz', 'application/vnd.kahootz'); // do not localize
  AddType('ktr', 'application/vnd.kahootz'); // do not localize
  AddType('karbon', 'application/vnd.kde.karbon'); // do not localize
  AddType('chrt', 'application/vnd.kde.kchart'); // do not localize
  AddType('kfo', 'application/vnd.kde.kformula'); // do not localize
  AddType('flw', 'application/vnd.kde.kivio'); // do not localize
  AddType('kon', 'application/vnd.kde.kontour'); // do not localize
  AddType('kpr', 'application/vnd.kde.kpresenter'); // do not localize
  AddType('kpt', 'application/vnd.kde.kpresenter'); // do not localize
  AddType('ksp', 'application/vnd.kde.kspread'); // do not localize
  AddType('kwd', 'application/vnd.kde.kword'); // do not localize
  AddType('kwt', 'application/vnd.kde.kword'); // do not localize
  AddType('htke', 'application/vnd.kenameaapp'); // do not localize
  AddType('kia', 'application/vnd.kidspiration'); // do not localize
  AddType('kne', 'application/vnd.kinar'); // do not localize
  AddType('knp', 'application/vnd.kinar'); // do not localize
  AddType('skp', 'application/vnd.koan'); // do not localize
  AddType('skd', 'application/vnd.koan'); // do not localize
  AddType('skt', 'application/vnd.koan'); // do not localize
  AddType('skm', 'application/vnd.koan'); // do not localize
  AddType('sse', 'application/vnd.kodak-descriptor'); // do not localize
  AddType('lasxml', 'application/vnd.las.las+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('lbd', 'application/vnd.llamagraphics.life-balance.desktop'); // do not localize
  AddType('lbe', 'application/vnd.llamagraphics.life-balance.exchange+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('123', 'application/vnd.lotus-1-2-3'); // do not localize
  AddType('apr', 'application/vnd.lotus-approach'); // do not localize
  AddType('pre', 'application/vnd.lotus-freelance'); // do not localize
  AddType('nsf', 'application/vnd.lotus-notes'); // do not localize
  AddType('org', 'application/vnd.lotus-organizer'); // do not localize
  AddType('scm', 'application/vnd.lotus-screencam'); // do not localize
  AddType('lwp', 'application/vnd.lotus-wordpro'); // do not localize
  AddType('portpkg', 'application/vnd.macports.portpkg'); // do not localize
  AddType('mcd', 'application/vnd.mcd'); // do not localize
  AddType('mc1', 'application/vnd.medcalcdata'); // do not localize
  AddType('cdkey', 'application/vnd.mediastation.cdkey'); // do not localize
  AddType('mwf', 'application/vnd.mfer'); // do not localize
  AddType('mfm', 'application/vnd.mfmp'); // do not localize
  AddType('flo', 'application/vnd.micrografx.flo'); // do not localize
  AddType('igx', 'application/vnd.micrografx.igx'); // do not localize
  AddType('mif', 'application/vnd.mif'); // do not localize
  AddType('daf', 'application/vnd.mobius.daf'); // do not localize
  AddType('dis', 'application/vnd.mobius.dis'); // do not localize
  AddType('mbk', 'application/vnd.mobius.mbk'); // do not localize
  AddType('mqy', 'application/vnd.mobius.mqy'); // do not localize
  AddType('msl', 'application/vnd.mobius.msl'); // do not localize
  AddType('plc', 'application/vnd.mobius.plc'); // do not localize
  AddType('txf', 'application/vnd.mobius.txf'); // do not localize
  AddType('mpn', 'application/vnd.mophun.application'); // do not localize
  AddType('mpc', 'application/vnd.mophun.certificate'); // do not localize
  AddType('xul', 'application/vnd.mozilla.xul+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('cil', 'application/vnd.ms-artgalry'); // do not localize
  AddType('cab', 'application/vnd.ms-cab-compressed'); // do not localize
  AddType('xls', 'application/vnd.ms-excel'); // do not localize
  AddType('xlm', 'application/vnd.ms-excel'); // do not localize
  AddType('xla', 'application/vnd.ms-excel'); // do not localize
  AddType('xlc', 'application/vnd.ms-excel'); // do not localize
  AddType('xlt', 'application/vnd.ms-excel'); // do not localize
  AddType('xlw', 'application/vnd.ms-excel'); // do not localize
  AddType('xlam', 'application/vnd.ms-excel.addin.macroenabled.12'); // do not localize
  AddType('xlsb', 'application/vnd.ms-excel.sheet.binary.macroenabled.12'); // do not localize
  AddType('xlsm', 'application/vnd.ms-excel.sheet.macroenabled.12'); // do not localize
  AddType('xltm', 'application/vnd.ms-excel.template.macroenabled.12'); // do not localize
  AddType('eot', 'application/vnd.ms-fontobject'); // do not localize
  AddType('chm', 'application/vnd.ms-htmlhelp'); // do not localize
  AddType('ims', 'application/vnd.ms-ims'); // do not localize
  AddType('lrm', 'application/vnd.ms-lrm'); // do not localize
  AddType('thmx', 'application/vnd.ms-officetheme'); // do not localize
  AddType('cat', 'application/vnd.ms-pki.seccat'); // do not localize
  AddType('stl', 'application/vnd.ms-pki.stl'); // do not localize
  AddType('ppt', 'application/vnd.ms-powerpoint'); // do not localize
  AddType('pps', 'application/vnd.ms-powerpoint'); // do not localize
  AddType('pot', 'application/vnd.ms-powerpoint'); // do not localize
  AddType('ppam', 'application/vnd.ms-powerpoint.addin.macroenabled.12'); // do not localize
  AddType('pptm', 'application/vnd.ms-powerpoint.presentation.macroenabled.12'); // do not localize
  AddType('sldm', 'application/vnd.ms-powerpoint.slide.macroenabled.12'); // do not localize
  AddType('ppsm', 'application/vnd.ms-powerpoint.slideshow.macroenabled.12'); // do not localize
  AddType('potm', 'application/vnd.ms-powerpoint.template.macroenabled.12'); // do not localize
  AddType('mpp', 'application/vnd.ms-project'); // do not localize
  AddType('mpt', 'application/vnd.ms-project'); // do not localize
  AddType('docm', 'application/vnd.ms-word.document.macroenabled.12'); // do not localize
  AddType('dotm', 'application/vnd.ms-word.template.macroenabled.12'); // do not localize
  AddType('wps', 'application/vnd.ms-works'); // do not localize
  AddType('wks', 'application/vnd.ms-works'); // do not localize
  AddType('wcm', 'application/vnd.ms-works'); // do not localize
  AddType('wdb', 'application/vnd.ms-works'); // do not localize
  AddType('wpl', 'application/vnd.ms-wpl'); // do not localize
  AddType('xps', 'application/vnd.ms-xpsdocument'); // do not localize
  AddType('mseq', 'application/vnd.mseq'); // do not localize
  AddType('mus', 'application/vnd.musician'); // do not localize
  AddType('msty', 'application/vnd.muvee.style'); // do not localize
  AddType('taglet', 'application/vnd.mynfc'); // do not localize
  AddType('nlu', 'application/vnd.neurolanguage.nlu'); // do not localize
  AddType('ntf', 'application/vnd.nitf'); // do not localize
  AddType('nitf', 'application/vnd.nitf'); // do not localize
  AddType('nnd', 'application/vnd.noblenet-directory'); // do not localize
  AddType('nns', 'application/vnd.noblenet-sealer'); // do not localize
  AddType('nnw', 'application/vnd.noblenet-web'); // do not localize
  AddType('ngdat', 'application/vnd.nokia.n-gage.data'); // do not localize
  AddType('n-gage', 'application/vnd.nokia.n-gage.symbian.install'); // do not localize
  AddType('rpst', 'application/vnd.nokia.radio-preset'); // do not localize
  AddType('rpss', 'application/vnd.nokia.radio-presets'); // do not localize
  AddType('edm', 'application/vnd.novadigm.edm'); // do not localize
  AddType('edx', 'application/vnd.novadigm.edx'); // do not localize
  AddType('FExt', 'application/vnd.novadigm.FExt'); // do not localize
  AddType('odc', 'application/vnd.oasis.opendocument.chart'); // do not localize
  AddType('otc', 'application/vnd.oasis.opendocument.chart-template'); // do not localize
  AddType('odb', 'application/vnd.oasis.opendocument.database'); // do not localize
  AddType('odf', 'application/vnd.oasis.opendocument.formula'); // do not localize
  AddType('odft', 'application/vnd.oasis.opendocument.formula-template'); // do not localize
  AddType('odg', 'application/vnd.oasis.opendocument.graphics'); // do not localize
  AddType('otg', 'application/vnd.oasis.opendocument.graphics-template'); // do not localize
  AddType('odi', 'application/vnd.oasis.opendocument.image'); // do not localize
  AddType('oti', 'application/vnd.oasis.opendocument.image-template'); // do not localize
  AddType('odp', 'application/vnd.oasis.opendocument.presentation'); // do not localize
  AddType('otp', 'application/vnd.oasis.opendocument.presentation-template'); // do not localize
  AddType('ods', 'application/vnd.oasis.opendocument.spreadsheet'); // do not localize
  AddType('ots', 'application/vnd.oasis.opendocument.spreadsheet-template'); // do not localize
  AddType('odt', 'application/vnd.oasis.opendocument.text'); // do not localize
  AddType('odm', 'application/vnd.oasis.opendocument.text-master'); // do not localize
  AddType('ott', 'application/vnd.oasis.opendocument.text-template'); // do not localize
  AddType('oth', 'application/vnd.oasis.opendocument.text-web'); // do not localize
  AddType('xo', 'application/vnd.olpc-sugar'); // do not localize
  AddType('dd2', 'application/vnd.oma.dd2+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('oxt', 'application/vnd.openofficeorg.extension'); // do not localize
  AddType('pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation'); // do not localize
  AddType('sldx', 'application/vnd.openxmlformats-officedocument.presentationml.slide'); // do not localize
  AddType('ppsx', 'application/vnd.openxmlformats-officedocument.presentationml.slideshow'); // do not localize
  AddType('potx', 'application/vnd.openxmlformats-officedocument.presentationml.template'); // do not localize
  AddType('xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'); // do not localize
  AddType('xltx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.template'); // do not localize
  AddType('docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'); // do not localize
  AddType('dotx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template'); // do not localize
  AddType('mgp', 'application/vnd.osgeo.mapguide.package'); // do not localize
  AddType('dp', 'application/vnd.osgi.dp'); // do not localize
  AddType('esa', 'application/vnd.osgi.subsystem'); // do not localize
  AddType('pdb', 'application/vnd.palm'); // do not localize
  AddType('pqa', 'application/vnd.palm'); // do not localize
  AddType('oprc', 'application/vnd.palm'); // do not localize
  AddType('paw', 'application/vnd.pawaafile'); // do not localize
  AddType('str', 'application/vnd.pg.format'); // do not localize
  AddType('ei6', 'application/vnd.pg.osasli'); // do not localize
  AddType('efif', 'application/vnd.picsel'); // do not localize
  AddType('wg', 'application/vnd.pmi.widget'); // do not localize
  AddType('plf', 'application/vnd.pocketlearn'); // do not localize
  AddType('pbd', 'application/vnd.powerbuilder6'); // do not localize
  AddType('box', 'application/vnd.previewsystems.box'); // do not localize
  AddType('mgz', 'application/vnd.proteus.magazine'); // do not localize
  AddType('qps', 'application/vnd.publishare-delta-tree'); // do not localize
  AddType('ptid', 'application/vnd.pvi.ptid1'); // do not localize
  AddType('qxd', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('qxt', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('qwd', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('qwt', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('qxl', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('qxb', 'application/vnd.quark.quarkxpress'); // do not localize
  AddType('bed', 'application/vnd.realvnc.bed'); // do not localize
  AddType('mxl', 'application/vnd.recordare.musicxml'); // do not localize
  AddType('musicxml', 'application/vnd.recordare.musicxml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('cryptonote', 'application/vnd.rig.cryptonote'); // do not localize
  AddType('cod', 'application/vnd.rim.cod'); // do not localize
  AddType('rm', 'application/vnd.rn-realmedia'); // do not localize
  AddType('rmvb', 'application/vnd.rn-realmedia-vbr'); // do not localize
  AddType('link66', 'application/vnd.route66.link66+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('st', 'application/vnd.sailingtracker.track'); // do not localize
  AddType('see', 'application/vnd.seemail'); // do not localize
  AddType('sema', 'application/vnd.sema'); // do not localize
  AddType('semd', 'application/vnd.semd'); // do not localize
  AddType('semf', 'application/vnd.semf'); // do not localize
  AddType('ifm', 'application/vnd.shana.informed.formdata'); // do not localize
  AddType('itp', 'application/vnd.shana.informed.formtemplate'); // do not localize
  AddType('iif', 'application/vnd.shana.informed.interchange'); // do not localize
  AddType('ipk', 'application/vnd.shana.informed.package'); // do not localize
  AddType('twd', 'application/vnd.simtech-mindmapper'); // do not localize
  AddType('twds', 'application/vnd.simtech-mindmapper'); // do not localize
  AddType('mmf', 'application/vnd.smaf'); // do not localize
  AddType('teacher', 'application/vnd.smart.teacher'); // do not localize
  AddType('sdkm', 'application/vnd.solent.sdkm+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('sdkd', 'application/vnd.solent.sdkm+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dxp', 'application/vnd.spotfire.dxp'); // do not localize
  AddType('sfs', 'application/vnd.spotfire.sfs'); // do not localize
  AddType('sdc', 'application/vnd.stardivision.calc'); // do not localize
  AddType('sda', 'application/vnd.stardivision.draw'); // do not localize
  AddType('sdd', 'application/vnd.stardivision.impress'); // do not localize
  AddType('smf', 'application/vnd.stardivision.math'); // do not localize
  AddType('sdw', 'application/vnd.stardivision.writer'); // do not localize
  AddType('vor', 'application/vnd.stardivision.writer'); // do not localize
  AddType('sgl', 'application/vnd.stardivision.writer-global'); // do not localize
  AddType('smzip', 'application/vnd.stepmania.package'); // do not localize
  AddType('sm', 'application/vnd.stepmania.stepchart'); // do not localize
  AddType('sxc', 'application/vnd.sun.xml.calc'); // do not localize
  AddType('stc', 'application/vnd.sun.xml.calc.template'); // do not localize
  AddType('sxd', 'application/vnd.sun.xml.draw'); // do not localize
  AddType('std', 'application/vnd.sun.xml.draw.template'); // do not localize
  AddType('sxi', 'application/vnd.sun.xml.impress'); // do not localize
  AddType('sti', 'application/vnd.sun.xml.impress.template'); // do not localize
  AddType('sxm', 'application/vnd.sun.xml.math'); // do not localize
  AddType('sxw', 'application/vnd.sun.xml.writer'); // do not localize
  AddType('sxg', 'application/vnd.sun.xml.writer.global'); // do not localize
  AddType('stw', 'application/vnd.sun.xml.writer.template'); // do not localize
  AddType('sus', 'application/vnd.sus-calendar'); // do not localize
  AddType('susp', 'application/vnd.sus-calendar'); // do not localize
  AddType('svd', 'application/vnd.svd'); // do not localize
  AddType('sis', 'application/vnd.symbian.install'); // do not localize
  AddType('sisx', 'application/vnd.symbian.install'); // do not localize
  AddType('xsm', 'application/vnd.syncml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('bdm', 'application/vnd.syncml.dm+wbxml'); // do not localize
  AddType('xdm', 'application/vnd.syncml.dm+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('tao', 'application/vnd.tao.intent-module-archive'); // do not localize
  AddType('pcap', 'application/vnd.tcpdump.pcap'); // do not localize
  AddType('cap', 'application/vnd.tcpdump.pcap'); // do not localize
  AddType('dmp', 'application/vnd.tcpdump.pcap'); // do not localize
  AddType('tmo', 'application/vnd.tmobile-livetv'); // do not localize
  AddType('tpt', 'application/vnd.trid.tpt'); // do not localize
  AddType('mxs', 'application/vnd.triscape.mxs'); // do not localize
  AddType('tra', 'application/vnd.trueapp'); // do not localize
  AddType('ufd', 'application/vnd.ufdl'); // do not localize
  AddType('ufdl', 'application/vnd.ufdl'); // do not localize
  AddType('utz', 'application/vnd.uiq.theme'); // do not localize
  AddType('umj', 'application/vnd.umajin'); // do not localize
  AddType('unityweb', 'application/vnd.unity'); // do not localize
  AddType('uoml', 'application/vnd.uoml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('vcx', 'application/vnd.vcx'); // do not localize
  AddType('vsd', 'application/vnd.visio'); // do not localize
  AddType('vst', 'application/vnd.visio'); // do not localize
  AddType('vss', 'application/vnd.visio'); // do not localize
  AddType('vsw', 'application/vnd.visio'); // do not localize
  AddType('vis', 'application/vnd.visionary'); // do not localize
  AddType('vsf', 'application/vnd.vsf'); // do not localize
  AddType('wbxml', 'application/vnd.wap.wbxml'); // do not localize
  AddType('wmlc', 'application/vnd.wap.wmlc'); // do not localize
  AddType('wmlsc', 'application/vnd.wap.wmlscriptc'); // do not localize
  AddType('wtb', 'application/vnd.webturbo'); // do not localize
  AddType('nbp', 'application/vnd.wolfram.player'); // do not localize
  AddType('wpd', 'application/vnd.wordperfect'); // do not localize
  AddType('wqd', 'application/vnd.wqd'); // do not localize
  AddType('stf', 'application/vnd.wt.stf'); // do not localize
  AddType('xar', 'application/vnd.xara'); // do not localize
  AddType('xfdl', 'application/vnd.xfdl'); // do not localize
  AddType('hvd', 'application/vnd.yamaha.hv-dic'); // do not localize
  AddType('hvs', 'application/vnd.yamaha.hv-script'); // do not localize
  AddType('hvp', 'application/vnd.yamaha.hv-voice'); // do not localize
  AddType('osf', 'application/vnd.yamaha.openscoreformat'); // do not localize
  AddType('osfpvg', 'application/vnd.yamaha.openscoreformat.osfpvg+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('saf', 'application/vnd.yamaha.smaf-audio'); // do not localize
  AddType('spf', 'application/vnd.yamaha.smaf-phrase'); // do not localize
  AddType('cmp', 'application/vnd.yellowriver-custom-menu'); // do not localize
  AddType('zir', 'application/vnd.zul'); // do not localize
  AddType('zirz', 'application/vnd.zul'); // do not localize
  AddType('zaz', 'application/vnd.zzazz.deck+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('vxml', 'application/voicexml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('wgt', 'application/widget'); // do not localize
  AddType('hlp', 'application/winhlp'); // do not localize
  AddType('wsdl', 'application/wsdl+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('wspolicy', 'application/wspolicy+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('abw', 'application/x-abiword'); // do not localize
  AddType('ace', 'application/x-ace-compressed'); // do not localize
  AddType('dmg', 'application/x-apple-diskimage'); // do not localize
  AddType('aab', 'application/x-authorware-bin'); // do not localize
  AddType('x32', 'application/x-authorware-bin'); // do not localize
  AddType('u32', 'application/x-authorware-bin'); // do not localize
  AddType('vox', 'application/x-authorware-bin'); // do not localize
  AddType('aam', 'application/x-authorware-map'); // do not localize
  AddType('aas', 'application/x-authorware-seg'); // do not localize
  AddType('bcpio', 'application/x-bcpio'); // do not localize
  AddType('torrent', 'application/x-bittorrent'); // do not localize
  AddType('blb', 'application/x-blorb'); // do not localize
  AddType('blorb', 'application/x-blorb'); // do not localize
  AddType('bz', 'application/x-bzip'); // do not localize
  AddType('bz2', 'application/x-bzip2'); // do not localize
  AddType('boz', 'application/x-bzip2'); // do not localize
  AddType('cbr', 'application/x-cbr'); // do not localize
  AddType('cba', 'application/x-cbr'); // do not localize
  AddType('cbt', 'application/x-cbr'); // do not localize
  AddType('cbz', 'application/x-cbr'); // do not localize
  AddType('cb7', 'application/x-cbr'); // do not localize
  AddType('vcd', 'application/x-cdlink'); // do not localize
  AddType('cfs', 'application/x-cfs-compressed'); // do not localize
  AddType('chat', 'application/x-chat'); // do not localize
  AddType('pgn', 'application/x-chess-pgn'); // do not localize
  AddType('nsc', 'application/x-conference'); // do not localize
  AddType('cpio', 'application/x-cpio'); // do not localize
  AddType('csh', 'application/x-csh'); // do not localize
  AddType('deb', 'application/x-debian-package'); // do not localize
  AddType('udeb', 'application/x-debian-package'); // do not localize
  AddType('dgc', 'application/x-dgc-compressed'); // do not localize
  AddType('dir', 'application/x-director'); // do not localize
  AddType('dcr', 'application/x-director'); // do not localize
  AddType('dxr', 'application/x-director'); // do not localize
  AddType('cst', 'application/x-director'); // do not localize
  AddType('cct', 'application/x-director'); // do not localize
  AddType('cxt', 'application/x-director'); // do not localize
  AddType('w3d', 'application/x-director'); // do not localize
  AddType('fgd', 'application/x-director'); // do not localize
  AddType('swa', 'application/x-director'); // do not localize
  AddType('wad', 'application/x-doom'); // do not localize
  AddType('ncx', 'application/x-dtbncx+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dtb', 'application/x-dtbook+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('res', 'application/x-dtbresource+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dvi', 'application/x-dvi'); // do not localize
  AddType('evy', 'application/x-envoy'); // do not localize
  AddType('eva', 'application/x-eva'); // do not localize
  AddType('bdf', 'application/x-font-bdf'); // do not localize
  AddType('gsf', 'application/x-font-ghostscript'); // do not localize
  AddType('psf', 'application/x-font-linux-psf'); // do not localize
  AddType('otf', 'application/x-font-otf'); // do not localize
  AddType('pcf', 'application/x-font-pcf'); // do not localize
  AddType('snf', 'application/x-font-snf'); // do not localize
  AddType('ttf', 'application/x-font-ttf'); // do not localize
  AddType('ttc', 'application/x-font-ttf'); // do not localize
  AddType('pfa', 'application/x-font-type1'); // do not localize
  AddType('pfb', 'application/x-font-type1'); // do not localize
  AddType('pfm', 'application/x-font-type1'); // do not localize
  AddType('afm', 'application/x-font-type1'); // do not localize
  AddType('woff', 'application/x-font-woff'); // do not localize
  AddType('arc', 'application/x-freearc'); // do not localize
  AddType('spl', 'application/x-futuresplash'); // do not localize
  AddType('gca', 'application/x-gca-compressed'); // do not localize
  AddType('ulx', 'application/x-glulx'); // do not localize
  AddType('gnumeric', 'application/x-gnumeric'); // do not localize
  AddType('gramps', 'application/x-gramps-xml'); // do not localize
  AddType('gtar', 'application/x-gtar'); // do not localize
  AddType('hdf', 'application/x-hdf'); // do not localize
  AddType('install', 'application/x-install-instructions'); // do not localize
  AddType('iso', 'application/x-iso9660-image'); // do not localize
  AddType('jnlp', 'application/x-java-jnlp-file'); // do not localize
  AddType('latex', 'application/x-latex'); // do not localize
  AddType('lzh', 'application/x-lzh-compressed'); // do not localize
  AddType('lha', 'application/x-lzh-compressed'); // do not localize
  AddType('mie', 'application/x-mie'); // do not localize
  AddType('prc', 'application/x-mobipocket-ebook'); // do not localize
  AddType('mobi', 'application/x-mobipocket-ebook'); // do not localize
  AddType('application', 'application/x-ms-application'); // do not localize
  AddType('lnk', 'application/x-ms-shortcut'); // do not localize
  AddType('wmd', 'application/x-ms-wmd'); // do not localize
  AddType('wmz', 'application/x-ms-wmz'); // do not localize
  AddType('xbap', 'application/x-ms-xbap'); // do not localize
  AddType('mdb', 'application/x-msaccess'); // do not localize
  AddType('obd', 'application/x-msbinder'); // do not localize
  AddType('crd', 'application/x-mscardfile'); // do not localize
  AddType('clp', 'application/x-msclip'); // do not localize
  AddType('exe', 'application/x-msdownload'); // do not localize
  AddType('dll', 'application/x-msdownload'); // do not localize
  AddType('com', 'application/x-msdownload'); // do not localize
  AddType('bat', 'application/x-msdownload'); // do not localize
  AddType('msi', 'application/x-msdownload'); // do not localize
  AddType('mvb', 'application/x-msmediaview'); // do not localize
  AddType('m13', 'application/x-msmediaview'); // do not localize
  AddType('m14', 'application/x-msmediaview'); // do not localize
  AddType('wmf', 'application/x-msmetafile'); // do not localize
  AddType('wmz', 'application/x-msmetafile'); // do not localize
  AddType('emf', 'application/x-msmetafile'); // do not localize
  AddType('emz', 'application/x-msmetafile'); // do not localize
  AddType('mny', 'application/x-msmoney'); // do not localize
  AddType('pub', 'application/x-mspublisher'); // do not localize
  AddType('scd', 'application/x-msschedule'); // do not localize
  AddType('trm', 'application/x-msterminal'); // do not localize
  AddType('wri', 'application/x-mswrite'); // do not localize
  AddType('nc', 'application/x-netcdf'); // do not localize
  AddType('cdf', 'application/x-netcdf'); // do not localize
  AddType('nzb', 'application/x-nzb'); // do not localize
  AddType('p12', 'application/x-pkcs12'); // do not localize
  AddType('pfx', 'application/x-pkcs12'); // do not localize
  AddType('p7b', 'application/x-pkcs7-certificates'); // do not localize
  AddType('spc', 'application/x-pkcs7-certificates'); // do not localize
  AddType('p7r', 'application/x-pkcs7-certreqresp'); // do not localize
  AddType('rar', 'application/x-rar-compressed'); // do not localize
  AddType('ris', 'application/x-research-info-systems'); // do not localize
  AddType('sh', 'application/x-sh'); // do not localize
  AddType('shar', 'application/x-shar'); // do not localize
  AddType('swf', 'application/x-shockwave-flash'); // do not localize
  AddType('xap', 'application/x-silverlight-app'); // do not localize
  AddType('sql', 'application/x-sql'); // do not localize
  AddType('sit', 'application/x-stuffit'); // do not localize
  AddType('sitx', 'application/x-stuffitx'); // do not localize
  AddType('srt', 'application/x-subrip'); // do not localize
  AddType('sv4cpio', 'application/x-sv4cpio'); // do not localize
  AddType('sv4crc', 'application/x-sv4crc'); // do not localize
  AddType('t3', 'application/x-t3vm-image'); // do not localize
  AddType('gam', 'application/x-tads'); // do not localize
  AddType('tar', 'application/x-tar'); // do not localize
  AddType('tcl', 'application/x-tcl'); // do not localize
  AddType('tex', 'application/x-tex'); // do not localize
  AddType('tfm', 'application/x-tex-tfm'); // do not localize
  AddType('texinfo', 'application/x-texinfo'); // do not localize
  AddType('texi', 'application/x-texinfo'); // do not localize
  AddType('obj', 'application/x-tgif'); // do not localize
  AddType('ustar', 'application/x-ustar'); // do not localize
  AddType('src', 'application/x-wais-source'); // do not localize
  AddType('der', 'application/x-x509-ca-cert'); // do not localize
  AddType('crt', 'application/x-x509-ca-cert'); // do not localize
  AddType('fig', 'application/x-xfig'); // do not localize
  AddType('xlf', 'application/x-xliff+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xpi', 'application/x-xpinstall'); // do not localize
  AddType('xz', 'application/x-xz'); // do not localize
  AddType('yaml', 'application/x-yaml', TMimeTypes.TKind.Text); // do not localize
  AddType('z1', 'application/x-zmachine'); // do not localize
  AddType('z2', 'application/x-zmachine'); // do not localize
  AddType('z3', 'application/x-zmachine'); // do not localize
  AddType('z4', 'application/x-zmachine'); // do not localize
  AddType('z5', 'application/x-zmachine'); // do not localize
  AddType('z6', 'application/x-zmachine'); // do not localize
  AddType('z7', 'application/x-zmachine'); // do not localize
  AddType('z8', 'application/x-zmachine'); // do not localize
  AddType('xaml', 'application/xaml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xdf', 'application/xcap-diff+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xenc', 'application/xenc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xhtml', 'application/xhtml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xht', 'application/xhtml+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xml', 'application/xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xsl', 'application/xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dtd', 'application/xml-dtd', TMimeTypes.TKind.Text); // do not localize
  AddType('xop', 'application/xop+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xpl', 'application/xproc+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xslt', 'application/xslt+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xspf', 'application/xspf+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('mxml', 'application/xv+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xhvml', 'application/xv+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xvml', 'application/xv+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xvm', 'application/xv+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('yang', 'application/yang'); // do not localize
  AddType('yin', 'application/yin+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('zip', 'application/zip', TMimeTypes.TKind.Binary); // do not localize
  AddType('zip', 'application/x-zip-compressed', TMimeTypes.TKind.Binary); // do not localize
  AddType('gz', 'application/gzip', TMimeTypes.TKind.Binary); // do not localize
  AddType('7z', 'application/x-7z-compressed', TMimeTypes.TKind.Binary); // do not localize
  AddType('adp', 'audio/adpcm', TMimeTypes.TKind.Binary); // do not localize
  AddType('au', 'audio/basic', TMimeTypes.TKind.Binary); // do not localize
  AddType('snd', 'audio/basic', TMimeTypes.TKind.Binary); // do not localize
  AddType('mid', 'audio/midi', TMimeTypes.TKind.Binary); // do not localize
  AddType('midi', 'audio/midi', TMimeTypes.TKind.Binary); // do not localize
  AddType('kar', 'audio/midi', TMimeTypes.TKind.Binary); // do not localize
  AddType('rmi', 'audio/midi', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp4a', 'audio/mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('mpga', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp2', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp2a', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp3', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('m2a', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('m3a', 'audio/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('oga', 'audio/ogg', TMimeTypes.TKind.Binary); // do not localize
  AddType('ogg', 'audio/ogg', TMimeTypes.TKind.Binary); // do not localize
  AddType('spx', 'audio/ogg', TMimeTypes.TKind.Binary); // do not localize
  AddType('s3m', 'audio/s3m', TMimeTypes.TKind.Binary); // do not localize
  AddType('sil', 'audio/silk', TMimeTypes.TKind.Binary); // do not localize
  AddType('uva', 'audio/vnd.dece.audio', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvva', 'audio/vnd.dece.audio', TMimeTypes.TKind.Binary); // do not localize
  AddType('eol', 'audio/vnd.digital-winds', TMimeTypes.TKind.Binary); // do not localize
  AddType('dra', 'audio/vnd.dra', TMimeTypes.TKind.Binary); // do not localize
  AddType('dts', 'audio/vnd.dts', TMimeTypes.TKind.Binary); // do not localize
  AddType('dtshd', 'audio/vnd.dts.hd', TMimeTypes.TKind.Binary); // do not localize
  AddType('lvp', 'audio/vnd.lucent.voice', TMimeTypes.TKind.Binary); // do not localize
  AddType('pya', 'audio/vnd.ms-playready.media.pya', TMimeTypes.TKind.Binary); // do not localize
  AddType('ecelp4800', 'audio/vnd.nuera.ecelp4800', TMimeTypes.TKind.Binary); // do not localize
  AddType('ecelp7470', 'audio/vnd.nuera.ecelp7470', TMimeTypes.TKind.Binary); // do not localize
  AddType('ecelp9600', 'audio/vnd.nuera.ecelp9600', TMimeTypes.TKind.Binary); // do not localize
  AddType('rip', 'audio/vnd.rip', TMimeTypes.TKind.Binary); // do not localize
  AddType('weba', 'audio/webm', TMimeTypes.TKind.Binary); // do not localize
  AddType('aac', 'audio/x-aac', TMimeTypes.TKind.Binary); // do not localize
  AddType('aif', 'audio/x-aiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('aiff', 'audio/x-aiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('aifc', 'audio/x-aiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('caf', 'audio/x-caf', TMimeTypes.TKind.Binary); // do not localize
  AddType('flac', 'audio/x-flac', TMimeTypes.TKind.Binary); // do not localize
  AddType('mka', 'audio/x-matroska', TMimeTypes.TKind.Binary); // do not localize
  AddType('m3u', 'audio/x-mpegurl', TMimeTypes.TKind.Binary); // do not localize
  AddType('wax', 'audio/x-ms-wax', TMimeTypes.TKind.Binary); // do not localize
  AddType('wma', 'audio/x-ms-wma', TMimeTypes.TKind.Binary); // do not localize
  AddType('ram', 'audio/x-pn-realaudio', TMimeTypes.TKind.Binary); // do not localize
  AddType('ra', 'audio/x-pn-realaudio', TMimeTypes.TKind.Binary); // do not localize
  AddType('rmp', 'audio/x-pn-realaudio-plugin', TMimeTypes.TKind.Binary); // do not localize
  AddType('wav', 'audio/x-wav', TMimeTypes.TKind.Binary); // do not localize
  AddType('xm', 'audio/xm', TMimeTypes.TKind.Binary); // do not localize
  AddType('cdx', 'chemical/x-cdx'); // do not localize
  AddType('cif', 'chemical/x-cif'); // do not localize
  AddType('cmdf', 'chemical/x-cmdf'); // do not localize
  AddType('cml', 'chemical/x-cml'); // do not localize
  AddType('csml', 'chemical/x-csml'); // do not localize
  AddType('xyz', 'chemical/x-xyz'); // do not localize
  AddType('bmp', 'image/bmp', TMimeTypes.TKind.Binary); // do not localize
  AddType('cgm', 'image/cgm', TMimeTypes.TKind.Binary); // do not localize
  AddType('g3', 'image/g3fax', TMimeTypes.TKind.Binary); // do not localize
  AddType('gif', 'image/gif', TMimeTypes.TKind.Binary); // do not localize
  AddType('ief', 'image/ief', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpeg', 'image/jpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpg', 'image/jpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpe', 'image/jpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('ktx', 'image/ktx', TMimeTypes.TKind.Binary); // do not localize
  AddType('png', 'image/png', TMimeTypes.TKind.Binary); // do not localize
  AddType('btif', 'image/prs.btif', TMimeTypes.TKind.Binary); // do not localize
  AddType('sgi', 'image/sgi', TMimeTypes.TKind.Binary); // do not localize
  AddType('svg', 'image/svg+xml', TMimeTypes.TKind.Binary); // do not localize
  AddType('svgz', 'image/svg+xml', TMimeTypes.TKind.Binary); // do not localize
  AddType('tiff', 'image/tiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('tif', 'image/tiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('psd', 'image/vnd.adobe.photoshop', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvi', 'image/vnd.dece.graphic', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvi', 'image/vnd.dece.graphic', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvg', 'image/vnd.dece.graphic', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvg', 'image/vnd.dece.graphic', TMimeTypes.TKind.Binary); // do not localize
  AddType('sub', 'image/vnd.dvb.subtitle', TMimeTypes.TKind.Binary); // do not localize
  AddType('djvu', 'image/vnd.djvu', TMimeTypes.TKind.Binary); // do not localize
  AddType('djv', 'image/vnd.djvu', TMimeTypes.TKind.Binary); // do not localize
  AddType('dwg', 'image/vnd.dwg', TMimeTypes.TKind.Binary); // do not localize
  AddType('dxf', 'image/vnd.dxf', TMimeTypes.TKind.Binary); // do not localize
  AddType('fbs', 'image/vnd.fastbidsheet', TMimeTypes.TKind.Binary); // do not localize
  AddType('fpx', 'image/vnd.fpx', TMimeTypes.TKind.Binary); // do not localize
  AddType('fst', 'image/vnd.fst', TMimeTypes.TKind.Binary); // do not localize
  AddType('mmr', 'image/vnd.fujixerox.edmics-mmr', TMimeTypes.TKind.Binary); // do not localize
  AddType('rlc', 'image/vnd.fujixerox.edmics-rlc', TMimeTypes.TKind.Binary); // do not localize
  AddType('mdi', 'image/vnd.ms-modi', TMimeTypes.TKind.Binary); // do not localize
  AddType('wdp', 'image/vnd.ms-photo', TMimeTypes.TKind.Binary); // do not localize
  AddType('npx', 'image/vnd.net-fpx', TMimeTypes.TKind.Binary); // do not localize
  AddType('wbmp', 'image/vnd.wap.wbmp', TMimeTypes.TKind.Binary); // do not localize
  AddType('xif', 'image/vnd.xiff', TMimeTypes.TKind.Binary); // do not localize
  AddType('webp', 'image/webp', TMimeTypes.TKind.Binary); // do not localize
  AddType('3ds', 'image/x-3ds', TMimeTypes.TKind.Binary); // do not localize
  AddType('ras', 'image/x-cmu-raster', TMimeTypes.TKind.Binary); // do not localize
  AddType('cmx', 'image/x-cmx', TMimeTypes.TKind.Binary); // do not localize
  AddType('fh', 'image/x-freehand', TMimeTypes.TKind.Binary); // do not localize
  AddType('fhc', 'image/x-freehand', TMimeTypes.TKind.Binary); // do not localize
  AddType('fh4', 'image/x-freehand', TMimeTypes.TKind.Binary); // do not localize
  AddType('fh5', 'image/x-freehand', TMimeTypes.TKind.Binary); // do not localize
  AddType('fh7', 'image/x-freehand', TMimeTypes.TKind.Binary); // do not localize
  AddType('ico', 'image/x-icon', TMimeTypes.TKind.Binary); // do not localize
  AddType('sid', 'image/x-mrsid-image', TMimeTypes.TKind.Binary); // do not localize
  AddType('pcx', 'image/x-pcx', TMimeTypes.TKind.Binary); // do not localize
  AddType('pic', 'image/x-pict', TMimeTypes.TKind.Binary); // do not localize
  AddType('pct', 'image/x-pict', TMimeTypes.TKind.Binary); // do not localize
  AddType('pnm', 'image/x-portable-anymap', TMimeTypes.TKind.Binary); // do not localize
  AddType('pbm', 'image/x-portable-bitmap', TMimeTypes.TKind.Binary); // do not localize
  AddType('pgm', 'image/x-portable-graymap', TMimeTypes.TKind.Binary); // do not localize
  AddType('ppm', 'image/x-portable-pixmap', TMimeTypes.TKind.Binary); // do not localize
  AddType('rgb', 'image/x-rgb', TMimeTypes.TKind.Binary); // do not localize
  AddType('tga', 'image/x-tga', TMimeTypes.TKind.Binary); // do not localize
  AddType('xbm', 'image/x-xbitmap', TMimeTypes.TKind.Binary); // do not localize
  AddType('xpm', 'image/x-xpixmap', TMimeTypes.TKind.Binary); // do not localize
  AddType('xwd', 'image/x-xwindowdump', TMimeTypes.TKind.Binary); // do not localize
  AddType('eml', 'message/rfc822'); // do not localize
  AddType('mime', 'message/rfc822'); // do not localize
  AddType('igs', 'model/iges'); // do not localize
  AddType('iges', 'model/iges'); // do not localize
  AddType('msh', 'model/mesh'); // do not localize
  AddType('mesh', 'model/mesh'); // do not localize
  AddType('silo', 'model/mesh'); // do not localize
  AddType('dae', 'model/vnd.collada+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dwf', 'model/vnd.dwf'); // do not localize
  AddType('gdl', 'model/vnd.gdl'); // do not localize
  AddType('gtw', 'model/vnd.gtw'); // do not localize
  AddType('mts', 'model/vnd.mts'); // do not localize
  AddType('vtu', 'model/vnd.vtu'); // do not localize
  AddType('wrl', 'model/vrml'); // do not localize
  AddType('vrml', 'model/vrml'); // do not localize
  AddType('x3db', 'model/x3d+binary'); // do not localize
  AddType('x3dbz', 'model/x3d+binary'); // do not localize
  AddType('x3dv', 'model/x3d+vrml'); // do not localize
  AddType('x3dvz', 'model/x3d+vrml'); // do not localize
  AddType('x3d', 'model/x3d+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('x3dz', 'model/x3d+xml', TMimeTypes.TKind.Text); // do not localize
  AddType('appcache', 'text/cache-manifest', TMimeTypes.TKind.Text); // do not localize
  AddType('manifest', 'text/cache-manifest', TMimeTypes.TKind.Text); // do not localize
  AddType('ics', 'text/calendar', TMimeTypes.TKind.Text); // do not localize
  AddType('ifb', 'text/calendar', TMimeTypes.TKind.Text); // do not localize
  AddType('cmd', 'text/cmd', TMimeTypes.TKind.Text); // do not localize
  AddType('css', 'text/css', TMimeTypes.TKind.Text); // do not localize
  AddType('csv', 'text/csv', TMimeTypes.TKind.Text); // do not localize
  AddType('html', 'text/html', TMimeTypes.TKind.Text); // do not localize
  AddType('htm', 'text/html', TMimeTypes.TKind.Text); // do not localize
  AddType('n3', 'text/n3', TMimeTypes.TKind.Text); // do not localize
  AddType('txt', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('text', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('conf', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('def', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('list', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('log', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('in', 'text/plain', TMimeTypes.TKind.Text); // do not localize
  AddType('dsc', 'text/prs.lines.tag', TMimeTypes.TKind.Text); // do not localize
  AddType('rtx', 'text/richtext', TMimeTypes.TKind.Text); // do not localize
  AddType('sgml', 'text/sgml', TMimeTypes.TKind.Text); // do not localize
  AddType('sgm', 'text/sgml', TMimeTypes.TKind.Text); // do not localize
  AddType('tsv', 'text/tab-separated-values', TMimeTypes.TKind.Text); // do not localize
  AddType('t', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('tr', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('roff', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('man', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('me', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('ms', 'text/troff', TMimeTypes.TKind.Text); // do not localize
  AddType('ttl', 'text/turtle', TMimeTypes.TKind.Text); // do not localize
  AddType('uri', 'text/uri-list', TMimeTypes.TKind.Text); // do not localize
  AddType('uris', 'text/uri-list', TMimeTypes.TKind.Text); // do not localize
  AddType('urls', 'text/uri-list', TMimeTypes.TKind.Text); // do not localize
  AddType('vcard', 'text/vcard', TMimeTypes.TKind.Text); // do not localize
  AddType('curl', 'text/vnd.curl', TMimeTypes.TKind.Text); // do not localize
  AddType('dcurl', 'text/vnd.curl.dcurl', TMimeTypes.TKind.Text); // do not localize
  AddType('scurl', 'text/vnd.curl.scurl', TMimeTypes.TKind.Text); // do not localize
  AddType('mcurl', 'text/vnd.curl.mcurl', TMimeTypes.TKind.Text); // do not localize
  AddType('sub', 'text/vnd.dvb.subtitle', TMimeTypes.TKind.Text); // do not localize
  AddType('fly', 'text/vnd.fly', TMimeTypes.TKind.Text); // do not localize
  AddType('flx', 'text/vnd.fmi.flexstor', TMimeTypes.TKind.Text); // do not localize
  AddType('gv', 'text/vnd.graphviz', TMimeTypes.TKind.Text); // do not localize
  AddType('3dml', 'text/vnd.in3d.3dml', TMimeTypes.TKind.Text); // do not localize
  AddType('spot', 'text/vnd.in3d.spot', TMimeTypes.TKind.Text); // do not localize
  AddType('jad', 'text/vnd.sun.j2me.app-descriptor', TMimeTypes.TKind.Text); // do not localize
  AddType('wml', 'text/vnd.wap.wml', TMimeTypes.TKind.Text); // do not localize
  AddType('wmls', 'text/vnd.wap.wmlscript', TMimeTypes.TKind.Text); // do not localize
  AddType('s', 'text/x-asm', TMimeTypes.TKind.Text); // do not localize
  AddType('asm', 'text/x-asm', TMimeTypes.TKind.Text); // do not localize
  AddType('c', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('cc', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('cxx', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('cpp', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('h', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('hh', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('dic', 'text/x-c', TMimeTypes.TKind.Text); // do not localize
  AddType('f', 'text/x-fortran', TMimeTypes.TKind.Text); // do not localize
  AddType('for', 'text/x-fortran', TMimeTypes.TKind.Text); // do not localize
  AddType('f77', 'text/x-fortran', TMimeTypes.TKind.Text); // do not localize
  AddType('f90', 'text/x-fortran', TMimeTypes.TKind.Text); // do not localize
  AddType('java', 'text/x-java-source', TMimeTypes.TKind.Text); // do not localize
  AddType('opml', 'text/x-opml', TMimeTypes.TKind.Text); // do not localize
  AddType('p', 'text/x-pascal', TMimeTypes.TKind.Text); // do not localize
  AddType('pas', 'text/x-pascal', TMimeTypes.TKind.Text); // do not localize
  AddType('nfo', 'text/x-nfo', TMimeTypes.TKind.Text); // do not localize
  AddType('etx', 'text/x-setext', TMimeTypes.TKind.Text); // do not localize
  AddType('sfv', 'text/x-sfv', TMimeTypes.TKind.Text); // do not localize
  AddType('uu', 'text/x-uuencode', TMimeTypes.TKind.Text); // do not localize
  AddType('vcs', 'text/x-vcalendar', TMimeTypes.TKind.Text); // do not localize
  AddType('vcf', 'text/x-vcard', TMimeTypes.TKind.Text); // do not localize
  AddType('vcf', 'text/x-yaml', TMimeTypes.TKind.Text); // do not localize
  AddType('xml', 'text/xml', TMimeTypes.TKind.Text); // do not localize
  AddType('xsl', 'text/xml', TMimeTypes.TKind.Text); // do not localize
  AddType('dtd', 'text/xml-dtd', TMimeTypes.TKind.Text); // do not localize
  AddType('yaml', 'text/yaml', TMimeTypes.TKind.Text); // do not localize
  AddType('3gp', 'video/3gpp', TMimeTypes.TKind.Binary); // do not localize
  AddType('3g2', 'video/3gpp2', TMimeTypes.TKind.Binary); // do not localize
  AddType('h261', 'video/h261', TMimeTypes.TKind.Binary); // do not localize
  AddType('h263', 'video/h263', TMimeTypes.TKind.Binary); // do not localize
  AddType('h264', 'video/h264', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpgv', 'video/jpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpm', 'video/jpm', TMimeTypes.TKind.Binary); // do not localize
  AddType('jpgm', 'video/jpm', TMimeTypes.TKind.Binary); // do not localize
  AddType('mj2', 'video/mj2', TMimeTypes.TKind.Binary); // do not localize
  AddType('mjp2', 'video/mj2', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp4', 'video/mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('mp4v', 'video/mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('mpg4', 'video/mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('mpeg', 'video/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('mpg', 'video/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('mpe', 'video/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('m1v', 'video/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('m2v', 'video/mpeg', TMimeTypes.TKind.Binary); // do not localize
  AddType('ogv', 'video/ogg', TMimeTypes.TKind.Binary); // do not localize
  AddType('qt', 'video/quicktime', TMimeTypes.TKind.Binary); // do not localize
  AddType('mov', 'video/quicktime', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvh', 'video/vnd.dece.hd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvh', 'video/vnd.dece.hd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvm', 'video/vnd.dece.mobile', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvm', 'video/vnd.dece.mobile', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvp', 'video/vnd.dece.pd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvp', 'video/vnd.dece.pd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvs', 'video/vnd.dece.sd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvs', 'video/vnd.dece.sd', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvv', 'video/vnd.dece.video', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvv', 'video/vnd.dece.video', TMimeTypes.TKind.Binary); // do not localize
  AddType('dvb', 'video/vnd.dvb.file', TMimeTypes.TKind.Binary); // do not localize
  AddType('fvt', 'video/vnd.fvt', TMimeTypes.TKind.Binary); // do not localize
  AddType('mxu', 'video/vnd.mpegurl', TMimeTypes.TKind.Binary); // do not localize
  AddType('m4u', 'video/vnd.mpegurl', TMimeTypes.TKind.Binary); // do not localize
  AddType('pyv', 'video/vnd.ms-playready.media.pyv', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvu', 'video/vnd.uvvu.mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('uvvu', 'video/vnd.uvvu.mp4', TMimeTypes.TKind.Binary); // do not localize
  AddType('viv', 'video/vnd.vivo', TMimeTypes.TKind.Binary); // do not localize
  AddType('webm', 'video/webm', TMimeTypes.TKind.Binary); // do not localize
  AddType('f4v', 'video/x-f4v', TMimeTypes.TKind.Binary); // do not localize
  AddType('fli', 'video/x-fli', TMimeTypes.TKind.Binary); // do not localize
  AddType('flv', 'video/x-flv', TMimeTypes.TKind.Binary); // do not localize
  AddType('m4v', 'video/x-m4v', TMimeTypes.TKind.Binary); // do not localize
  AddType('mkv', 'video/x-matroska', TMimeTypes.TKind.Binary); // do not localize
  AddType('mk3d', 'video/x-matroska', TMimeTypes.TKind.Binary); // do not localize
  AddType('mks', 'video/x-matroska', TMimeTypes.TKind.Binary); // do not localize
  AddType('mng', 'video/x-mng', TMimeTypes.TKind.Binary); // do not localize
  AddType('asf', 'video/x-ms-asf', TMimeTypes.TKind.Binary); // do not localize
  AddType('asx', 'video/x-ms-asf', TMimeTypes.TKind.Binary); // do not localize
  AddType('vob', 'video/x-ms-vob', TMimeTypes.TKind.Binary); // do not localize
  AddType('wm', 'video/x-ms-wm', TMimeTypes.TKind.Binary); // do not localize
  AddType('wmv', 'video/x-ms-wmv', TMimeTypes.TKind.Binary); // do not localize
  AddType('wmx', 'video/x-ms-wmx', TMimeTypes.TKind.Binary); // do not localize
  AddType('wvx', 'video/x-ms-wvx', TMimeTypes.TKind.Binary); // do not localize
  AddType('avi', 'video/x-msvideo', TMimeTypes.TKind.Binary); // do not localize
  AddType('movie', 'video/x-sgi-movie', TMimeTypes.TKind.Binary); // do not localize
  AddType('smv', 'video/x-smv', TMimeTypes.TKind.Binary); // do not localize
  AddType('ice', 'x-conference/x-cooltalk');  // do not localize
{$ENDREGION}
end;

procedure TMimeTypes.AddOSTypes;

{$IF DEFINED(MSWINDOWS)}
  procedure LoadRegistry;
  const
    CExtsKey = '\';
    CTypesKey = '\MIME\Database\Content Type\'; // do not localize
  var
    LReg: TRegistry;
    LKeys: TStringList;
    LExt, LType: string;
  begin
    LReg := TRegistry.Create;
    try
      LKeys := TStringList.Create;
      try
        LReg.RootKey := HKEY_CLASSES_ROOT;
        if LReg.OpenKeyReadOnly(CExtsKey) then
        begin
          LReg.GetKeyNames(LKeys);
          LReg.CloseKey;
          for LExt in LKeys do
            if LExt.StartsWith('.') then
              if LReg.OpenKeyReadOnly(CExtsKey + LExt) then
              begin
                LType := LReg.ReadString('Content Type'); // do not localize
                if LType <> '' then
                  AddType(LExt, LType, TKind.Undefined, True);
                LReg.CloseKey;
              end;
        end;

        if LReg.OpenKeyReadOnly(CTypesKey) then
        begin
          LReg.GetKeyNames(LKeys);
          LReg.CloseKey;
          for LType in LKeys do
            if LReg.OpenKeyReadOnly(CTypesKey + LType) then
            begin
              LExt := LReg.ReadString('Extension'); // do not localize
              if LExt <> '' then
                AddType(LExt, LType, TKind.Undefined, True);
              LReg.CloseKey;
            end;
        end;
      finally
        LKeys.Free;
      end;
    finally
      LReg.Free;
    end;
  end;
{$ENDIF}

{$IF DEFINED(LINUX)}
  procedure LoadFile(const AFileName: string);
  var
    LTypes: TStringList;
    LItem: string;
    LArr: TArray<string>;
    i, j: Integer;
  begin
    if not FileExists(AFileName) then
      Exit;
    LTypes := TStringList.Create;
    try
      try
        LTypes.LoadFromFile(AFileName);
      except
        // if file is not accessible (eg, no rights), then just exit
        Exit;
      end;
      for j := 0 to LTypes.Count - 1 do
      begin
        LItem := LTypes[j].Trim;
        if (LItem <> '') and not LItem.StartsWith('#') then
        begin
          LArr := LItem.Split([' ', #9], TStringSplitOptions.ExcludeEmpty);
          for i := 1 to Length(LArr) - 1 do
            AddType(LArr[i], LArr[0], TKind.Undefined, True);
        end;
      end;
    finally
      LTypes.Free;
    end;
  end;
{$ENDIF}

{$IF DEFINED(MACOS) and not DEFINED(IOS)}
  procedure LoadFile(const AFileName: string);
  const
    CBinary: RawByteString = 'bplist';
  var
    LItems, LExts: TStringList;
    i: Integer;
    LArr: TArray<string>;
    LType: string;
    LMode: Integer;
    j: Integer;
    LFile: TFileStream;
    LHeader: RawByteString;
  begin
    if not FileExists(AFileName) then
      Exit;

    LItems := TStringList.Create;
    try
      LExts := TStringList.Create;
      try
        try
          LFile := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
          try
            SetLength(LHeader, Length(CBinary));
            // ignore binary plist
            if (LFile.Read(LHeader[1], Length(CBinary)) = Length(CBinary)) and
               (LHeader = CBinary) then
              Exit;
            LFile.Position := 0;
            LItems.LoadFromStream(LFile);
          finally
            LFile.Free;
          end;
        except
          // if file is not accessible (eg, no rights), then just exit
          Exit;
        end;

        LMode := -1;
        for i := 0 to LItems.Count - 1 do
        begin
          LArr := LItems[i].Split(['<', '>', #9, ' '], TStringSplitOptions.ExcludeEmpty);
          if Length(LArr) = 3 then
          begin
            if SameText(LArr[0], 'key') and SameText(LArr[1], 'CFBundleTypeExtensions') then // do not localize
              LMode := 0
            else if SameText(LArr[0], 'key') and SameText(LArr[1], 'CFBundleTypeMIMETypes') then // do not localize
              LMode := 1
            else if SameText(LArr[0], 'key') then // do not localize
              LMode := 2
            else if SameText(LArr[0], 'string') then // do not localize
            begin
              if LMode = 0 then
                LExts.Add(LArr[1])
              else if LMode = 1 then
                LType := LArr[1];
            end
          end
          else if (Length(LArr) = 1) and SameText(LArr[0], '/dict') and (LMode >= 0) then // do not localize
          begin
            if LType <> '' then
              for j := 0 to LExts.Count - 1 do
                AddType(LExts[j], LType, TKind.Undefined, True);
            LMode := -1;
            LExts.Clear;
            LType := '';
          end
        end;
      finally
        LExts.Free;
      end;
    finally
      LItems.Free;
    end;
  end;
{$ENDIF}

{$IF DEFINED(LINUX)}
const
  CTypeFile = 'mime.types'; // do not localize
{$ENDIF}
{$IF DEFINED(MACOS) and not DEFINED(IOS)}
const
  CTypeFile = '/Applications/Safari.app/Contents/Info.plist'; // do not localize
{$ENDIF}
begin
{$IF DEFINED(MSWINDOWS)}
  LoadRegistry;
{$ENDIF}
{$IF DEFINED(LINUX)}
  LoadFile(TPath.Combine(TPath.GetHomePath, '.' + CTypeFile));
  LoadFile('/etc/' + CTypeFile); // do not localize
{$ENDIF}
{$IF DEFINED(MACOS) and not DEFINED(IOS)}
  LoadFile(CTypeFile);
{$ENDIF}
end;

procedure TMimeTypes.Clear;
begin
  FTypeDict.Clear;
  FExtDict.Clear;
  FInfos.Clear;
end;

function TMimeTypes.NormalizeExt(const AExt: string): string;
begin
  Result := AExt.Trim.ToLower;
  if (Result <> '') and (Result[Low(Result)] = '.') then
    Result := Result.Substring(1);
end;

function TMimeTypes.GetFileInfo(const AFileName: string; out AType: string;
  out AKind: TKind): Boolean;
begin
  Result := GetExtInfo(ExtractFileExt(AFileName), AType, AKind);
end;

function TMimeTypes.GetExtInfo(const AExt: string; out AType: string;
  out AKind: TKind): Boolean;
var
  LExt: string;
  LInfo: TInfo;
begin
  LExt := NormalizeExt(AExt);
  Result := FExtDict.TryGetValue(LExt, LInfo);
  if Result then
  begin
    AType := LInfo.FType;
    AKind := LInfo.FKind;
  end
  else
  begin
    GetExtInfo('bin', AType, AKind); // do not localize
    AKind := TMimeTypes.TKind.Undefined;
  end;
end;

function TMimeTypes.GetTypeInfo(const AType: string; out AExt: string;
  out AKind: TKind): Boolean;
var
  LInfo: TInfo;
  LType: string;
begin
  LType := AType.Trim.ToLower;
  Result := FTypeDict.TryGetValue(AType, LInfo);
  if Result then
  begin
    AExt := LInfo.FExt;
    AKind := LInfo.FKind;
  end
  else
  begin
    GetExtInfo('bin', LType, AKind); // do not localize
    AKind := TMimeTypes.TKind.Undefined;
  end;
end;

procedure TMimeTypes.AddType(const AExt, AType: string; AKind: TKind; AIgnoreDups: Boolean);
var
  LInfo, LTmp1, LTmp2: TInfo;
  LType, LKey: string;
begin
  LType := AType.Trim.ToLower;
  if LType = '' then
    raise EArgumentOutOfRangeException.Create('Mime type cannot be empty');

  LInfo := TInfo.Create;
  LInfo.FExt := NormalizeExt(AExt);
  LInfo.FType := LType;
  LInfo.FKind := AKind;

  LKey := LInfo.FExt + '=' + LInfo.FType;
  if FInfos.ContainsKey(LKey) then
  begin
    LInfo.Free;
    if AIgnoreDups then
      Exit;
    raise EListError.Create('Pair of extension and mime type already exists');
  end;
  FInfos.Add(LKey, LInfo);

  LTmp1 := nil;
  LTmp2 := nil;
  if (LInfo.FExt <> '') and not FExtDict.TryGetValue(LInfo.FExt, LTmp1) then
    FExtDict.Add(LInfo.FExt, LInfo);
  if (LInfo.FType <> '') and not FTypeDict.TryGetValue(LInfo.FType, LTmp2) then
    FTypeDict.Add(LInfo.FType, LInfo);
  if LInfo.FKind = TKind.Undefined then
    if (LTmp1 <> nil) and (LTmp1.FKind <> TKind.Undefined) then
      LInfo.FKind := LTmp1.FKind
    else if (LTmp2 <> nil) and (LTmp2.FKind <> TKind.Undefined) then
      LInfo.FKind := LTmp2.FKind;
end;

procedure TMimeTypes.ForAll(const AExtMask, ATypeMask: string; AFunc: TIterateFunc);
var
  S: string;
  LExtMask: TMask;
  LTypeMask: TMask;
  LInfo: TInfo;
begin
  LExtMask := nil;
  LTypeMask := nil;
  try
    S := NormalizeExt(AExtMask);
    if S <> '' then
      LExtMask := TMask.Create(S);
    S := ATypeMask.Trim.ToLower;
    if S <> '' then
      LTypeMask := TMask.Create(S);
    for LInfo in FInfos.Values do
      if ((LExtMask = nil) or LExtMask.Matches(LInfo.FExt)) and
         ((LTypeMask = nil) or LTypeMask.Matches(LInfo.FType)) then
        if AFunc(LInfo.FExt, LInfo.FType, LInfo.FKind) then
          Break;
  finally
    LTypeMask.Free;
    LExtMask.Free;
  end;
end;

procedure TMimeTypes.ForExts(const AExtMask: string; AFunc: TIterateFunc);
begin
  ForAll(AExtMask, '', AFunc);
end;

procedure TMimeTypes.ForTypes(const ATypeMask: string; AFunc: TIterateFunc);
begin
  ForAll('', ATypeMask, AFunc);
end;

{ TAcceptValueItem }

destructor TAcceptValueItem.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

function TAcceptValueItem.GetParams: TStrings;
begin
  if FParams = nil then
    FParams := TStringList.Create;
  Result := FParams;
end;

procedure TAcceptValueItem.Parse;
begin
  // nothing
end;

{ TAcceptValueListBase }

constructor TAcceptValueListBase<T>.Create;
begin
  inherited Create;
  FInvariant.DecimalSeparator := '.';
  FItems := TObjectList<T>.Create(TDelegatedComparer<T>.Create(
    function (const Left, Right: T): Integer
    begin
      Result := - CompareWeights(Left.FWeight, Right.FWeight);
      if Result = 0 then
        if Left.FOrder < Right.FOrder then
          Result := -1
        else if Left.FOrder > Right.FOrder then
          Result := 1;
    end), True);
end;

constructor TAcceptValueListBase<T>.Create(const AValue: string);
begin
  Create;
  Parse(AValue);
end;

destructor TAcceptValueListBase<T>.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

class function TAcceptValueListBase<T>.CompareWeights(AWeight1,
  AWeight2: Double): Integer;
begin
  if Abs(AWeight1 - AWeight2) <= 0.001 then
    Result := 0
  else if AWeight1 < AWeight2 then
    Result := -1
  else if AWeight1 > AWeight2 then
    Result := 1;
end;

function TAcceptValueListBase<T>.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TAcceptValueListBase<T>.GetNames(AIndex: Integer): string;
begin
  Result := FItems[AIndex].Name;
end;

function TAcceptValueListBase<T>.GetWeights(AIndex: Integer): Double;
begin
  Result := FItems[AIndex].Weight;
end;

function TAcceptValueListBase<T>.GetItems(AIndex: Integer): T;
begin
  Result := FItems[AIndex];
end;

function TAcceptValueListBase<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := FItems.GetEnumerator;
end;

procedure TAcceptValueListBase<T>.BeginUpdate;
begin
  Inc(FUpdates);
end;

procedure TAcceptValueListBase<T>.EndUpdate;
begin
  if FUpdates > 0 then
  begin
    Dec(FUpdates);
    if FUpdates = 0 then
      FItems.Sort;
  end;
end;

procedure TAcceptValueListBase<T>.Clear;
begin
  BeginUpdate;
  try
    FItems.Clear;
  finally
    EndUpdate;
  end;
end;

procedure TAcceptValueListBase<T>.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
end;

procedure TAcceptValueListBase<T>.Add(const AName: string; AWeight: Double;
  AExtra: TStrings);
var
  LItem: T;
  LName, LType: string;
  LIndex: Integer;
  LKind: TMimeTypes.TKind;
begin
  LName := AName.Trim.ToLower;
  if LName = '' then
    raise EArgumentOutOfRangeException.Create('Value name cannot be empty');
  if (AWeight < 0) or (AWeight > 1) then
    raise EArgumentOutOfRangeException.Create('Quality weight is out of range');

  if TMimeTypes.Default.GetExtInfo(LName, LType, LKind) then
    LName := LType;

  BeginUpdate;
  try
    for LItem in FItems do
      if LItem.Name = LName then
      begin
        if LItem.Weight <> 0 then
          if AWeight = 0 then
            LItem.FWeight := 0
          else if AWeight > LItem.Weight then
            LItem.FWeight := AWeight;
        Exit;
      end;

    LItem := T.Create;
    try
      LItem.FName := LName;
      LItem.FWeight := AWeight;
      LItem.FOrder := FItems.Count;
      if (AExtra <> nil) and (AExtra.Count > 0) then
        LItem.Params.AddStrings(AExtra);
      LItem.Parse;
    except
      LItem.Free;
      raise;
    end;
    FItems.Add(LItem);
  finally
    EndUpdate;
  end;
end;

procedure TAcceptValueListBase<T>.Assign(const AAcceptList: TAcceptValueListBase<T>);
var
  LItem: T;
begin
  BeginUpdate;
  try
    Clear;
    for LItem in AAcceptList do
      Add(LItem.Name, LItem.Weight, LItem.FParams);
  finally
    EndUpdate;
  end;
end;

procedure TAcceptValueListBase<T>.Parse(const AValue: string);
var
  i, j: Integer;
  LItem, LParam, LName, LValue: string;
  LWeight: Double;
  LItems, LParams: TArray<string>;
  LExtra: TStringList;
begin
  BeginUpdate;
  LExtra := TStringList.Create;
  try
    Clear;
    LItems := AValue.Split([','], TStringSplitOptions.ExcludeEmpty);
    for LItem in LItems do
    begin
      LParams := LItem.Split([';'], TStringSplitOptions.ExcludeEmpty);
      if (Length(LParams) > 0) and (LParams[0].Trim <> '') then
      begin
        LWeight := 1;
        LExtra.Clear;
        for i := 1 to Length(LParams) - 1 do
        begin
          LParam := LParams[i];
          j := LParam.IndexOf('=');
          if j < 0 then
            j := LParam.Length;
          LName := LParam.Substring(0, j).Trim.ToLower;
          LValue := LParam.Substring(j + 1, MaxInt).Trim.ToLower;
          if LName = 'q' then
            LWeight := StrToFloatDef(LValue, 0, FInvariant)
          else if LValue <> '' then
            LExtra.AddPair(LName, LValue)
          else
            LExtra.Add(LName);
        end;
        Add(LParams[0], LWeight, LExtra);
      end;
    end;
  finally
    LExtra.Free;
    EndUpdate;
  end;
end;

function TAcceptValueListBase<T>.ToString: string;
var
  LItem: T;
  LParam: string;
begin
                                                                      
  for LItem in Self do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + LItem.Name;
    if LItem.Weight <> 1 then
      Result := Result + ';q=' +  // do not localize
        FloatToStrF(LItem.Weight, ffGeneral, 3, 3, FInvariant);
    if LItem.FParams <> nil then
      for LParam in LItem.Params do
        Result := Result + ';' + LParam;
  end;
end;

function TAcceptValueListBase<T>.InternalNegotiate(AAcceptList: TAcceptValueListBase<T>;
  AAcceptFunc: TAcceptFunc; var AMode: TMatchMode; out AWeight: Double): string;
var
  i, j: Integer;
  LMask1: TMask;
  LName1, LName2: string;
  LNewWeight: Double;
  LIgnoreLiterals: Boolean;
begin
  Result := '';
  AWeight := 0;
  LIgnoreLiterals := (AMode = TMatchMode.Reverse);

  for i := 0 to Count - 1 do
  begin
    if Weights[i] = 0 then
      Continue;

    LName1 := Names[i];
    if (AAcceptList = nil) or (AAcceptList.Count = 0) then
    begin
      if (not Assigned(AAcceptFunc) or AAcceptFunc(LName1, Weights[i], Items[i])) then
      begin
        AWeight := Weights[i];
        Exit(LName1);
      end;
      Continue;
    end;

    LMask1 := nil;
    try
      for j := 0 to AAcceptList.Count - 1 do
      begin
        LNewWeight := Weights[i] * AAcceptList.Weights[j];
        if LNewWeight < AWeight then
          Break;

        if j = 0 then
          if LName1.Contains('*') then
            LMask1 := TMask.Create(LName1)
          else if (AMode <> TMatchMode.Intersect) and LIgnoreLiterals then
            Break;

        LName2 := AAcceptList.Names[j];
        if LName2.Contains('*') and (AMode <> TMatchMode.Intersect) and not LIgnoreLiterals then
        begin
          AMode := TMatchMode.Reverse;
          Continue;
        end;

        if (LNewWeight <> 0) and
           ((LMask1 <> nil) and LMask1.Matches(LName2) or
            (LMask1 = nil) and (LName1 = LName2)) and
           (not Assigned(AAcceptFunc) or AAcceptFunc(LName2, LNewWeight, AAcceptList.Items[j])) then
          if AWeight < LNewWeight then
          begin
            Result := LName2;
            AWeight := LNewWeight;
          end;
      end;
    finally
      LMask1.Free;
    end;
  end;
end;

function TAcceptValueListBase<T>.Negotiate(const AAcceptList: TAcceptValueListBase<T>;
  out AWeight: Double; AAcceptFunc: TAcceptFunc): string;
var
  LItem: string;
  LWeight: Double;
  LMode: TMatchMode;
begin
  if Count > 0 then
  begin
    LMode := TMatchMode.Forward;
    Result := InternalNegotiate(AAcceptList, AAcceptFunc, LMode, AWeight);
  end
  else
    LMode := TMatchMode.Reverse;
  if LMode = TMatchMode.Reverse then
  begin
    LItem := AAcceptList.InternalNegotiate(Self, AAcceptFunc, LMode, LWeight);
    if LWeight > AWeight then
    begin
      Result := LItem;
      AWeight := LWeight;
    end;
  end;
end;

function TAcceptValueListBase<T>.Negotiate(const AAcceptList: string;
  out AWeight: Double; AAcceptFunc: TAcceptFunc): string;
var
  LList: TAcceptValueListBase<T>;
begin
  LList := TAcceptValueListBase<T>.Create(AAcceptList);
  try
    Result := Negotiate(LList, AWeight, AAcceptFunc);
  finally
    LList.Free;
  end;
end;

procedure TAcceptValueListBase<T>.Intersect(const AAcceptList: TAcceptValueListBase<T>);
var
  LList: TAcceptValueListBase<T>;
  LWeight: Double;
  LFunc: TAcceptFunc;
  LMode: TMatchMode;
begin
  LList := TAcceptValueListBase<T>.Create;
  try
    LList.BeginUpdate;
    try
      LFunc :=
        function (const AName: string; AWeight: Double; AItem: T): Boolean
        begin
          LList.Add(AName, AWeight, AItem.FParams);
          Result := False;
        end;
      LMode := TMatchMode.Intersect;
      InternalNegotiate(AAcceptList, LFunc, LMode, LWeight);
      AAcceptList.InternalNegotiate(Self, LFunc, LMode, LWeight);
    finally
      LList.EndUpdate;
    end;
    FreeAndNil(FItems);
    FItems := LList.FItems;
    LList.FItems := nil;
  finally
    LList.Free;
  end;
end;

{ THeaderValueList }

constructor THeaderValueList.Create;
begin
  inherited Create;
  FItems := TList<TItem>.Create;
end;

constructor THeaderValueList.Create(const AValue: string);
begin
  Create;
  Parse(AValue);
end;

destructor THeaderValueList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

function THeaderValueList.GetNames(AIndex: Integer): string;
begin
  Result := FItems[AIndex].FName;
end;

function THeaderValueList.GetValues(AIndex: Integer): string;
begin
  Result := FItems[AIndex].FValue;
end;

function THeaderValueList.GetValue(const AName: string): string;
var
  i: Integer;
begin
  i := IndexOfName(AName);
  if i >= 0 then
    Result := FItems.List[i].FValue
  else
    Result := '';
end;

function THeaderValueList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function THeaderValueList.IndexOfName(const AName: string): Integer;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if FItems.List[i].FName = AName then
      Exit(i);
  Result := -1;
end;

procedure THeaderValueList.Clear;
begin
  FSubject := '';
  FItems.Clear;
end;

procedure THeaderValueList.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
end;

procedure THeaderValueList.Add(const AItem: TItem);
var
  i: Integer;
begin
  if AItem.FName <> '' then
  begin
    i := IndexOfName(AItem.FName);
    if i >= 0 then
      FItems[i] := AItem
    else
      FItems.Add(AItem);
  end;
end;

procedure THeaderValueList.Add(const AName: string);
var
  LItem: TItem;
begin
  LItem.FName := AName;
  LItem.FValue := '';
  LItem.FFlags := [TFlag.KeyOnly];
  Add(LItem);
end;

procedure THeaderValueList.Add(const AName, AValue: string; AQuoteVal: Boolean);
var
  LItem: TItem;
begin
  LItem.FName := AName;
  LItem.FValue := AValue;
  if AQuoteVal then
    LItem.FFlags := [TFlag.Quoted]
  else
    LItem.FFlags := [];
  Add(LItem);
end;

procedure THeaderValueList.Assign(const AValueList: THeaderValueList);
var
  i: Integer;
begin
  Clear;
  Subject := AValueList.Subject;
  for i := 0 to AValueList.Count - 1 do
    FItems.Add(AValueList.FItems.List[i]);
end;

procedure THeaderValueList.Parse(const AValue: string);
var
  s: string;
  LItems: TArray<string>;
  LItem: string;
  LValue: TItem;
  i: Integer;
begin
  Clear;

  s := AValue.Trim;
  if s.IsEmpty then
    Exit;

  i := s.IndexOfAny(['"', ',', ';', '=', ' ']);
  if i >= 0 then
  begin
    while (i < s.Length) and (s.Chars[i] = ' ') do
      Inc(i);
    if (i < s.Length) and not ((s.Chars[i] = '"') or (s.Chars[i] = ',') or (s.Chars[i] = ';') or (s.Chars[i] = '=')) then
    begin
      Subject := s.Substring(0, i - 1).Trim;
      s := s.Substring(i, MaxInt);
    end;
  end
  else
  begin
    Subject := s;
    Exit;
  end;

  LItems := s.Split([','], '"', '"', TStringSplitOptions.ExcludeEmpty);
  for LItem in LItems do
  begin
    i := LItem.IndexOf('=');
    if i < 0 then
    begin
      LValue.FName := LItem.Trim;
      LValue.FValue := '';
      LValue.FFlags := [TFlag.KeyOnly];
    end
    else
    begin
      LValue.FName := LItem.Substring(0, i).Trim;
      LValue.FValue := LItem.Substring(i + 1).Trim;
      if LValue.FValue.StartsWith('"') and LValue.FValue.EndsWith('"') then
      begin
        LValue.FValue := LValue.FValue.Substring(1, LValue.FValue.Length - 2);
        LValue.FFlags := [TFlag.Quoted];
      end
      else
        LValue.FFlags := [];
    end;
    Add(LValue);
  end;
end;

function THeaderValueList.ToString: string;
var
  i: Integer;
begin
  if Subject <> '' then
    Result := Subject
  else
    Result := '';
  for i := 0 to Count - 1 do
  begin
    if (i = 0) and (Result <> '') then
      Result := Result + ' '
    else if i > 0 then
      Result := Result + ', ';
    Result := Result + FItems.List[i].FName;
    if not (TFlag.KeyOnly in FItems.List[i].FFlags) then
    begin
      Result := Result + '=';
      if TFlag.Quoted in FItems.List[i].FFlags then
        Result := Result + '"' + FItems.List[i].FValue + '"'
      else
        Result := Result + FItems.List[i].FValue;
    end;
  end;
end;

procedure THeaderValueList.Merge(const AValueList: THeaderValueList);
var
  i: Integer;
begin
  if (Subject = '') and (AValueList.Subject <> '') then
    Subject := AValueList.Subject;
  for i := 0 to AValueList.Count - 1 do
    Add(AValueList.FItems.List[i]);
end;

procedure THeaderValueList.Merge(const AValue: string);
var
  LValueList: THeaderValueList;
begin
  LValueList := THeaderValueList.Create(AValue);
  try
    Merge(LValueList);
  finally
    LValueList.Free;
  end;
end;

end.
