unit FormRequestBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Buttons,
  RESTClientLib, Headers, Cookies, PathParams, QueryParams,
  Authentication, Certificate, Vcl.ComCtrls;

type
  TfrmFormRequestBase = class(TForm)
    imgList: TImageList;
    gbxRequest: TGroupBox;
    pnlRequestExecute: TPanel;
    btnRequestExecute: TBitBtn;
    gbxRequestURL: TGroupBox;
    lblRequestMethod: TLabel;
    cbxRequestMethod: TComboBox;
    lblRequestBaseURL: TLabel;
    edtRequestBaseURL: TButtonedEdit;
    lblRequestResource: TLabel;
    edtRequestResource: TButtonedEdit;
    gbxRequestOthers: TGroupBox;
    btnRequestPathParams: TBitBtn;
    btnRequestQueryParams: TBitBtn;
    btnRequestAuthentication: TBitBtn;
    btnCertificate: TBitBtn;
    gbxRequestBody: TGroupBox;
    btnRequestHeaders: TBitBtn;
    bvlRequestOthers: TBevel;
    btnRequestCookies: TBitBtn;
    bvlRequestOthers2: TBevel;
    splMain: TSplitter;
    opdOpenFile: TOpenDialog;
    gbxResponse: TGroupBox;
    pnlResponseStatus: TPanel;
    lblResponseURL: TLabel;
    lblResponseStatus: TLabel;
    pgcResponseBody: TPageControl;
    tbsResponseBody: TTabSheet;
    tbsResponseHeaders: TTabSheet;
    tbsResponseCookies: TTabSheet;
    mmoResponseHeaders: TMemo;
    gbxResponseBinary: TGroupBox;
    mmoResponseBody: TMemo;
    lblResponseMIMETypeTitle: TLabel;
    lblResponseMIMEType: TLabel;
    lblResponseMIMETypeExtTitle: TLabel;
    lblResponseMIMETypeExt: TLabel;
    ckbResponseIsBinary: TCheckBox;
    btnResponseSaveToFile: TBitBtn;
    sdlSaveFile: TSaveDialog;
    mmoResponseCookies: TMemo;
    lblResponseCharSetTitle: TLabel;
    lblResponseCharSet: TLabel;
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
    ckbDebugRESTClientLib: TCheckBox;
    edtRequestTimeout: TSpinEdit;
    edtResponseTimeout: TSpinEdit;
    edtRetries: TSpinEdit;
    edtProxyServer: TEdit;
    edtProxyPort: TSpinEdit;
    edtProxyUserName: TEdit;
    edtProxyPassword: TEdit;
    cbxRequestLibrary: TComboBox;
    lblDebugRESTClientLib: TLabel;
    bvlRequestExecute: TBevel;
    lblConnectionKeepAlive: TLabel;
    ckbConnectionKeepAlive: TCheckBox;
    ckbRequestExecuteThread: TCheckBox;
    pgcRequestBody: TPageControl;
    tbsBody: TTabSheet;
    tbsMultipartFormData: TTabSheet;
    pnlRequestBodyFile: TPanel;
    lblRequestBodyFile: TLabel;
    bvlRequestBodyFile: TBevel;
    btnBodyFileOpen: TSpeedButton;
    lblRequestBodyFileContentTypeTitle: TLabel;
    lblRequestBodyFileContentType: TLabel;
    edtRequestBodyFile: TButtonedEdit;
    mmoRequestBody: TMemo;
    pnlRequestMultipartFormDataOptions: TPanel;
    bvlRequestMultipartFormData: TBevel;
    btnRequestMultipartFormDataAddText: TBitBtn;
    btnRequestMultipartFormDataAddFile: TBitBtn;
    btnRequestMultipartFormDataClear: TBitBtn;
    scbRequestMultipartFormData: TScrollBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRequestExecuteClick(Sender: TObject);
    procedure btnRequestPathParamsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRequestQueryParamsClick(Sender: TObject);
    procedure btnRequestAuthenticationClick(Sender: TObject);
    procedure btnCertificateClick(Sender: TObject);
    procedure btnRequestHeadersClick(Sender: TObject);
    procedure btnRequestCookiesClick(Sender: TObject);
    procedure btnBodyFileOpenClick(Sender: TObject);
    procedure edtRequestBodyFileChange(Sender: TObject);
    procedure btnResponseSaveToFileClick(Sender: TObject);
    procedure ckbDebugRESTClientLibClick(Sender: TObject);
    procedure btnRequestMultipartFormDataClearClick(Sender: TObject);
    procedure btnRequestMultipartFormDataAddFileClick(Sender: TObject);
    procedure btnRequestMultipartFormDataAddTextClick(Sender: TObject);
    procedure ckbConnectionKeepAliveClick(Sender: TObject);
  private
    { Private declarations }
    FLoadingID: string;
    procedure OnTerminateThread(Sender: TObject);
  protected
    { protected declarations }
    FfrmHeaders: TfrmHeaders;
    FfrmCookies: TfrmCookies;
    FfrmPathParams: TfrmPathParams;
    FfrmQueryParams: TfrmQueryParams;
    FfrmAuthentication: TfrmAuthentication;
    FfrmCertificate: TfrmCertificate;
    FRESTClientLib: IRESTClientLib;
    FResponse: IResponse;
    procedure ButtonedEditClearEvent(Sender: TObject);
    procedure ButtonedEditClearBuilder(pButtonedEdit: TButtonedEdit);
    procedure ProcessResponse(pResponse: IResponse);
    procedure OnMultipartFormDataAddFile(const pField: string; const pFilePath: string);
    procedure OnMultipartFormDataAddText(const pField: string; const pText: string);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  RESTClientLib.Types, RESTClientLib.Mime, MultipartFormDataAddFile,
  MultipartFormDataAddText, MultipartFormDataItem, Loading;

