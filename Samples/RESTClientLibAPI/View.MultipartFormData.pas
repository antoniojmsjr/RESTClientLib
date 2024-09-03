unit View.MultipartFormData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormRequestBase,
  Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls, Vcl.StdCtrls, Horse;

type
  TfrmViewMultipartFormData = class(TfrmRequestBase)
    gbxStream: TGroupBox;
    imgStream: TImage;
    gbxFields: TGroupBox;
    vleFields: TValueListEditor;
    gbxFiles: TGroupBox;
    lblFile: TLabel;
  private
    { private declarations }
  protected
    { protected declarations }
    procedure ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse); override;
  public
    { public declarations }
    procedure AfterConstruction; override;
 end;

implementation

uses
  System.Generics.Collections, Main;

{$R *.dfm}

{ TfrmViewMultipartFormData }

procedure TfrmViewMultipartFormData.AfterConstruction;
begin
  inherited;
  THorse.Post('/form-data', ProcessRequest);
end;

procedure TfrmViewMultipartFormData.ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse);
var
  lField: TPair<string, string>;
begin
  TThread.Synchronize(nil, procedure
  begin
    frmMain.PageControl.ActivePage := frmMain.tbsMultipartFormData;
  end);

  inherited ProcessRequest(pRequest, pResponse);

  // Stream
  if (pRequest.ContentFields.Field('image').AsStream <> nil) then
  begin
    imgStream.Picture.Assign(nil);
    {$IF CompilerVersion >= 33}
    imgStream.Picture.LoadFromStream(pRequest.ContentFields.Field('image').AsStream);
    {$ELSE}
    imgStream.Picture.Graphic.LoadFromStream(pRequest.ContentFields.Field('image').AsStream);
    {$ENDIF}
  end;

  // Fields
  vleFields.Strings.Clear;
  for lField in pRequest.ContentFields.Dictionary do
    vleFields.InsertRow(lField.Key, lField.Value, True);

end;

end.
