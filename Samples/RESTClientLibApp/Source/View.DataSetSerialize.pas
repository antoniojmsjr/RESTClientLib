unit View.DataSetSerialize;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FormJSONSerializeBase, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Samples.Spin, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DataSet.Serialize, RESTClientLib;

type
  TfrmViewDataSetSerialize = class(TfrmFormJSONSerializeBase)
    dbgResponseGETDataUser: TDBGrid;
    lblResponseGETDataUser: TLabel;
    dsUser: TDataSource;
    mtUser: TFDMemTable;
    mtUserid: TIntegerField;
    mtUsername: TStringField;
    mtUserusername: TStringField;
    mtUseremail: TStringField;
    mtUserphone: TStringField;
    mtUserwebsite: TStringField;
    gbxLibraryDatasetSerialize: TGroupBox;
    lbLibraryDatasetSerializeSite: TLinkLabel;
    lblLibraryDatasetSerialize: TLabel;
    dsAddress: TDataSource;
    mtAddress: TFDMemTable;
    mtAddressstreet: TStringField;
    mtAddresssuite: TStringField;
    mtAddresscity: TStringField;
    mtAddresszipcode: TStringField;
    dbgResponseGETDataAddress: TDBGrid;
    lblResponseGETDataAddress: TLabel;
    mtAddressuserid: TIntegerField;
    mtAddressid: TIntegerField;
    lblResponseGETDataGeo: TLabel;
    mtGeo: TFDMemTable;
    dsGeo: TDataSource;
    mtGeoaddressid: TIntegerField;
    dbgResponseGETDataGeo: TDBGrid;
    mtCompany: TFDMemTable;
    dsCompany: TDataSource;
    mtCompanyname: TStringField;
    mtCompanycatchPhrase: TStringField;
    mtCompanybs: TStringField;
    mtCompanyuserid: TIntegerField;
    lblResponseGETDataCompany: TLabel;
    dbgResponseGETDataCompany: TDBGrid;
    mtGeolat: TStringField;
    mtGeolng: TStringField;
    procedure lbLibraryDatasetSerializeSiteLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure ProcessResponse(pResponse: IResponse); override;
  public
    { Public declarations }
  end;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

{ TfrmViewDataSetSerialize }

procedure TfrmViewDataSetSerialize.FormCreate(Sender: TObject);
begin
  inherited;
  lbLibraryDatasetSerializeSite.Caption := '<a href="https://github.com/viniciussanchez/dataset-serialize">https://github.com/viniciussanchez/dataset-serialize</a>';

  mtUser.Open;
  mtAddress.Open;
  mtGeo.Open;
  mtCompany.Open;

  mtAddress.MasterSource := dsUser;
  mtAddress.MasterFields := mtUserid.FieldName;
  mtAddress.DetailFields := mtAddressuserid.FieldName;
  mtAddress.IndexFieldNames := mtAddressuserid.FieldName;

  mtGeo.MasterSource := dsAddress;
  mtGeo.MasterFields := mtAddressid.FieldName;
  mtGeo.DetailFields := mtGeoaddressid.FieldName;
  mtGeo.IndexFieldNames := mtGeoaddressid.FieldName;

  mtCompany.MasterSource := dsUser;
  mtCompany.MasterFields := mtUserid.FieldName;
  mtCompany.DetailFields := mtCompanyuserid.FieldName;
  mtCompany.IndexFieldNames := mtCompanyuserid.FieldName;
end;

procedure TfrmViewDataSetSerialize.lbLibraryDatasetSerializeSiteLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

procedure TfrmViewDataSetSerialize.ProcessResponse(pResponse: IResponse);
begin
  inherited ProcessResponse(pResponse);

  if (pResponse.StatusCode <> 200) then
  begin
    ShowMessage(pResponse.Body.Content);
    Exit;
  end;

  mtUser.Close;
  mtAddress.Close;
  mtGeo.Close;
  mtCompany.Close;

  mtUser.LoadFromJSON(pResponse.Body.Content);
end;

end.