{ TfrmFormBase }

procedure OcultarSheets(const PageControl: TPageControl);
var
  I: Integer;
begin
  for I := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[I].TabVisible := False;

  if ( PageControl.PageCount > 0 ) then
    PageControl.ActivePage := PageControl.Pages[0];

  PageControl.Style := tsButtons;
end;

procedure TfrmFormRequestBase.FormCreate(Sender: TObject);
begin
  {$IFDEF RESTClientLib_SYNAPSE}
  cbxRequestLibrary.Items.Add('Synapse');
  {$ENDIF RESTClientLib_SYNAPSE}
  ButtonedEditClearBuilder(edtRequestBaseURL);
  ButtonedEditClearBuilder(edtRequestResource);
  ButtonedEditClearBuilder(edtRequestBodyFile);
  mmoResponseHeaders.Lines.NameValueSeparator := ':';
  OcultarSheets(pgcRequestBody);
end;

procedure TfrmFormRequestBase.OnMultipartFormDataAddFile(const pField: string; const pFilePath: string);
var
  lfrmMultipartFormDataItem: TfrmMultipartFormDataItem;
begin
  lfrmMultipartFormDataItem := TfrmMultipartFormDataItem.Create(scbRequestMultipartFormData);
  lfrmMultipartFormDataItem.IsBinary := True;
  lfrmMultipartFormDataItem.Field := pField;
  lfrmMultipartFormDataItem.Text := pFilePath;
  lfrmMultipartFormDataItem.scbMultipartFormData := scbRequestMultipartFormData;
  lfrmMultipartFormDataItem.Align := alBottom;
  lfrmMultipartFormDataItem.Parent := scbRequestMultipartFormData;
  lfrmMultipartFormDataItem.Align := alTop;
end;

procedure TfrmFormRequestBase.OnMultipartFormDataAddText(const pField: string; const pText: string);
var
  lfrmMultipartFormDataItem: TfrmMultipartFormDataItem;
begin
  lfrmMultipartFormDataItem := TfrmMultipartFormDataItem.Create(scbRequestMultipartFormData);
  lfrmMultipartFormDataItem.IsBinary := False;
  lfrmMultipartFormDataItem.Field := pField;
  lfrmMultipartFormDataItem.Text := pText;
  lfrmMultipartFormDataItem.scbMultipartFormData := scbRequestMultipartFormData;
  lfrmMultipartFormDataItem.Align := alBottom;
  lfrmMultipartFormDataItem.Parent := scbRequestMultipartFormData;
  lfrmMultipartFormDataItem.Align := alTop;
end;

procedure TfrmFormRequestBase.OnTerminateThread(Sender: TObject);
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

procedure TfrmFormRequestBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFormRequestBase.btnRequestAuthenticationClick(Sender: TObject);
begin
  if not Assigned(FfrmAuthentication) then
    FfrmAuthentication := TfrmAuthentication.Create(Self);
  FfrmAuthentication.ShowModal;
end;

procedure TfrmFormRequestBase.btnBodyFileOpenClick(Sender: TObject);
begin
  if not opdOpenFile.Execute then
    Exit;

  edtRequestBodyFile.Text := opdOpenFile.FileName;
  lblRequestBodyFileContentType.Caption := TRESTClientLibMimeTypes.FileType(edtRequestBodyFile.Text);
end;

