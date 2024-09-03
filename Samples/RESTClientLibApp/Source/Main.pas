unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.CategoryButtons, System.Actions, Vcl.ActnList,
  Vcl.AppEvnts, Vcl.Grids, Vcl.ValEdit, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    pnlClient: TPanel;
    pnlClientHeader: TPanel;
    bvlClientHeader: TBevel;
    bvlMain: TBevel;
    pnlMenu: TPanel;
    bvlClientMenu: TBevel;
    pnlMenuHeader: TPanel;
    ctbMenu: TCategoryButtons;
    actMenu: TActionList;
    actRESTDebuggerBody: TAction;
    ApplicationEvents: TApplicationEvents;
    pnlApp: TPanel;
    lblAppGithub: TLinkLabel;
    lblAppName: TLinkLabel;
    actRESTDebuggerMultipartFormData: TAction;
    actBenchmarks: TAction;
    actDataSetSerialize: TAction;
    actJSONObjectSerialize: TAction;
    imgLogo: TImage;
    actHorseMultipartFormData: TAction;
    actHorseJSON: TAction;
    actHorseStream: TAction;
    actHorseCompression: TAction;
    actJSONReflectSerialize: TAction;
    pgcMain: TPageControl;
    tbsRESTDebuggerBody: TTabSheet;
    tbsRESTDebuggerMultipartFormData: TTabSheet;
    tbsBenchmarks: TTabSheet;
    tbsDataSetSerialize: TTabSheet;
    tbsJSONObjectSerialize: TTabSheet;
    tbsHorseMultipartFormData: TTabSheet;
    tbsHorseJSON: TTabSheet;
    tbsHorseStream: TTabSheet;
    tbsHorseCompression: TTabSheet;
    tbsJSONReflectSerialize: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure lblAppGithubLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure actRESTDebuggerBodyExecute(Sender: TObject);
    procedure actRESTDebuggerMultipartFormDataExecute(Sender: TObject);
    procedure actBenchmarksExecute(Sender: TObject);
    procedure actDataSetSerializeExecute(Sender: TObject);
    procedure actJSONObjectSerializeExecute(Sender: TObject);
    procedure actHorseMultipartFormDataExecute(Sender: TObject);
    procedure actHorseJSONExecute(Sender: TObject);
    procedure actHorseStreamExecute(Sender: TObject);
    procedure actHorseCompressionExecute(Sender: TObject);
    procedure actJSONReflectSerializeExecute(Sender: TObject);
  private
    { Private declarations }
    procedure MakeForms;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Types, ShellApi, RESTClientLib.Types, View.RESTDebugger, View.Benchmarks,
  View.DataSetSerialize, View.JSONObjectSerialize, View.Horse.MultipartFormData,
  View.Horse.JSON, View.Horse.Stream, View.Horse.Compression, View.JSONReflectSerialize;

{$R *.dfm}
{$I RESTClientLib.inc}

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

procedure TfrmMain.FormCreate(Sender: TObject);

begin
  Self.Caption := Format('RESTClientLib v%s', [RESTClientLibVersion]);
  lblAppName.Caption := Format('RESTClientLib v%s', [RESTClientLibVersion]);
  lblAppGithub.Caption := '<a href="https://github.com/antoniojmsjr/RESTClientLib">https://github.com/antoniojmsjr/RESTClientLib</a>';
  MakeForms;
end;

procedure TfrmMain.actBenchmarksExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsBenchmarks;
end;

procedure TfrmMain.actDataSetSerializeExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsDataSetSerialize;
end;

procedure TfrmMain.actHorseCompressionExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsHorseCompression;
end;

procedure TfrmMain.actHorseJSONExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsHorseJSON;
end;

procedure TfrmMain.actHorseMultipartFormDataExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsHorseMultipartFormData;
end;

procedure TfrmMain.actHorseStreamExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsHorseStream;
end;

procedure TfrmMain.actJSONObjectSerializeExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsJSONObjectSerialize;
end;

procedure TfrmMain.actJSONReflectSerializeExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsJSONReflectSerialize;
end;

procedure TfrmMain.actRESTDebuggerBodyExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsRESTDebuggerBody;
end;

procedure TfrmMain.actRESTDebuggerMultipartFormDataExecute(Sender: TObject);
begin
  pgcMain.ActivePage := tbsRESTDebuggerMultipartFormData;
