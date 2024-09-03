unit View.Horse.Compression;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormHorseBase, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  RESTClientLib;

type
  TfrmViewHorseCompression = class(TfrmFormHorseBase)
    mmoResponseBody: TMemo;
    lblStatus: TLabel;
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure PrepareExecute; override;
    procedure ProcessResponse(pResponse: IResponse); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmViewHorseCompression }

procedure TfrmViewHorseCompression.PrepareExecute;
begin
  FRESTClientLib.Headers.AcceptEncoding('gzip');
end;

procedure TfrmViewHorseCompression.ProcessResponse(pResponse: IResponse);
begin
  inherited ProcessResponse(pResponse);

  mmoResponseBody.Lines.Clear;
  if not pResponse.Body.IsBinary then
  begin
    mmoResponseBody.Lines.BeginUpdate;
    try
      mmoResponseBody.Lines.Text := pResponse.Body.Content;
      lblStatus.Caption := pResponse.Body.Size.ToString;
    finally
      mmoResponseBody.Lines.EndUpdate;
    end;
  end;
end;

end.
