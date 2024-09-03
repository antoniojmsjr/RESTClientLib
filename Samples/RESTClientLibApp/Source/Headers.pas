unit Headers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmHeaders = class(TForm)
    Headers: TValueListEditor;
    pnlHeader: TPanel;
    lblHeaderName: TLabel;
    edtHeaderName: TEdit;
    lblHeaderValue: TLabel;
    edtHeaderValue: TEdit;
    btnAdd: TSpeedButton;
    btnClear: TSpeedButton;
    ckbEncode: TCheckBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmHeaders.btnAddClick(Sender: TObject);
begin
  if ((Trim(edtHeaderName.Text) = EmptyStr) or
     (Trim(edtHeaderValue.Text) = EmptyStr)) then
    Exit;

  Headers.Strings.AddObject(Format('%s=%s', [edtHeaderName.Text, edtHeaderValue.Text]), TObject(ckbEncode.Checked));
  edtHeaderName.Clear;
  edtHeaderValue.Clear;
  ckbEncode.Checked := False;
end;

procedure TfrmHeaders.btnClearClick(Sender: TObject);
begin
  Headers.Strings.Clear;
  edtHeaderName.Clear;
  edtHeaderValue.Clear;
  edtHeaderName.SetFocus;
end;

end.
