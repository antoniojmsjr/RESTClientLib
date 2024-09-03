unit View.Horse.Stream;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormHorseBase, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.jpeg,
  RESTClientLib;

type
  TfrmViewHorseStream = class(TfrmFormHorseBase)
    imgResponse: TImage;
    imgRequest: TImage;
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

{$R *.dfm}

{ TForm1 }

procedure TfrmViewHorseStream.FormCreate(Sender: TObject);
begin
  inherited;
  cbxRequestMethod.ItemIndex := cbxRequestMethod.Items.IndexOf('POST');
end;

procedure TfrmViewHorseStream.PrepareExecute;
var
  lImageStream: TMemoryStream;
begin
  lImageStream := TMemoryStream.Create;
  {$IF CompilerVersion >= 33}
  imgRequest.Picture.SaveToStream(lImageStream);
  {$ELSE}
  imgRequest.Picture.Graphic.SaveToStream(lImageStream);
  {$ENDIF}

  FRESTClientLib.Body.Reset;
  FRESTClientLib.Body.Content(lImageStream);
end;

procedure TfrmViewHorseStream.ProcessResponse(pResponse: IResponse);
var
  lImageStream: TStream;
begin
  inherited ProcessResponse(pResponse);

  imgResponse.Picture.Assign(nil);
  lImageStream := pResponse.Body.AsStream;
  try
    {$IF CompilerVersion >= 33}
    imgResponse.Picture.LoadFromStream(lImageStream);
    {$ELSE}
    imgRequest.Picture.Graphic.SaveToStream(lImageStream);
    {$ENDIF}
  finally
    lImageStream.Free;
  end;
end;

end.
