unit PathParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPathParams = class(TForm)
    PathParams: TValueListEditor;
    pnlHeader: TPanel;
    lblParamName: TLabel;
    edtParamName: TEdit;
    lblParamValue: TLabel;
    edtParamValue: TEdit;
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

procedure TfrmPathParams.btnAddClick(Sender: TObject);
begin
  if ((Trim(edtParamName.Text) = EmptyStr) or
     (Trim(edtParamValue.Text) = EmptyStr)) then
    Exit;

  PathParams.InsertRow(edtParamName.Text, edtParamValue.Text, True);
  edtParamName.Clear;
  edtParamValue.Clear;
end;

procedure TfrmPathParams.btnClearClick(Sender: TObject);
begin
  PathParams.Strings.Clear;
  edtParamName.Clear;
  edtParamValue.Clear;
  edtParamName.SetFocus;
end;

end.