end;

procedure TfrmMain.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  if E is ERESTClientLib then
    Application.MessageBox(PWideChar(E.ToString), PWideChar('RESTClientLib - E R R O R'), MB_OK + MB_ICONERROR)
  else
    Application.MessageBox(PWideChar(E.Message + ' - ' + E.QualifiedClassName), PWideChar('RESTClientLib - E R R O R'), MB_OK + MB_ICONERROR);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ctbMenu.Color := clWindow;
  pnlMenuHeader.Height := 90;
  pnlClientHeader.Height := 90;
end;

procedure TfrmMain.lblAppGithubLinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

procedure TfrmMain.MakeForms;
var
  lfrmViewRESTDebuggerBody: TfrmViewRESTDebugger;
  lfrmViewRESTDebuggerMultipartFormData: TfrmViewRESTDebugger;
  lfrmViewBenchmarks: TfrmViewBenchmarks;
  lfrmViewDataSetSerialize: TfrmViewDataSetSerialize;
  lfrmViewJSONObjectSerialize: TfrmViewJSONObjectSerialize;
  lfrmViewHorseMultipartFormData: TfrmViewHorseMultipartFormData;
  lfrmViewHorseJSON: TfrmViewHorseJSON;
  lfrmViewHorseStream: TfrmViewHorseStream;
  lfrmViewHorseCompression: TfrmViewHorseCompression;
  lfrmJSONReflectSerialize: TfrmJSONReflectSerialize;
begin
  OcultarSheets(pgcMain);

  lfrmViewRESTDebuggerBody := TfrmViewRESTDebugger.Create(nil);
  lfrmViewRESTDebuggerBody.Parent := tbsRESTDebuggerBody;
  lfrmViewRESTDebuggerBody.pgcRequestBody.ActivePage := lfrmViewRESTDebuggerBody.tbsBody;
  lfrmViewRESTDebuggerBody.Show;

  lfrmViewRESTDebuggerMultipartFormData := TfrmViewRESTDebugger.Create(nil);
  lfrmViewRESTDebuggerMultipartFormData.Parent := tbsRESTDebuggerMultipartFormData;
  lfrmViewRESTDebuggerMultipartFormData.pgcRequestBody.ActivePage := lfrmViewRESTDebuggerMultipartFormData.tbsMultipartFormData;
  lfrmViewRESTDebuggerMultipartFormData.Show;

  lfrmViewBenchmarks := TfrmViewBenchmarks.Create(nil);
  lfrmViewBenchmarks.Parent := tbsBenchmarks;
  lfrmViewBenchmarks.Show;

  lfrmViewDataSetSerialize := TfrmViewDataSetSerialize.Create(nil);
  lfrmViewDataSetSerialize.Parent := tbsDataSetSerialize;
  lfrmViewDataSetSerialize.Show;

  lfrmViewJSONObjectSerialize := TfrmViewJSONObjectSerialize.Create(nil);
  lfrmViewJSONObjectSerialize.Parent := tbsJSONObjectSerialize;
  lfrmViewJSONObjectSerialize.Show;

  lfrmJSONReflectSerialize := TfrmJSONReflectSerialize.Create(nil);
  lfrmJSONReflectSerialize.Parent := tbsJSONReflectSerialize;
  lfrmJSONReflectSerialize.Show;

  lfrmViewHorseMultipartFormData := TfrmViewHorseMultipartFormData.Create(nil);
  lfrmViewHorseMultipartFormData.Parent := tbsHorseMultipartFormData;
  lfrmViewHorseMultipartFormData.Show;

  lfrmViewHorseJSON := TfrmViewHorseJSON.Create(nil);
  lfrmViewHorseJSON.Parent := tbsHorseJSON;
  lfrmViewHorseJSON.Show;

  lfrmViewHorseStream := TfrmViewHorseStream.Create(nil);
  lfrmViewHorseStream.Parent := tbsHorseStream;
  lfrmViewHorseStream.Show;

  lfrmViewHorseCompression := TfrmViewHorseCompression.Create(nil);
  lfrmViewHorseCompression.Parent := tbsHorseCompression;
  lfrmViewHorseCompression.Show;

  actRESTDebuggerBody.Execute;
end;

end.
