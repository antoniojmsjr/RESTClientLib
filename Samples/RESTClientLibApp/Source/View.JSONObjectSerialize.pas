unit View.JSONObjectSerialize;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormJSONSerializeBase, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, System.JSON,
  RESTClientLib;

type
  TfrmViewJSONObjectSerialize = class(TfrmFormJSONSerializeBase)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ParseUser(const pJSONValue: TJSONValue);
    procedure ParseAddress(const pJSONValue: TJSONValue; const pUserID: Integer);
    procedure ParseGeo(const pJSONValue: TJSONValue; const pAddressID: Integer);
    procedure ParseCompany(const pJSONValue: TJSONValue; const pUserID: Integer);
  protected
    { protected declarations }
    procedure ProcessResponse(pResponse: IResponse); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmViewJSONObjectSerialize.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewJSONObjectSerialize.FormCreate(Sender: TObject);
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

procedure TfrmViewJSONObjectSerialize.ParseUser(const pJSONValue: TJSONValue);
var
  lUser: TJSONObject;
begin
  lUser := pJSONValue as TJSONObject;

  mtUser.Append;
  mtUserid.AsInteger := lUser.GetValue<Integer>('id');
  mtUsername.AsString := lUser.GetValue<string>('name');
  mtUserusername.AsString := lUser.GetValue<string>('username');
  mtUseremail.AsString := lUser.GetValue<string>('email');
  mtUserphone.AsString := lUser.GetValue<string>('phone');
  mtUserwebsite.AsString := lUser.GetValue<string>('website');
  mtUser.Post;

  ParseAddress(pJSONValue, mtUserid.AsInteger);
  ParseCompany(pJSONValue, mtUserid.AsInteger);
end;

procedure TfrmViewJSONObjectSerialize.ParseAddress(const pJSONValue: TJSONValue; const pUserID: Integer);
var
  lAddress: TJSONObject;
begin
  lAddress := pJSONValue.GetValue<TJSONObject>('address');

  mtAddress.Append;
  mtAddressstreet.AsString := lAddress.GetValue<string>('street');
  mtAddresssuite.AsString := lAddress.GetValue<string>('suite');
  mtAddresscity.AsString := lAddress.GetValue<string>('city');
  mtAddresszipcode.AsString := lAddress.GetValue<string>('zipcode');
  mtAddressuserid.AsInteger := pUserID;
  mtAddress.Post;

  ParseGeo(pJSONValue, mtAddressid.AsInteger);
end;

procedure TfrmViewJSONObjectSerialize.ParseGeo(const pJSONValue: TJSONValue; const pAddressID: Integer);
var
  lAddress: TJSONObject;
  lGeo: TJSONObject;
begin
  lAddress := pJSONValue.GetValue<TJSONObject>('address');
  lGeo := lAddress.GetValue<TJSONObject>('geo');

  mtGeo.Append;
  mtGeolat.AsString := lGeo.GetValue<string>('lat');
  mtGeolng.AsString := lGeo.GetValue<string>('lng');
  mtGeoaddressid.AsInteger := pAddressID;
  mtGeo.Post;
end;

procedure TfrmViewJSONObjectSerialize.ParseCompany(const pJSONValue: TJSONValue; const pUserID: Integer);
var
  lCompany: TJSONObject;
begin
  lCompany := pJSONValue.GetValue<TJSONObject>('company');

  mtCompany.Append;
  mtCompanyname.AsString := lCompany.GetValue<string>('name');
  mtCompanycatchPhrase.AsString := lCompany.GetValue<string>('catchPhrase');
  mtCompanybs.AsString := lCompany.GetValue<string>('bs');
  mtCompany.Post;
end;

procedure TfrmViewJSONObjectSerialize.ProcessResponse(pResponse: IResponse);
var
  lJSONUsers: TJSONArray;
  lArrayElement: TJSonValue;
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

  lJSONUsers := pResponse.Body.AsJSON as TJSONArray;
  try
    for lArrayElement in lJSONUsers do
      ParseUser(lArrayElement);
  finally
    lJSONUsers.Free;
  end;

  mtUser.First;
end;

end.
