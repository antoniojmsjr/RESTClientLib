unit View.Compression;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormRequestBase,
  Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Horse;

type
  TfrmViewCompression = class(TfrmRequestBase)
    mmoText: TMemo;
    lblStatus: TLabel;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse); override;
  public
    { Public declarations }
    procedure AfterConstruction; override;
  end;

implementation

uses
  Main;

{$R *.dfm}

{ TfrmViewCompression }

procedure TfrmViewCompression.AfterConstruction;
begin
  inherited;
  THorse.Get('/compression', ProcessRequest);

  lblStatus.Caption := Format('Size: %d', [Length(mmoText.Text)]);
end;

procedure TfrmViewCompression.ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  TThread.Synchronize(nil, procedure
  begin
    frmMain.PageControl.ActivePage := frmMain.tbsCompression;
  end);

  inherited ProcessRequest(pRequest, pResponse);
  pResponse.Send(mmoText.Text).Status(200);
end;

end.
