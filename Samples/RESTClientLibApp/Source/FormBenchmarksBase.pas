unit FormBenchmarksBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  RESTClientLib, Vcl.DBCtrls, Vcl.Samples.Spin;

type
  TfrmFormBenchmarksBase = class(TForm)
    gbxRequestURL: TGroupBox;
    lblRequestMethod: TLabel;
    lblRequestBaseURL: TLabel;
    lblRequestResource: TLabel;
    cbxRequestMethod: TComboBox;
    edtRequestBaseURL: TButtonedEdit;
    edtRequestResource: TButtonedEdit;
    pnlClient: TPanel;
    gbxNetHTTP: TGroupBox;
    pnlRequestExecute: TPanel;
    bvlRequestExecuteTop: TBevel;
    btnRequestExecute: TBitBtn;
    memLogNetHTTP: TFDMemTable;
    pnlNetHTTPFooter: TPanel;
    bvlNetHTTPFooter: TBevel;
    dbgNetHTTP: TDBGrid;
    dsLogNetHTTP: TDataSource;
    memLogNetHTTPNUMBER: TIntegerField;
    memLogNetHTTPREQUEST_TIME: TIntegerField;
    memLogNetHTTPREQUEST_TIME_DISPLAY: TStringField;
    dblblNetHTTPRequestTimeTotal: TDBText;
    memLogNetHTTPREQUEST_TIME_TOTAL: TAggregateField;
    gbxIndy: TGroupBox;
    pnlIndyFooter: TPanel;
    bvlIndyFooter: TBevel;
    dblblIndyRequestTimeTotal: TDBText;
    dbgIndy: TDBGrid;
    memLogIndy: TFDMemTable;
    memLogIndyNUMBER: TIntegerField;
    memLogIndyREQUEST_TIME: TIntegerField;
    memLogIndyREQUEST_TIME_DISPLAY: TStringField;
    memLogIndyREQUEST_TIME_TOTAL: TAggregateField;
    dsLogIndy: TDataSource;
    gbxSynapse: TGroupBox;
    pnlSynapseFooter: TPanel;
    bvlSynapseFooter: TBevel;
    dblblSynapseRequestTimeTotal: TDBText;
    dbgSynapse: TDBGrid;
    memLogSynapse: TFDMemTable;
    memLogSynapseNUMBER: TIntegerField;
    memLogSynapseREQUEST_TIME: TIntegerField;
    memLogSynapseREQUEST_TIME_DISPLAY: TStringField;
    memLogSynapseREQUEST_TIME_TOTAL: TAggregateField;
    dsLogSynapse: TDataSource;
    dblblNetHTTPRequestTimeAverage: TDBText;
    memLogNetHTTPREQUEST_TIME_AVG: TAggregateField;
    memLogIndyREQUEST_TIME_AVG: TAggregateField;
    dblblIndyRequestTimeAverage: TDBText;
    dblblSynapseRequestTimeAverage: TDBText;
    memLogSynapseREQUEST_TIME_AVG: TAggregateField;
    bvlRequestExecuteBottom: TBevel;
    pnlBottom: TPanel;
    gbxNetHTTPTotalizer: TGroupBox;
    pnlNetHTTPTotalizer: TPanel;
    bvlNetHTTPTotalizer: TBevel;
    dblblNetHTTPTotalizerRequestTimeTotal: TDBText;
    dblblNetHTTPTotalizerRequestTimeAverage: TDBText;
    dbgNetHTTPTotalizer: TDBGrid;
    memLogNetHTTPTotalizer: TFDMemTable;
    memLogNetHTTPTotalizerNUMBER: TIntegerField;
    memLogNetHTTPTotalizerREQUEST_TIME_TOTAL: TIntegerField;
    memLogNetHTTPTotalizerREQUEST_TIME_AVG: TIntegerField;
    dsLogNetHTTPTotalizer: TDataSource;
    memLogNetHTTPTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField;
    memLogNetHTTPTotalizerREQUEST_TIME_AVG_AVG: TAggregateField;
    gbxIndyTotalizer: TGroupBox;
    pnlIndyTotalizer: TPanel;
    bvlIndyTotalizer: TBevel;
    dblblIndyTotalizerRequestTimeTotal: TDBText;
    dblblIndyTotalizerRequestTimeAverage: TDBText;
    dbgIndyTotalizer: TDBGrid;
    memLogIndyTotalizer: TFDMemTable;
    memLogIndyTotalizerNUMBER: TIntegerField;
    memLogIndyTotalizerREQUEST_TIME_TOTAL: TIntegerField;
    memLogIndyTotalizerREQUEST_TIME_AVG: TIntegerField;
    memLogIndyTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField;
    memLogIndyTotalizerREQUEST_TIME_AVG_AVG: TAggregateField;
    dsLogIndyTotalizer: TDataSource;
    gbxSynapseTotalizer: TGroupBox;
    pnlSynapseTotalizer: TPanel;
    bvlSynapseTotalizer: TBevel;
    dblblSynapseTotalizerRequestTimeTotal: TDBText;
    dblblSynapseTotalizerRequestTimeAverage: TDBText;
    dbgSynapseTotalizer: TDBGrid;
    memLogSynapseTotalizer: TFDMemTable;
    memLogSynapseTotalizerNUMBER: TIntegerField;
    memLogSynapseTotalizerREQUEST_TIME_TOTAL: TIntegerField;
    memLogSynapseTotalizerREQUEST_TIME_AVG: TIntegerField;
    memLogSynapseTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField;
    memLogSynapseTotalizerREQUEST_TIME_AVG_AVG: TAggregateField;
    dsLogSynapseTotalizer: TDataSource;
    gbxSettings: TGroupBox;
    lblRequestTimeout: TLabel;
    lblResponseTimeout: TLabel;
    lblRetries: TLabel;
    lblProxyServer: TLabel;
    bvlConfig: TBevel;
    lblProxyPort: TLabel;
    lblProxyUserName: TLabel;
    lblProxyPassword: TLabel;
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
    ckbConnectionKeepAlive: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRequestExecuteClick(Sender: TObject);
    procedure ckbDebugRESTClientLibClick(Sender: TObject);
    procedure ckbConnectionKeepAliveClick(Sender: TObject);
  private
    { Private declarations }
    FLoadingID: string;
    FRESTClientLibNetHTTP: IRESTClientLib;
    FRESTClientLibIndy: IRESTClientLib;
    {$IFDEF RESTClientLib_SYNAPSE}
    FRESTClientLibSynapse: IRESTClientLib;
    {$ENDIF RESTClientLib_SYNAPSE}
    procedure OnTerminate(Sender: TObject);
    procedure RequestNetHTTP;
    procedure RequestNetHTTPTotalizer(const pNumber: Integer);
    procedure RequestIndy;
    procedure RequestIndyTotalizer(const pNumber: Integer);
    {$IFDEF RESTClientLib_SYNAPSE}
    procedure RequestSynapse;
    procedure RequestSynapseTotalizer(const pNumber: Integer);
    {$ENDIF RESTClientLib_SYNAPSE}
    procedure RequestExecute;
  public
    { Public declarations }
  end;

