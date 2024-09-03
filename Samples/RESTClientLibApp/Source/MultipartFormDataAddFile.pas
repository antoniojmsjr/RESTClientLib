unit MultipartFormDataAddFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TOnAdd = reference to procedure (const Field: string; const FilePath: string);

  TfrmMultipartFormDataAddFile = class(TForm)
    pnlHeader: TPanel;
    lblField: TLabel;
    edtField: TEdit;
    lblFile: TLabel;
    edtFile: TEdit;
    btnAdd: TSpeedButton;
    OpenDialog: TOpenDialog;
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtFieldExit(Sender: TObject);
    procedure edtFieldKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FOnAdd: TOnAdd;
    procedure SetOnAdd(const Value: TOnAdd);
    procedure DoAdd(const pField: string; const pFilePath: string);
  public
    { Public declarations }
    property OnAdd: TOnAdd read FOnAdd write SetOnAdd;
  end;

implementation

{$R *.dfm}

procedure TfrmMultipartFormDataAddFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMultipartFormDataAddFile.btnAddClick(Sender: TObject);
begin
  if not OpenDialog.Execute then
    Exit;

  edtFile.Text := OpenDialog.FileName;
  if ((Trim(edtField.Text) = EmptyStr) or
     (Trim(edtFile.Text) = EmptyStr)) then
    Exit;

  DoAdd(edtField.Text, edtFile.Text);
  Self.Close;
end;

procedure TfrmMultipartFormDataAddFile.DoAdd(const pField: string; const pFilePath: string);
begin
  if Assigned(FOnAdd) then
    FOnAdd(pField, pFilePath);
end;

procedure TfrmMultipartFormDataAddFile.edtFieldExit(Sender: TObject);
begin
  btnAdd.Enabled := (Trim(edtField.Text) <> EmptyStr);
end;

procedure TfrmMultipartFormDataAddFile.edtFieldKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = ' ') then
    Key := #0;
end;

procedure TfrmMultipartFormDataAddFile.SetOnAdd(const Value: TOnAdd);
begin
  FOnAdd := Value;
end;

end.
