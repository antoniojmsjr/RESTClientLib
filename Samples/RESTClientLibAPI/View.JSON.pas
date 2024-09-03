unit View.JSON;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormRequestBase,
  Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Horse;

type
  TfrmViewJSON = class(TfrmRequestBase)
    gbxJSONRequest: TGroupBox;
    gbxJSONResponse: TGroupBox;
    mmoJSONRequest: TMemo;
    mmoJSONResponse: TMemo;
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
  System.JSON, Main;

{$R *.dfm}

{ TfrmViewJSON }

procedure TfrmViewJSON.AfterConstruction;
begin
  inherited;
  THorse.Post('/json', ProcessRequest);
end;

procedure TfrmViewJSON.ProcessRequest(pRequest: THorseRequest;
  pResponse: THorseResponse);
var
  lJSONRequest: TJSONObject;
  lJSONResponse: TJSONObject;
begin
  TThread.Synchronize(nil, procedure
  begin
    frmMain.PageControl.ActivePage := frmMain.tbsJSON;
  end);

  inherited ProcessRequest(pRequest, pResponse);

  lJSONRequest := pRequest.Body<TJSONObject>;
  {$IF CompilerVersion >= 33}
  mmoJSONRequest.Text := lJSONRequest.Format(2);
  {$ELSE}
  mmoJSONRequest.Text := lJSONRequest.ToJSON;
  {$ENDIF}

  lJSONResponse := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mmoJSONResponse.Text), 0) as TJSONObject;
  pResponse.Send<TJSONObject>(lJSONResponse).Status(200);
end;

end.