implementation

uses
  RESTClientLib.Types, Loading;

{$R *.dfm}

{ TfrmFormBenchmarksBase }

procedure TfrmFormBenchmarksBase.FormCreate(Sender: TObject);
begin
  memLogNetHTTP.CreateDataSet;
  memLogNetHTTPTotalizer.CreateDataSet;
  memLogIndy.CreateDataSet;
  memLogIndyTotalizer.CreateDataSet;
  memLogSynapse.CreateDataSet;
  memLogSynapseTotalizer.CreateDataSet;
end;

procedure TfrmFormBenchmarksBase.OnTerminate(Sender: TObject);
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
    end;
end;

procedure TfrmFormBenchmarksBase.btnRequestExecuteClick(Sender: TObject);
var
  lExecute: TThread;
begin
  btnRequestExecute.Enabled := False;
  FLoadingID := TControllerLoading.Default.Start(pnlRequestExecute);

  lExecute := TThread.CreateAnonymousThread(procedure
  begin
    Requestexecute;
  end);
  lExecute.OnTerminate := OnTerminate;
  lExecute.Start;
end;

procedure TfrmFormBenchmarksBase.ckbConnectionKeepAliveClick(Sender: TObject);
var
  lCheckBox: TCheckBox absolute Sender;
begin
  if lCheckBox.Checked then
    lCheckBox.Caption := ' true'
  else
    lCheckBox.Caption := ' false';
end;

