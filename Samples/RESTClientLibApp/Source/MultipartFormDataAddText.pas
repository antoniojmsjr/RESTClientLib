unit MultipartFormDataAddText;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TOnAdd = reference to procedure (const pField: string; const pText: string);

  TfrmMultipartFormDataAddText = class(TForm)
    pnlHeader: TPanel;
    lblField: TLabel;
    edtField: TEdit;
    lblText: TLabel;
    btnAdd: TSpeedButton;
    memText: TMemo;
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtFieldKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FOnAdd: TOnAdd;
    procedure SetOnAdd(const Value: TOnAdd);
    procedure DoAdd(const pField: string; const pText: string);
  public
    { Public declarations }
    property OnAdd: TOnAdd read FOnAdd write SetOnAdd;
  end;

implementation

{$R *.dfm}

procedure TfrmMultipartFormDataAddText.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMultipartFormDataAddText.btnAddClick(Sender: TObject);
begin
  if ((Trim(edtField.Text) = EmptyStr) or
     (Trim(memText.Text) = EmptyStr)) then
    Exit;

  DoAdd(edtField.Text, memText.Text);
  Self.Close;
end;

procedure TfrmMultipartFormDataAddText.DoAdd(const pField: string; const pText: string);
begin
  if Assigned(FOnAdd) then
    FOnAdd(pField, pText);
end;

procedure TfrmMultipartFormDataAddText.edtFieldKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = ' ') then
    Key := #0;
end;

procedure TfrmMultipartFormDataAddText.SetOnAdd(const Value: TOnAdd);
begin
  FOnAdd := Value;
end;

end.
