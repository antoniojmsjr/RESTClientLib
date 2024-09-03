unit View.Horse.JSON;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormHorseBase, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  RESTClientLib;

type
  TfrmViewHorseJSON = class(TfrmFormHorseBase)
    mmoRequestBody: TMemo;
    mmoResponseBody: TMemo;
    procedure FormCreate(Sender: TObject);
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

uses
  System.JSON;

{$R *.dfm}

procedure TfrmViewHorseJSON.FormCreate(Sender: TObject);
begin
  inherited;
  cbxRequestMethod.ItemIndex := cbxRequestMethod.Items.IndexOf('POST');
end;

procedure TfrmViewHorseJSON.PrepareExecute;
var
  lJSONObject: TJSONObject;
begin
  FRESTClientLib.Body.Reset;

  lJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mmoRequestBody.Text), 0) as TJSONObject;
  FRESTClientLib.Body.JSON(lJSONObject);
end;

procedure TfrmViewHorseJSON.ProcessResponse(pResponse: IResponse);
var
  lJSON: TJSONValue;
begin
  inherited ProcessResponse(pResponse);

  if (pResponse.StatusCode <> 200) then
  begin
    mmoResponseBody.Lines.Clear;
    mmoResponseBody.Lines.Text := pResponse.Body.Content;
    Exit;
  end;

  mmoResponseBody.Lines.Clear;
  if not pResponse.Body.IsBinary then
  begin
    mmoResponseBody.Lines.BeginUpdate;
    lJSON := nil;
    try
      lJSON := pResponse.Body.AsJSON;
      {$IF CompilerVersion >= 33}
      mmoResponseBody.Lines.Text := lJSON.Format(2);
      {$ELSE}
      mmoResponseBody.Lines.Text := lJSON.ToJSON;
      {$ENDIF}
    finally
      lJSON.Free;
      mmoResponseBody.Lines.EndUpdate;
    end;
  end;
end;

end.
