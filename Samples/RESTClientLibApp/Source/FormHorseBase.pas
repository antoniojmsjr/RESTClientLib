unit FormHorseBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.Buttons, Vcl.ComCtrls, RESTClientLib;

type
  TfrmFormHorseBase = class(TForm)
    gbxRequest: TGroupBox;
    pnlRequestExecute: TPanel;
    bvlRequestExecute: TBevel;
    btnRequestExecute: TBitBtn;
    ckbRequestExecuteThread: TCheckBox;
    gbxRequestBody: TGroupBox;
    splMain: TSplitter;
    gbxResponse: TGroupBox;
    pnlResponseStatus: TPanel;
    lblResponseURL: TLabel;
    lblResponseStatus: TLabel;
    pgcResponseBody: TPageControl;
    tbsResponseBody: TTabSheet;
    gbxResponseBinary: TGroupBox;
    lblResponseMIMETypeTitle: TLabel;
    lblResponseMIMEType: TLabel;
    lblResponseMIMETypeExtTitle: TLabel;
    lblResponseMIMETypeExt: TLabel;
    lblResponseCharSetTitle: TLabel;
    lblResponseCharSet: TLabel;
    ckbResponseIsBinary: TCheckBox;
    btnResponseSaveToFile: TBitBtn;
    tbsResponseHeaders: TTabSheet;
    mmoResponseHeaders: TMemo;
    tbsResponseCookies: TTabSheet;
    mmoResponseCookies: TMemo;
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
    gbxRequestURL: TGroupBox;
    lblRequestMethod: TLabel;
    lblRequestBaseURL: TLabel;
    lblRequestResource: TLabel;
    cbxRequestMethod: TComboBox;
    edtRequestBaseURL: TButtonedEdit;
    edtRequestResource: TButtonedEdit;
    sdlSaveFile: TSaveDialog;
    procedure btnRequestExecuteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnResponseSaveToFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLoadingID: string;
    procedure OnTerminateThread(Sender: TObject);
  protected
    { Protected declarations }
    FRESTClientLib: IRESTClientLib;
    FResponse: IResponse;
    procedure PrepareExecute; virtual; abstract;
    procedure ProcessResponse(pResponse: IResponse); virtual;
  public
    { Public declarations }
  end;

implementation

uses
  RESTClientLib.Types, Loading;

{$R *.dfm}

{ TfrmFormHorseBase }

procedure TfrmFormHorseBase.FormCreate(Sender: TObject);
begin
  {$IFDEF RESTClientLib_SYNAPSE}
  cbxRequestLibrary.Items.Add('Synapse');
  {$ENDIF RESTClientLib_SYNAPSE}
end;

procedure TfrmFormHorseBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFormHorseBase.btnRequestExecuteClick(Sender: TObject);
var
  lExecute: TThread;
begin
  FRESTClientLib := TRESTClientLib
    .Build(RequestLibraryFromString(cbxRequestLibrary.Text))
    .DebugLib(ckbDebugRESTClientLib.Checked);

  FRESTClientLib.Headers.Reset;

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
      .BaseURL(edtRequestBaseURL.Text)
      .Resource(edtRequestResource.Text);

  PrepareExecute;

  case ckbRequestExecuteThread.Checked of
    True:
    begin
      btnRequestExecute.Enabled := False;
      FLoadingID := TControllerLoading.Default.Start(pnlRequestExecute);

      lExecute := TThread.CreateAnonymousThread(procedure
      begin
        FResponse := FRESTClientLib.Request.FromString(cbxRequestMethod.Text);
      end);
      lExecute.OnTerminate := OnTerminateThread;
      lExecute.Start;
    end;
    False:
    begin
      btnRequestExecute.Enabled := False;
      FLoadingID := TControllerLoading.Default.Start(pnlRequestExecute);
      try
        FResponse := FRESTClientLib.Request.FromString(cbxRequestMethod.Text);
        ProcessResponse(FResponse);
      finally
        btnRequestExecute.Enabled := True;
        TControllerLoading.Default.Done(FLoadingID);
      end;
    end;
  end;
end;

procedure TfrmFormHorseBase.btnResponseSaveToFileClick(Sender: TObject);
var
  lFile: string;
begin
  if not InputQuery('Save File', 'File e extension name:', lFile) then
    Exit;

  if (Trim(lFile) = EmptyStr)  then
    Exit;

  sdlSaveFile.FileName := lFile;
  if not sdlSaveFile.Execute then
    Exit;

  FResponse.Body.SaveToFile(sdlSaveFile.FileName);
end;

procedure TfrmFormHorseBase.OnTerminateThread(Sender: TObject);
var
  lExcept: Exception;
begin
  Application.ProcessMessages;
  btnRequestExecute.Enabled := True;
  TControllerLoading.Default.Done(FLoadingID);

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      lExcept := Exception(TThread(sender).FatalException);
      if (lExcept is ERESTClientLib) then
        Application.MessageBox(PWideChar((lExcept as ERESTClientLib).ToString), PWideChar('E R R O R'), MB_OK + MB_ICONERROR)
      else
        Application.MessageBox(PWideChar(lExcept.Message), PWideChar('E R R O R'), MB_OK + MB_ICONERROR);
      Exit;
    end;

  // Response
  ProcessResponse(FResponse);
end;

procedure TfrmFormHorseBase.ProcessResponse(pResponse: IResponse);
begin
  if not Assigned(pResponse) then
    Exit;

  lblResponseURL.Caption := Format('%s', [pResponse.URL]);
  lblResponseStatus.Caption := Format('%s - %s :: Content size: %s :: Request time: %s ', [
    pResponse.StatusCodeAsString, pResponse.StatusText, pResponse.Body.SizeAsString, pResponse.RequestTimeAsString]);

  lblResponseMIMEType.Caption := pResponse.Body.MIMEType;
  lblResponseMIMETypeExt.Caption := pResponse.Body.MIMETypeExt;
  lblResponseCharSet.Caption := pResponse.Body.CharSet;
  ckbResponseIsBinary.Checked := pResponse.Body.IsBinary;
  btnResponseSaveToFile.Enabled := pResponse.Body.IsBinary;

  mmoResponseHeaders.Lines.BeginUpdate;
  mmoResponseHeaders.Lines.Clear;
  try
    mmoResponseHeaders.Lines.Text := pResponse.Headers.ToString;
  finally
    mmoResponseHeaders.Lines.EndUpdate;
  end;

  mmoResponseCookies.Lines.BeginUpdate;
  mmoResponseCookies.Lines.Clear;
  try
    mmoResponseCookies.Lines.Text := pResponse.Cookies.ToString;
  finally
    mmoResponseCookies.Lines.EndUpdate;
  end;
end;

end.
