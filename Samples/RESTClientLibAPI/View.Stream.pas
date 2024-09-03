unit View.Stream;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormRequestBase,
  Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Horse,
  Vcl.Imaging.jpeg;

type
  TfrmViewStream = class(TfrmRequestBase)
    gbxRequest: TGroupBox;
    gbxResponse: TGroupBox;
    imgRequest: TImage;
    imgResponse: TImage;
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
  Main;

{$R *.dfm}

{ TfrmViewStream }

procedure TfrmViewStream.AfterConstruction;
begin
  inherited;
  THorse.Post('/stream', ProcessRequest);
end;

procedure TfrmViewStream.ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse);
var
  lImageRequest: TBytesStream;
  lImageResponse: TMemoryStream;
begin
  TThread.Synchronize(nil, procedure
  begin
    frmMain.PageControl.ActivePage := frmMain.tbsStream;
  end);

  inherited ProcessRequest(pRequest, pResponse);

  lImageRequest := TBytesStream.Create(pRequest.RawWebRequest.RawContent);
  try
    imgRequest.Picture.Assign(nil);
    {$IF CompilerVersion >= 33}
    imgRequest.Picture.LoadFromStream(lImageRequest);
    {$ELSE}
    imgRequest.Picture.Graphic.LoadFromStream(lImageRequest);
    {$ENDIF}
  finally
    lImageRequest.Free;
  end;

  lImageResponse := TMemoryStream.Create;
  {$IF CompilerVersion >= 33}
  imgResponse.Picture.SaveToStream(lImageResponse);
  {$ELSE}
  imgRequest.Picture.Graphic.LoadFromStream(lImageRequest);
  {$ENDIF}
  try
    pResponse.SendFile(lImageResponse, 'Logo.png').Status(200);
  finally
    lImageResponse.Free;
  end;
end;

end.
