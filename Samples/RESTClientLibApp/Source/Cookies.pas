unit Cookies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmCookies = class(TForm)
    Cookies: TValueListEditor;
    pnlCookies: TPanel;
    lblCookieName: TLabel;
    edtCookieName: TEdit;
    lblCookieValue: TLabel;
    edtCookieValue: TEdit;
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

procedure TfrmCookies.btnAddClick(Sender: TObject);
begin
  if ((Trim(edtCookieName.Text) = EmptyStr) or
     (Trim(edtCookieValue.Text) = EmptyStr)) then
    Exit;

  Cookies.Strings.AddObject(Format('%s=%s', [edtCookieName.Text, edtCookieValue.Text]), TObject(ckbEncode.Checked));
  edtCookieName.Clear;
  edtCookieValue.Clear;
  ckbEncode.Checked := False;
end;

procedure TfrmCookies.btnClearClick(Sender: TObject);
begin
  Cookies.Strings.Clear;
  edtCookieName.Clear;
  edtCookieValue.Clear;
  edtCookieName.SetFocus;
end;

end.
