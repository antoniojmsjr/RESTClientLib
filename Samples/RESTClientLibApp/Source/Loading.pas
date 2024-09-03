unit Loading;

interface

uses
  Vcl.Controls, System.Generics.Collections, System.SyncObjs, Vcl.Forms,
  FormWait;

type
  TLoading = class
  strict private
    { private declarations }
    FfrmWait: TfrmWait;
    FMessage: string;
    FParent: TWinControl;
    FID: string;
    FLeft: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetMessage(const Value: string);
    procedure SetParent(const Value: TWinControl);
    function GetID: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    function Start: string;
    property ID: string read FID;
    property Left: Integer read FLeft write SetLeft;
    property Parent: TWinControl read FParent write SetParent;
    property Message: string read FMessage write SetMessage;
  end;

  TControllerLoading = class
  strict private
  class var
    FLock: TCriticalSection;
    FInstance: TControllerLoading;
    class constructor Create;
    class destructor Destroy;
    class function GetDefault: TControllerLoading; static;
  private
    FLoadings: TObjectDictionary<string, TLoading>;
  public
    constructor Create;
    destructor Destroy; override;
    function New: TLoading;
    function Start(const Parent: TWinControl): string;
    procedure Done(const ID: string);
    class property Default: TControllerLoading read GetDefault;
  end;

implementation

uses
  IdHashMessageDigest, System.SysUtils;

{ TLoading }

constructor TLoading.Create;
begin
  FID := GetID;
  FLeft := 200;
  FMessage := 'Working ...';
end;

destructor TLoading.Destroy;
begin
  if Assigned(FfrmWait) then
  begin
    FfrmWait.actIndicator.Animate := False;
    FreeAndNil(FfrmWait);
  end;
  inherited Destroy;
end;

function TLoading.GetID: string;
var
  lIdHashMessageDigest5: TIdHashMessageDigest5;
begin
  lIdHashMessageDigest5 := TIdHashMessageDigest5.Create;
  try
    Result := lIdHashMessageDigest5.HashStringAsHex(DateTimeToStr(Now()));
  finally
    lIdHashMessageDigest5.Free;
  end;
end;

procedure TLoading.SetLeft(const Value: Integer);
begin
  FLeft := Value;
end;

procedure TLoading.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

procedure TLoading.SetParent(const Value: TWinControl);
begin
  FParent := Value;
end;

function TLoading.Start: string;
begin
  if Assigned(FfrmWait) then
    Exit;

  FfrmWait := TfrmWait.Create(Application.MainForm);
  FfrmWait.Name := Format('fm%s', [FID]);
  FfrmWait.Parent := FParent;
  FfrmWait.pnlLeft.Width := FLeft;
  FfrmWait.lblMessage.Caption := FMessage;
  FfrmWait.actIndicator.Animate := True;
  FfrmWait.Show;
  Result := FID;
  Application.ProcessMessages;
end;

{ TControllerLoading }

class constructor TControllerLoading.Create;
begin
  FLock := TCriticalSection.Create;
end;

class destructor TControllerLoading.Destroy;
begin
  FreeAndNil(FInstance);
  FreeAndNil(FLock);
end;

class function TControllerLoading.GetDefault: TControllerLoading;
begin
  if (FInstance = nil) then
  begin
    FLock.Enter;
    try
      if (FInstance = nil) then
        FInstance := TControllerLoading.Create;
    finally
      FLock.Leave;
    end;
  end;
  Result := FInstance;
end;

constructor TControllerLoading.Create;
begin
  FLoadings := TObjectDictionary<string, TLoading>.Create([doOwnsValues], 1024);
end;

destructor TControllerLoading.Destroy;
begin
  FLoadings.Free;
  inherited Destroy;
end;

procedure TControllerLoading.Done(const ID: string);
begin
  if FLoadings.ContainsKey(ID) then
    FLoadings.Remove(ID);
end;

function TControllerLoading.New: TLoading;
begin
  Result := TLoading.Create;
  FLoadings.Add(Result.ID, Result);
end;

function TControllerLoading.Start(const Parent: TWinControl): string;
var
  lLoading: TLoading;
begin
  lLoading := New;
  lLoading.Parent := Parent;
  Result := lLoading.Start;
end;

end.
