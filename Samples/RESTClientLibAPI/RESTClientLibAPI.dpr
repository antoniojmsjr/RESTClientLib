program RESTClientLibAPI;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  FormRequestBase in 'FormRequestBase.pas' {frmRequestBase: TFrame},
  View.MultipartFormData in 'View.MultipartFormData.pas' {frmViewMultipartFormData: TFrame},
  View.JSON in 'View.JSON.pas' {frmViewJSON: TFrame},
  View.Stream in 'View.Stream.pas' {frmViewStream: TFrame},
  View.Compression in 'View.Compression.pas' {frmViewCompression: TFrame},
  View.JSONReflection in 'View.JSONReflection.pas' {frmViewJSONReflection: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