procedure TfrmFormBenchmarksBase.ckbDebugRESTClientLibClick(Sender: TObject);
var
  lCheckBox: TCheckBox absolute Sender;
begin
  if lCheckBox.Checked then
    lCheckBox.Caption := ' true'
  else
    lCheckBox.Caption := ' false';
end;

procedure TfrmFormBenchmarksBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFormBenchmarksBase.Requestexecute;
var
  I: Integer;
begin
  TThread.Synchronize(nil, procedure
  begin
    memLogNetHTTPTotalizer.Close;
    memLogNetHTTPTotalizer.Open;
    memLogIndyTotalizer.Close;
    memLogIndyTotalizer.Open;
    memLogSynapseTotalizer.Close;
    memLogSynapseTotalizer.Open;
    Application.ProcessMessages;
  end);

  for I := 1 to 5 do
  begin
    RequestNetHTTP;
    RequestNetHTTPTotalizer(I);
    TThread.Sleep(100);
    RequestIndy;
    RequestIndyTotalizer(I);
    TThread.Sleep(100);
    {$IFDEF RESTClientLib_SYNAPSE}
    RequestSynapse;
    RequestSynapseTotalizer(I);
    {$ENDIF RESTClientLib_SYNAPSE}
  end;
end;

procedure TfrmFormBenchmarksBase.RequestIndy;
var
  I: Integer;
  lResponse: IResponse;
begin
  FRESTClientLibIndy := TRESTClientLib
    .Build(TRESTClientLibRequestLibraryKind.Indy)
    .DebugLib(ckbDebugRESTClientLib.Checked);

  // Options
  FRESTClientLibIndy
    .Options
      .RequestTimeout(edtRequestTimeout.Value)
      .ResponseTimeout(edtResponseTimeout.Value)
      .Retries(edtRetries.Value)
      .Proxy
        .Server(edtProxyServer.Text)
        .Port(edtProxyPort.Value)
        .User(edtProxyUserName.Text)
        .Password(edtProxyPassword.Text);

  // Connection Keep-Alive?
  FRESTClientLibIndy.Headers.ConnectionKeepAlive(ckbConnectionKeepAlive.Checked);

  TThread.Synchronize(nil, procedure
  begin
    memLogIndy.Close;
    memLogIndy.Open;
    Application.ProcessMessages;
  end);

  for I := 1 to 10 do
  begin
    // Execute
    lResponse := FRESTClientLibIndy.URL.BaseURL(edtRequestBaseURL.Text).Resource(edtRequestResource.Text).&End.Request.Get;

    TThread.Synchronize(nil, procedure
    begin
      memLogIndy.Append;
      memLogIndyNUMBER.AsInteger := I;
      memLogIndyREQUEST_TIME.AsInteger := lResponse.RequestTime;
      memLogIndyREQUEST_TIME_DISPLAY.AsString := lResponse.RequestTimeAsString;
      memLogIndy.Post;
      Application.ProcessMessages;
    end);
  end;
end;

procedure TfrmFormBenchmarksBase.RequestIndyTotalizer(const pNumber: Integer);
begin
  TThread.Synchronize(nil, procedure
  begin
    memLogIndyTotalizer.Append;
    memLogIndyTotalizerNUMBER.AsInteger := pNumber;
    memLogIndyTotalizerREQUEST_TIME_TOTAL.Value := memLogIndyREQUEST_TIME_TOTAL.Value;
    memLogIndyTotalizerREQUEST_TIME_AVG.Value := memLogIndyREQUEST_TIME_AVG.Value;
    memLogIndyTotalizer.Post;
    Application.ProcessMessages;
  end);
end;

procedure TfrmFormBenchmarksBase.RequestNetHTTP;
var
  lResponse: IResponse;
  I: Integer;
