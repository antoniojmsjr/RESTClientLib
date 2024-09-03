unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls, FormRequestBase,
  View.MultipartFormData, View.JSON, View.Stream, View.Compression,
  IdBaseComponent, IdZLibCompressorBase, IdCompressorZLib, View.JSONReflection;

type
  TfrmMain = class(TForm)
    pnlClient: TPanel;
    bvlClientHeader: TBevel;
    pnlClientHeader: TPanel;
    imgLogo: TImage;
    imgLogoApi: TImage;
    PageControl: TPageControl;
    tbsMultipartFormData: TTabSheet;
    tbsJSON: TTabSheet;
    tbsJSONReflect: TTabSheet;
    pnlHeader: TPanel;
    pnlHeaderRight: TPanel;
    shpHeader: TShape;
    pnlHeaderClient: TPanel;
    lblHorseTitle: TLabel;
    lblHorseJhonsonTitle: TLabel;
    lblHorseMiddlewaresTitle: TLabel;
    lblHorseGithub: TLinkLabel;
    Label1: TLabel;
    lblHorseGithubJhonson: TLinkLabel;
    frmViewMultipartFormData: TfrmViewMultipartFormData;
    frmViewJSON: TfrmViewJSON;
    tbsStream: TTabSheet;
    tbsCompression: TTabSheet;
    frmViewStream: TfrmViewStream;
    frmViewCompression: TfrmViewCompression;
    frmViewJSONReflection: TfrmViewJSONReflection;
    lblHorseCompressionTitle: TLabel;
    lblHorseGithubCompression: TLinkLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblHorseGithubLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure lblHorseGithubJhonsonLinkClick(Sender: TObject;
      const Link: string; LinkType: TSysLinkType);
    procedure lblHorseGithubCompressionLinkClick(Sender: TObject;
      const Link: string; LinkType: TSysLinkType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Types, Winapi.ShellAPI, Horse, Horse.Jhonson, Horse.Compression;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  lRect: TRectF;
begin
  frmMain.PageControl.ActivePage := frmMain.tbsMultipartFormData;

  lRect := TRectF.Create(Screen.WorkAreaRect.TopLeft, Screen.WorkAreaRect.Width,
                         Screen.WorkAreaRect.Height);
  SetBounds(Round(lRect.Left + (lRect.Width - Width) / 2),
            0,
            Width,
            Screen.WorkAreaRect.Height);

  lblHorseGithub.Caption := '<a href="https://github.com/HashLoad/horse">https://github.com/HashLoad/horse</a>';
  lblHorseGithubJhonson.Caption := '<a href="https://github.com/HashLoad/jhonson">https://github.com/HashLoad/jhonson</a>';
  lblHorseGithubCompression.Caption := '<a href="https://github.com/HashLoad/horse-compression">https://github.com/HashLoad/horse-compression</a>';

  THorse
    .Use(Compression()) // Must come before Jhonson middleware
    .Use(Jhonson);

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pnlClientHeader.Height := 90;
  imgLogo.Width := 500;
end;

procedure TfrmMain.lblHorseGithubCompressionLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

procedure TfrmMain.lblHorseGithubJhonsonLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

procedure TfrmMain.lblHorseGithubLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

end.
