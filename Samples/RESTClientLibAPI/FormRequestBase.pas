unit FormRequestBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ValEdit, Vcl.ExtCtrls, Horse;

type
  TfrmRequestBase = class(TFrame)
    gbxRequestURL: TGroupBox;
    edtRequestURL: TEdit;
    pnlLeft: TPanel;
    vleHeader: TValueListEditor;
    bvlLeft: TBevel;
    pnlClient: TPanel;
    lblHeaders: TLabel;
    lblRoute: TLabel;
  private
    { private declarations }
  protected
    { protected declarations }
    procedure ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse); virtual;
  public
    { public declarations }
  end;

implementation

uses
  System.Generics.Collections;

{$R *.dfm}

{ TfrmRequestBase }

function GetURL(pRequest: THorseRequest): string;
var
  lURL: string;
begin
  lURL := Format('http://%s:%d%s', [pRequest.RawWebRequest.Host, pRequest.RawWebRequest.ServerPort, pRequest.RawWebRequest.PathInfo]);
  if lURL.EndsWith('/') then
    Delete(lURL, Length(lURL), 1);

  if (pRequest.RawWebRequest.Query <> EmptyStr) then
    lURL := lURL + '?' + pRequest.RawWebRequest.Query;

  Result := lURL;
end;

procedure TfrmRequestBase.ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  TThread.Synchronize(nil, procedure
  var
    lField: TPair<string, string>;
  begin
    edtRequestURL.Text := GetURL(pRequest);

    vleHeader.Strings.Clear;
    for lField in pRequest.Headers.Dictionary do
      vleHeader.InsertRow(lField.Key, lField.Value, True);
  end);
end;

end.
