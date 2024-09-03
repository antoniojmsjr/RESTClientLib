unit View.JSONReflectSerialize;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormJSONSerializeBase, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, RESTClientLib,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON;

type
  TfrmJSONReflectSerialize = class(TfrmFormJSONSerializeBase)
    mtUser: TFDMemTable;
    mtUserid: TIntegerField;
    mtUsername: TStringField;
    mtUserusername: TStringField;
    mtUseremail: TStringField;
    mtUserphone: TStringField;
    mtUserwebsite: TStringField;
    dsUser: TDataSource;
    mtAddress: TFDMemTable;
    mtAddressid: TIntegerField;
    mtAddressstreet: TStringField;
    mtAddresssuite: TStringField;
    mtAddresscity: TStringField;
    mtAddresszipcode: TStringField;
    mtAddressuserid: TIntegerField;
    dsAddress: TDataSource;
    mtGeo: TFDMemTable;
    mtGeoaddressid: TIntegerField;
    mtGeolat: TStringField;
    mtGeolng: TStringField;
    dsGeo: TDataSource;
    mtCompany: TFDMemTable;
    mtCompanyname: TStringField;
    mtCompanycatchPhrase: TStringField;
    mtCompanybs: TStringField;
    mtCompanyuserid: TIntegerField;
    dsCompany: TDataSource;
    lblResponseGETDataUser: TLabel;
    dbgResponseGETDataUser: TDBGrid;
    lblResponseGETDataAddress: TLabel;
    dbgResponseGETDataAddress: TDBGrid;
    lblResponseGETDataGeo: TLabel;
    dbgResponseGETDataGeo: TDBGrid;
    lblResponseGETDataCompany: TLabel;
    dbgResponseGETDataCompany: TDBGrid;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  Data.FireDACJSONReflect, System.JSON;

{$R *.dfm}

procedure TfrmJSONReflectSerialize.FormCreate(Sender: TObject);
begin
  inherited;

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

procedure TfrmJSONReflectSerialize.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmJSONReflectSerialize.ProcessResponse(pResponse: IResponse);
var
  lDataSets: TFDJSONDataSets;
  lJSONDataSets: TJSONObject;
begin
  inherited ProcessResponse(pResponse);

  if (pResponse.StatusCode <> 200) then
  begin
    ShowMessage(pResponse.Body.Content);
    Exit;
  end;

  mtUser.Close;
  mtUser.Open;
  mtAddress.Close;
  mtAddress.Open;
  mtGeo.Close;
  mtGeo.Open;
  mtCompany.Close;
  mtCompany.Open;

  lJSONDataSets := TJSONObject(pResponse.Body.AsJSON);
  lDataSets := TFDJSONDataSets.Create;
  try
    TFDJSONInterceptor.JSONObjectToDataSets(lJSONDataSets, lDataSets);

    mtUser.AppendData(TFDJSONDataSetsReader.GetListValueByName(lDataSets, 'Users'));
    mtAddress.AppendData(TFDJSONDataSetsReader.GetListValueByName(lDataSets, 'Address'));
    mtGeo.AppendData(TFDJSONDataSetsReader.GetListValueByName(lDataSets, 'Geo'));
    mtCompany.AppendData(TFDJSONDataSetsReader.GetListValueByName(lDataSets, 'Company'));

    mtUser.First;
  finally
    lJSONDataSets.Free;
    lDataSets.Free;
  end;
end;

end.