procedure TfrmFormRequestBase.btnCertificateClick(Sender: TObject);
begin
  if not Assigned(FfrmCertificate) then
    FfrmCertificate := TfrmCertificate.Create(Self);
  FfrmCertificate.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestCookiesClick(Sender: TObject);
begin
  if not Assigned(FfrmCookies) then
    FfrmCookies := TfrmCookies.Create(Self);
  FfrmCookies.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestExecuteClick(Sender: TObject);
var
  I: Integer;
  lName: string;
  lValue: string;
  lBoolean: Boolean;
  lfrmMultipartFormDataItem: TfrmMultipartFormDataItem;
  lExecute: TThread;
begin
  FRESTClientLib := TRESTClientLib
    .Build(RequestLibraryFromString(cbxRequestLibrary.Text))
    .DebugLib(ckbDebugRESTClientLib.Checked);

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

  // Certificate
  if Assigned(FfrmCertificate) then
  begin
    FRESTClientLib
      .Options
        .Certificate
          .CertFile(FfrmCertificate.edtCertFile.Text)
          .KeyFile(FfrmCertificate.edtKeyFile.Text);
  end;

  // URL
  FRESTClientLib
    .URL
      .BaseURL(edtRequestBaseURL.Text)
      .Resource(edtRequestResource.Text);

  // PathParams
  if Assigned(FfrmPathParams) then
    for I := 0 to Pred(FfrmPathParams.PathParams.Strings.Count) do
    begin
      lName := FfrmPathParams.PathParams.Strings.Names[I];
      lValue := FfrmPathParams.PathParams.Strings.ValueFromIndex[I];

      FRESTClientLib
      .URL
        .PathParams
          .Add(lName, lValue);
    end;

  // QueryParams
  if Assigned(FfrmQueryParams) then
    for I := 0 to Pred(FfrmQueryParams.QueryParams.Strings.Count) do
    begin
      lName := FfrmQueryParams.QueryParams.Strings.Names[I];
      lValue := FfrmQueryParams.QueryParams.Strings.ValueFromIndex[I];

      FRESTClientLib
      .URL
        .QueryParams
          .Add(lName, lValue);
    end;

    // Headers
    if Assigned(FfrmHeaders) then
      for I := 0 to Pred(FfrmHeaders.Headers.Strings.Count) do
      begin
        lName := FfrmHeaders.Headers.Strings.Names[I];
        lValue := FfrmHeaders.Headers.Strings.ValueFromIndex[I];
        lBoolean := Boolean(FfrmHeaders.Headers.Strings.Objects[I]);

        FRESTClientLib
          .Headers
            .Add(lName, lValue, lBoolean);
      end;

    // Cookies
    if Assigned(FfrmCookies) then
      for I := 0 to Pred(FfrmCookies.Cookies.Strings.Count) do
      begin
        lName := FfrmCookies.Cookies.Strings.Names[I];
        lValue := FfrmCookies.Cookies.Strings.ValueFromIndex[I];
        lBoolean := Boolean(FfrmCookies.Cookies.Strings.Objects[I]);

        FRESTClientLib
          .Cookies
            .Add(lName, lValue, lBoolean);
      end;

    // Authentication
    if Assigned(FfrmAuthentication) then
    begin
      case FfrmAuthentication.rgbAuthorizationScheme.ItemIndex of
        0: // Basic
        begin
          FRESTClientLib
            .Authentication
              .Basic(FfrmAuthentication.edtKey.Text, FfrmAuthentication.edtValue.Text);
        end;
        1: // Bearer
        begin
          FRESTClientLib
            .Authentication
              .Bearer(FfrmAuthentication.edtValue.Text);
        end;
        2: // Token
        begin
          FRESTClientLib
            .Authentication
              .Token(FfrmAuthentication.edtValue.Text);
        end;
      end;
    end;

  // Empty Body
  FRESTClientLib.Body.Reset;
  FRESTClientLib.MultipartFormData.Reset;

  if (pgcRequestBody.ActivePage = tbsBody) then
  begin
    // Body
    if (Trim(edtRequestBodyFile.Text) <> EmptyStr) then
      FRESTClientLib.Body.LoadFromFile(edtRequestBodyFile.Text)
    else
      if (Trim(mmoRequestBody.Text) <> EmptyStr) then
        FRESTClientLib.Body.Content(mmoRequestBody.Text);
  end
  else // MultipartFormData
    if (pgcRequestBody.ActivePage = tbsMultipartFormData) then
    begin
      // Empty Body

      for I := 0 to Pred(scbRequestMultipartFormData.ControlCount) do
      begin
        lfrmMultipartFormDataItem := scbRequestMultipartFormData.Controls[I] as TfrmMultipartFormDataItem;

        if lfrmMultipartFormDataItem.IsBinary then
          FRESTClientLib.MultipartFormData.LoadFromFile(lfrmMultipartFormDataItem.Field, lfrmMultipartFormDataItem.Text)
        else
          FRESTClientLib.MultipartFormData.Field(lfrmMultipartFormDataItem.Field, lfrmMultipartFormDataItem.Text);
      end;
    end;

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

