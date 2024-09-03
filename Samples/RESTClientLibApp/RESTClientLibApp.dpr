program RESTClientLibApp;





{$R *.dres}

uses
  Vcl.Forms,
  Authentication in 'Source\Authentication.pas' {frmAuthentication},
  Certificate in 'Source\Certificate.pas' {frmCertificate},
  Cookies in 'Source\Cookies.pas' {frmCookies},
  Headers in 'Source\Headers.pas' {frmHeaders},
  Main in 'Source\Main.pas' {frmMain},
  MultipartFormDataAddText in 'Source\MultipartFormDataAddText.pas' {frmMultipartFormDataAddText},
  QueryParams in 'Source\QueryParams.pas' {frmQueryParams},
  View.RESTDebugger in 'Source\View.RESTDebugger.pas' {frmViewRESTDebugger},
  FormRequestBase in 'Source\FormRequestBase.pas' {frmFormRequestBase},
  MultipartFormDataItem in 'Source\MultipartFormDataItem.pas' {frmMultipartFormDataItem: TFrame},
  PathParams in 'Source\PathParams.pas' {frmPathParams},
  MultipartFormDataAddFile in 'Source\MultipartFormDataAddFile.pas' {frmMultipartFormDataAddFile},
  FormBenchmarksBase in 'Source\FormBenchmarksBase.pas' {frmFormBenchmarksBase},
  View.Benchmarks in 'Source\View.Benchmarks.pas' {frmViewBenchmarks},
  FormWait in 'Source\FormWait.pas' {frmWait: TFrame},
  Loading in 'Source\Loading.pas',
  FormJSONSerializeBase in 'Source\FormJSONSerializeBase.pas' {frmFormJSONSerializeBase},
  View.DataSetSerialize in 'Source\View.DataSetSerialize.pas' {frmViewDataSetSerialize},
  View.JSONObjectSerialize in 'Source\View.JSONObjectSerialize.pas' {frmViewJSONObjectSerialize},
  View.Horse.MultipartFormData in 'Source\View.Horse.MultipartFormData.pas' {frmViewHorseMultipartFormData},
  FormHorseBase in 'Source\FormHorseBase.pas' {frmFormHorseBase},
  View.Horse.JSON in 'Source\View.Horse.JSON.pas' {frmViewHorseJSON},
  View.Horse.Stream in 'Source\View.Horse.Stream.pas' {frmViewHorseStream},
  View.Horse.Compression in 'Source\View.Horse.Compression.pas' {frmViewHorseCompression},
  View.JSONReflectSerialize in 'Source\View.JSONReflectSerialize.pas' {frmJSONReflectSerialize},
  RESTClientLib.Consts in '..\..\Source\RESTClientLib.Consts.pas',
  RESTClientLib.Core in '..\..\Source\RESTClientLib.Core.pas',
  RESTClientLib.Factory in '..\..\Source\RESTClientLib.Factory.pas',
  RESTClientLib.Interfaces in '..\..\Source\RESTClientLib.Interfaces.pas',
  RESTClientLib.Mime in '..\..\Source\RESTClientLib.Mime.pas',
  RESTClientLib.Net.Mime in '..\..\Source\RESTClientLib.Net.Mime.pas',
  RESTClientLib in '..\..\Source\RESTClientLib.pas',
  RESTClientLib.Request.Indy in '..\..\Source\RESTClientLib.Request.Indy.pas',
  RESTClientLib.Request.NetHTTP in '..\..\Source\RESTClientLib.Request.NetHTTP.pas',
  RESTClientLib.Request.Synapse in '..\..\Source\RESTClientLib.Request.Synapse.pas',
  RESTClientLib.Response.Indy in '..\..\Source\RESTClientLib.Response.Indy.pas',
  RESTClientLib.Response.NetHTTP in '..\..\Source\RESTClientLib.Response.NetHTTP.pas',
  RESTClientLib.Response.Synapse in '..\..\Source\RESTClientLib.Response.Synapse.pas',
  RESTClientLib.Types in '..\..\Source\RESTClientLib.Types.pas',
  RESTClientLib.Utils in '..\..\Source\RESTClientLib.Utils.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
