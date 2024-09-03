unit Authentication;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAuthentication = class(TForm)
    rgbAuthorizationScheme: TRadioGroup;
    pnlClient: TPanel;
    edtKey: TLabeledEdit;
    edtValue: TLabeledEdit;
    btnClear: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure rgbAuthorizationSchemeClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
    procedure MakeLayout;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmAuthentication }

procedure TfrmAuthentication.btnClearClick(Sender: TObject);
begin
  edtKey.Clear;
  edtValue.Clear;
  case rgbAuthorizationScheme.ItemIndex of
    0: edtKey.SetFocus;
    1, 2: edtValue.Clear;
  end;

end;

procedure TfrmAuthentication.FormCreate(Sender: TObject);
begin
  MakeLayout;
end;

procedure TfrmAuthentication.MakeLayout;
begin
  case rgbAuthorizationScheme.ItemIndex of
    0: // Basic
    begin
      edtKey.Visible := True;
      edtKey.EditLabel.Caption := 'User';
      edtKey.Left := 15;
      edtKey.Width := 190;

      edtValue.Visible := True;
      edtValue.EditLabel.Caption := 'Password';
      edtValue.Left := 230;
      edtValue.Width := 190;
    end;
    1, 2: // Bearer/Token
    begin
      edtKey.Visible := False;

      edtValue.Visible := True;
      edtValue.EditLabel.Caption := 'Token';
      edtValue.Left := 15;
      edtValue.Width := 405;
    end;
  end;
end;

procedure TfrmAuthentication.rgbAuthorizationSchemeClick(Sender: TObject);
begin
  edtKey.Clear;
  edtValue.Clear;
  MakeLayout;
end;

end.
