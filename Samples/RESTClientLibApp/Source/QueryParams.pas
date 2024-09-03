unit QueryParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmQueryParams = class(TForm)
    QueryParams: TValueListEditor;
    pnlHeader: TPanel;
    lblQueryName: TLabel;
    edtQueryName: TEdit;
    lblQueryValue: TLabel;
    edtQueryValue: TEdit;
    btnAdd: TSpeedButton;
    btnClear: TSpeedButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmQueryParams.btnAddClick(Sender: TObject);
begin
  if ((Trim(edtQueryName.Text) = EmptyStr) or
     (Trim(edtQueryValue.Text) = EmptyStr)) then
    Exit;

  QueryParams.InsertRow(edtQueryName.Text, edtQueryValue.Text, True);
  edtQueryName.Clear;
  edtQueryValue.Clear;
end;

procedure TfrmQueryParams.btnClearClick(Sender: TObject);
begin
  QueryParams.Strings.Clear;
  edtQueryName.Clear;
  edtQueryValue.Clear;
  edtQueryName.SetFocus;
end;

end.
