unit Certificate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmCertificate = class(TForm)
    pnlClient: TPanel;
    edtCertFile: TLabeledEdit;
    edtKeyFile: TLabeledEdit;
    btnClear: TSpeedButton;
    OpenDialog: TOpenDialog;
    btnOpenCertFile: TButton;
    btnOpenKeyFile: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure btnOpenCertFileClick(Sender: TObject);
    procedure btnOpenKeyFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmAuthentication }

procedure TfrmCertificate.btnClearClick(Sender: TObject);
begin
  edtCertFile.Clear;
  edtKeyFile.Clear;
  edtCertFile.SetFocus;
end;

procedure TfrmCertificate.btnOpenCertFileClick(Sender: TObject);
begin
  if not OpenDialog.Execute then
    Exit;

  edtCertFile.Text := OpenDialog.FileName;
end;

procedure TfrmCertificate.btnOpenKeyFileClick(Sender: TObject);
begin
  if not OpenDialog.Execute then
    Exit;

  edtKeyFile.Text := OpenDialog.FileName;
end;

end.
