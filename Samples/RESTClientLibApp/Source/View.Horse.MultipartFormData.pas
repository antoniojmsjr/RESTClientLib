unit View.Horse.MultipartFormData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, FormHorseBase;

const
  cFileLogoApp = 'LogoApp.png';

type
  TMultipartFormDataKind = (tmStream, tmField, tmFile);

  TfrmViewHorseMultipartFormData = class(TfrmFormHorseBase)
    mmoRequestBody: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMultipartFormDataItens: TStrings;
    function GetResourceStream(const pResourceName: string): TStream;
    procedure SaveResources;
    procedure AddMultipartFormData;
  protected
    { Protected declarations }
    procedure PrepareExecute; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmViewHorseMultipartFormData.FormCreate(Sender: TObject);
begin
  inherited;
  FMultipartFormDataItens := TStringList.Create;

  cbxRequestMethod.ItemIndex := cbxRequestMethod.Items.IndexOf('POST');
  SaveResources;
  AddMultipartFormData;
end;

procedure TfrmViewHorseMultipartFormData.FormDestroy(Sender: TObject);
begin
  FMultipartFormDataItens.Free;
  inherited;
end;

function TfrmViewHorseMultipartFormData.GetResourceStream(const pResourceName: string): TStream;
var
  lResStream: TResourceStream;
begin
  lResStream := TResourceStream.Create(HInstance, pResourceName, RT_RCDATA);
  try
    lResStream.Position := 0;
    Result := lResStream;
  except
    lResStream.Free;
    raise;
  end;
end;

procedure TfrmViewHorseMultipartFormData.PrepareExecute;
var
  I: Integer;
  lKind: TMultipartFormDataKind;
  lFileStream: TFileStream;

begin
  FRESTClientLib.MultipartFormData.Reset;

  for I := 0 to Pred(FMultipartFormDataItens.Count) do
  begin
    lKind := TMultipartFormDataKind(FMultipartFormDataItens.Objects[I]);

    case lKind of
      tmStream:
      begin
        lFileStream := TFileStream.Create(mmoRequestBody.Lines.ValueFromIndex[I], fmOpenRead);
        FRESTClientLib.MultipartFormData.Field(mmoRequestBody.Lines.Names[I], lFileStream);
      end;
      tmField: FRESTClientLib.MultipartFormData.Field(mmoRequestBody.Lines.Names[I], mmoRequestBody.Lines.ValueFromIndex[I]);
      tmFile: ;
    end;
  end;
end;

procedure TfrmViewHorseMultipartFormData.SaveResources;
var
  lPath: string;
  lPathFile: string;
  lFileStream: TFileStream;
begin
  lPath := IncludeTrailingPathDelimiter(GetCurrentDir) + 'Resources\';
  if not DirectoryExists((lPath)) then
    ForceDirectories((lPath));

  // Save Resource LogoApp
  lPathFile := (lPath + cFileLogoApp);
  if not FileExists(lPathFile) then
  begin
    lFileStream := TFileStream.Create(lPathFile, fmCreate);
    try
      lFileStream.CopyFrom(GetResourceStream('LogoApp'), 0);
    finally
      FreeAndNil(lFileStream);
    end;
  end;
end;

procedure TfrmViewHorseMultipartFormData.AddMultipartFormData;
var
  lPath: string;
  lPathFile: string;
begin
  lPath := IncludeTrailingPathDelimiter(GetCurrentDir) + 'Resources\';

  lPathFile := (lPath + cFileLogoApp);
  FMultipartFormDataItens.AddObject(Format('image=%s', [lPathFile]), TObject(TMultipartFormDataKind.tmStream));
  mmoRequestBody.Lines.Add(Format('image=%s', [lPathFile]));
  FMultipartFormDataItens.AddObject(Format('field1=%s', ['*** Field 01']), TObject(TMultipartFormDataKind.tmField));
  mmoRequestBody.Lines.Add(Format('field1=%s', ['*** Field 01']));
  FMultipartFormDataItens.AddObject(Format('field2=%s', ['*** Field 02']), TObject(TMultipartFormDataKind.tmField));
  mmoRequestBody.Lines.Add(Format('field2=%s', ['*** Field 02']));
  FMultipartFormDataItens.AddObject(Format('field3=%s', ['*** Field 03']), TObject(TMultipartFormDataKind.tmField));
  mmoRequestBody.Lines.Add(Format('field3=%s', ['*** Field 03']));
  FMultipartFormDataItens.AddObject(Format('field4=%s', ['*** Field 04']), TObject(TMultipartFormDataKind.tmField));
  mmoRequestBody.Lines.Add(Format('field4=%s', ['*** Field 04']));
  FMultipartFormDataItens.AddObject(Format('field5=%s', ['*** Field 05']), TObject(TMultipartFormDataKind.tmField));
  mmoRequestBody.Lines.Add(Format('field5=%s', ['*** Field 05']));
end;

end.
