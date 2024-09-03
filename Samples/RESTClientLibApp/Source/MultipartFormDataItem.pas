unit MultipartFormDataItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls;

type
  TfrmMultipartFormDataItem = class(TFrame)
    bvlMultipartFormDataItem: TBevel;
    lblMultipartFormDataText: TLabel;
    btnDelete: TSpeedButton;
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FscbMultipartFormData: TScrollBox;
    FField: string;
    FText: string;
    FID: string;
    FIsBinary: Boolean;
    procedure SetscbMultipartFormData(const Value: TScrollBox);
    procedure SetField(const Value: string);
    procedure SetText(const Value: string);
    procedure SetIsBinary(const Value: Boolean);
    function GetID: string;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    property ID: string read FID;
    property IsBinary: Boolean read FIsBinary write SetIsBinary;
    property Field: string read FField write SetField;
    property Text: string read FText write SetText;
    property scbMultipartFormData: TScrollBox read FscbMultipartFormData write SetscbMultipartFormData;
  end;

implementation

uses
  IdHashMessageDigest;

{$R *.dfm}

{ TfrmMultipartFormDataItem }

procedure TfrmMultipartFormDataItem.AfterConstruction;
begin
  inherited;
  FID := GetID;
  Sleep(10);
  Self.Name := Format('frmItem%s', [FID]);
end;

procedure TfrmMultipartFormDataItem.btnDeleteClick(Sender: TObject);
var
   I: Integer;
   lfrmMultipartFormDataItem: TfrmMultipartFormDataItem;
begin
  for I := 0 to Pred(scbMultipartFormData.ControlCount) do
  begin
    if not (scbMultipartFormData.Controls[I] is TfrmMultipartFormDataItem) then
      Continue;
    lfrmMultipartFormDataItem := scbMultipartFormData.Controls[I] as TfrmMultipartFormDataItem;
    if (lfrmMultipartFormDataItem.ID = Self.ID) then
    begin
      FreeAndNil(lfrmMultipartFormDataItem);
      Break;
    end;
  end;
end;

function TfrmMultipartFormDataItem.GetID: string;
var
  lIdHashMessageDigest5 : TIdHashMessageDigest5;
begin
  lIdHashMessageDigest5 := TIdHashMessageDigest5.Create;
  try
    Result := lIdHashMessageDigest5.HashStringAsHex(FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', Now()));
  finally
    lIdHashMessageDigest5.Free;
  end;
end;

procedure TfrmMultipartFormDataItem.SetField(const Value: string);
begin
  FField := Value;
  lblMultipartFormDataText.Caption := Format('%s = %s', [FField, FText]);
end;

procedure TfrmMultipartFormDataItem.SetIsBinary(const Value: Boolean);
begin
  FIsBinary := Value;
end;

procedure TfrmMultipartFormDataItem.SetscbMultipartFormData(const Value: TScrollBox);
begin
  FscbMultipartFormData := Value;
end;

procedure TfrmMultipartFormDataItem.SetText(const Value: string);
begin
  FText := Value;
  lblMultipartFormDataText.Caption := Format('%s = %s', [FField, FText]);
end;

end.