begin
  FRESTClientLibNetHTTP := TRESTClientLib
    .Build(TRESTClientLibRequestLibraryKind.NetHTTP)
    .DebugLib(ckbDebugRESTClientLib.Checked);

  // Options
  FRESTClientLibNetHTTP
    .Options
      .RequestTimeout(edtRequestTimeout.Value)
      .ResponseTimeout(edtResponseTimeout.Value)
      .Retries(edtRetries.Value)
      .Proxy
        .Server(edtProxyServer.Text)
        .Port(edtProxyPort.Value)
        .User(edtProxyUserName.Text)
        .Password(edtProxyPassword.Text);

  // Connection Keep-Alive?
  FRESTClientLibNetHTTP.Headers.ConnectionKeepAlive(ckbConnectionKeepAlive.Checked);

  TThread.Synchronize(nil, procedure
  begin
    memLogNetHTTP.Close;
    memLogNetHTTP.Open;
    Application.ProcessMessages;
  end);

  for I := 1 to 10 do
  begin
    // Execute
    lResponse := FRESTClientLibNetHTTP.URL.BaseURL(edtRequestBaseURL.Text).Resource(edtRequestResource.Text).&End.Request.Get;

    TThread.Synchronize(nil, procedure
    begin
      memLogNetHTTP.Append;
      memLogNetHTTPNUMBER.AsInteger := I;
      memLogNetHTTPREQUEST_TIME.AsInteger := lResponse.RequestTime;
      memLogNetHTTPREQUEST_TIME_DISPLAY.AsString := lResponse.RequestTimeAsString;
      memLogNetHTTP.Post;
      Application.ProcessMessages;
    end);
  end;
end;

procedure TfrmFormBenchmarksBase.RequestNetHTTPTotalizer(const pNumber: Integer);
begin
  TThread.Synchronize(nil, procedure
  begin
    memLogNetHTTPTotalizer.Append;
    memLogNetHTTPTotalizerNUMBER.AsInteger := pNumber;
    memLogNetHTTPTotalizerREQUEST_TIME_TOTAL.Value := memLogNetHTTPREQUEST_TIME_TOTAL.Value;
    memLogNetHTTPTotalizerREQUEST_TIME_AVG.Value := memLogNetHTTPREQUEST_TIME_AVG.Value;
    memLogNetHTTPTotalizer.Post;
    Application.ProcessMessages;
  end);
end;

{$IFDEF RESTClientLib_SYNAPSE}
procedure TfrmFormBenchmarksBase.RequestSynapse;
var
  I: Integer;
  lResponse: IResponse;
begin
  FRESTClientLibSynapse := TRESTClientLib.Build(TRESTClientLibRequestLibraryKind.Synapse);
  FRESTClientLibSynapse.DebugLib(ckbDebugRESTClientLib.Checked);

  // Options
  FRESTClientLibSynapse
    .Options
      .RequestTimeout(edtRequestTimeout.Value)
      .ResponseTimeout(edtResponseTimeout.Value)
      .Retries(edtRetries.Value)
      .Proxy
        .Server(edtProxyServer.Text)
        .Port(edtProxyPort.Value)
        .User(edtProxyUserName.Text)
        .Password(edtProxyPassword.Text);

  // Connection Keep-Alive?
  FRESTClientLibSynapse.Headers.ConnectionKeepAlive(ckbConnectionKeepAlive.Checked);

  TThread.Synchronize(nil, procedure
  begin
    memLogSynapse.Close;
    memLogSynapse.Open;
    Application.ProcessMessages;
  end);

  for I := 1 to 10 do
  begin
    // Execute
    lResponse := FRESTClientLibSynapse.URL.BaseURL(edtRequestBaseURL.Text).&End.Request.Get;

    TThread.Synchronize(nil, procedure
    begin
      memLogSynapse.Append;
      memLogSynapseNUMBER.AsInteger := I;
      memLogSynapseREQUEST_TIME.AsInteger := lResponse.RequestTime;
      memLogSynapseREQUEST_TIME_DISPLAY.AsString := lResponse.RequestTimeAsString;
      memLogSynapse.Post;
      Application.ProcessMessages;
    end);
  end;
end;

procedure TfrmFormBenchmarksBase.RequestSynapseTotalizer(const pNumber: Integer);
begin
  TThread.Synchronize(nil, procedure
  begin
    memLogSynapseTotalizer.Append;
    memLogSynapseTotalizerNUMBER.AsInteger := pNumber;
    memLogSynapseTotalizerREQUEST_TIME_TOTAL.Value := memLogSynapseREQUEST_TIME_TOTAL.Value;
    memLogSynapseTotalizerREQUEST_TIME_AVG.Value := memLogSynapseREQUEST_TIME_AVG.Value;
    memLogSynapseTotalizer.Post;
    Application.ProcessMessages;
  end);
end;
{$ENDIF RESTClientLib_SYNAPSE}

end.