procedure TfrmFormRequestBase.ProcessResponse(pResponse: IResponse);
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

  mmoResponseBody.Lines.Clear;
  if not pResponse.Body.IsBinary then
  begin
    mmoResponseBody.Lines.BeginUpdate;
    try
      mmoResponseBody.Lines.Text := pResponse.Body.Content;
    finally
      mmoResponseBody.Lines.EndUpdate;
    end;
  end;
end;

procedure TfrmFormRequestBase.btnRequestHeadersClick(Sender: TObject);
begin
  if not Assigned(FfrmHeaders) then
    FfrmHeaders := TfrmHeaders.Create(Self);
  FfrmHeaders.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestMultipartFormDataAddFileClick(Sender: TObject);
var
  lfrmMultipartFormDataAddFile: TfrmMultipartFormDataAddFile;
begin
  lfrmMultipartFormDataAddFile := TfrmMultipartFormDataAddFile.Create(nil);
  lfrmMultipartFormDataAddFile.OnAdd := OnMultipartFormDataAddFile;
  lfrmMultipartFormDataAddFile.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestMultipartFormDataAddTextClick(Sender: TObject);
var
  lfrmMultipartFormDataAddText: TfrmMultipartFormDataAddText;
begin
  lfrmMultipartFormDataAddText := TfrmMultipartFormDataAddText.Create(nil);
  lfrmMultipartFormDataAddText.OnAdd := OnMultipartFormDataAddText;
  lfrmMultipartFormDataAddText.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestMultipartFormDataClearClick(Sender: TObject);
var
   I: Integer;
begin
  for I := scbRequestMultipartFormData.ControlCount - 1 downto 0 do
    scbRequestMultipartFormData.Controls[I].Free;
end;

procedure TfrmFormRequestBase.btnRequestPathParamsClick(Sender: TObject);
begin
  if not Assigned(FfrmPathParams) then
    FfrmPathParams := TfrmPathParams.Create(Self);
  FfrmPathParams.ShowModal;
end;

procedure TfrmFormRequestBase.btnRequestQueryParamsClick(Sender: TObject);
begin
  if not Assigned(FfrmQueryParams) then
    FfrmQueryParams := TfrmQueryParams.Create(Self);
  FfrmQueryParams.ShowModal;
end;

procedure TfrmFormRequestBase.btnResponseSaveToFileClick(Sender: TObject);
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

procedure TfrmFormRequestBase.ButtonedEditClearBuilder(pButtonedEdit: TButtonedEdit);
begin
	pButtonedEdit.Images := imgList;
	pButtonedEdit.RightButton.Visible := true;
	pButtonedEdit.RightButton.Enabled := true;
	pButtonedEdit.RightButton.ImageIndex := 0;
	pButtonedEdit.RightButton.DisabledImageIndex := 0;
	pButtonedEdit.RightButton.PressedImageIndex := 0;
	pButtonedEdit.RightButton.HotImageIndex := 0;
  pButtonedEdit.OnRightButtonClick := ButtonedEditClearEvent;
  pButtonedEdit.Show();
end;

procedure TfrmFormRequestBase.ButtonedEditClearEvent(Sender: TObject);
begin
  TButtonedEdit(Sender).Clear;
end;

procedure TfrmFormRequestBase.ckbConnectionKeepAliveClick(Sender: TObject);
var
  lCheckBox: TCheckBox absolute Sender;
begin
  if lCheckBox.Checked then
    lCheckBox.Caption := ' true'
  else
    lCheckBox.Caption := ' false';
end;

procedure TfrmFormRequestBase.ckbDebugRESTClientLibClick(Sender: TObject);
var
  lCheckBox: TCheckBox absolute Sender;
begin
  if lCheckBox.Checked then
    lCheckBox.Caption := ' true'
  else
    lCheckBox.Caption := ' false';
end;

procedure TfrmFormRequestBase.edtRequestBodyFileChange(Sender: TObject);
begin
  if (edtRequestBodyFile.Text = EmptyStr) then
    lblRequestBodyFileContentType.Caption := '...';
end;

end.
