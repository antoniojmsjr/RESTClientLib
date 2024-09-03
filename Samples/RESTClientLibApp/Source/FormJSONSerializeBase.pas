unit FormJSONSerializeBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, RESTClientLib;

type
  TfrmFormJSONSerializeBase = class(TForm)
    gbxGET: TGroupBox;
    gbxRequestGETURL: TGroupBox;
    lblRequestGETURL: TLabel;
    lblRequestGETResource: TLabel;
    edtRequestGETURL: TButtonedEdit;
    edtRequestGETResource: TButtonedEdit;
    gbxResponseGET: TGroupBox;
    mmoResponseGETBody: TMemo;
    gbxResponseGETData: TGroupBox;
    btnRequestGETExecute: TBitBtn;
    gbxSettings: TGroupBox;
    lblRequestTimeout: TLabel;
    lblResponseTimeout: TLabel;
    lblRetries: TLabel;
    lblProxyServer: TLabel;
    bvlConfig: TBevel;
    lblProxyPort: TLabel;
    lblProxyUserName: TLabel;
    lblProxyPassword: TLabel;
    lblRequestLibrary: TLabel;
    lblDebugRESTClientLib: TLabel;
    lblConnectionKeepAlive: TLabel;
    ckbDebugRESTClientLib: TCheckBox;
    edtRequestTimeout: TSpinEdit;
    edtResponseTimeout: TSpinEdit;
    edtRetries: TSpinEdit;
    edtProxyServer: TEdit;
    edtProxyPort: TSpinEdit;
    edtProxyUserName: TEdit;
    edtProxyPassword: TEdit;
    cbxRequestLibrary: TComboBox;
    ckbConnectionKeepAlive: TCheckBox;
    procedure btnRequestGETExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    { protected declarations }
    FRESTClientLib: IRESTClientLib;
    procedure ProcessResponse(pResponse: IResponse); virtual;
  public
    { Public declarations }
  end;

implementation

uses
  RESTClientLib.Types;

{$R *.dfm}

procedure TfrmFormJSONSerializeBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFormJSONSerializeBase.FormCreate(Sender: TObject);
begin
  {$IFDEF RESTClientLib_SYNAPSE}
  cbxRequestLibrary.Items.Add('Synapse');
  {$ENDIF RESTClientLib_SYNAPSE}
end;

procedure TfrmFormJSONSerializeBase.btnRequestGETExecuteClick(Sender: TObject);
var
  lResponse: IResponse;
begin
  FRESTClientLib := TRESTClientLib
    .Build(RequestLibraryFromString(cbxRequestLibrary.Text))
    .DebugLib(ckbDebugRESTClientLib.Checked);

  FRESTClientLib.Headers.AcceptEncoding('deflate');

  // Connection Keep-Alive?
  FRESTClientLib.Headers.ConnectionKeepAlive(ckbConnectionKeepAlive.Checked);

  // Options
  FRESTClientLib
    .Options
      .RequestTimeout(edtRequestTimeout.Value)
      .ResponseTimeout(edtResponseTimeout.Value)
      .Retries(edtRetries.Value)
      .HeaderOptions([hoRequestID, hoRequestTime, hoRequestPlatform, hoRequestLib])
      .Proxy
        .Server(edtProxyServer.Text)
        .Port(edtProxyPort.Value)
        .User(edtProxyUserName.Text)
        .Password(edtProxyPassword.Text);

  // URL
  FRESTClientLib
    .URL
      .BaseURL(edtRequestGETURL.Text)
      .Resource(edtRequestGETResource.Text);

  lResponse := FRESTClientLib.Request.GET;
  ProcessResponse(lResponse);
end;

procedure TfrmFormJSONSerializeBase.ProcessResponse(pResponse: IResponse);
begin
  if not Assigned(pResponse) then
    Exit;

  if pResponse.Body.IsBinary then
    Exit;

  mmoResponseGETBody.Lines.Text := pResponse.Body.Content;
end;

end.
