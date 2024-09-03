unit View.JSONReflection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormRequestBase,
  Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Horse, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin;

type
  TfrmViewJSONReflection = class(TfrmRequestBase)
    gbxJSONReflectionResponse: TGroupBox;
    mmoJSONReflectionResponse: TMemo;
    mtUser: TFDMemTable;
    mtUserid: TIntegerField;
    mtUsername: TStringField;
    mtUserusername: TStringField;
    mtUseremail: TStringField;
    mtUserphone: TStringField;
    mtUserwebsite: TStringField;
    mtAddress: TFDMemTable;
    mtAddressid: TIntegerField;
    mtAddressstreet: TStringField;
    mtAddresssuite: TStringField;
    mtAddresscity: TStringField;
    mtAddresszipcode: TStringField;
    mtAddressuserid: TIntegerField;
    mtGeo: TFDMemTable;
    mtGeoaddressid: TIntegerField;
    mtGeolat: TStringField;
    mtGeolng: TStringField;
    mtCompany: TFDMemTable;
    mtCompanyname: TStringField;
    mtCompanycatchPhrase: TStringField;
    mtCompanybs: TStringField;
    mtCompanyuserid: TIntegerField;
    dsUser: TDataSource;
    dsAddress: TDataSource;
    dsGeo: TDataSource;
    dsCompany: TDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
  private
    { Private declarations }
    procedure ParseUser(const pJSONValue: TJSONValue);
    procedure ParseAddress(const pJSONValue: TJSONValue; const pUserID: Integer);
    procedure ParseGeo(const pJSONValue: TJSONValue; const pAddressID: Integer);
    procedure ParseCompany(const pJSONValue: TJSONValue; const pUserID: Integer);
    procedure ParseDataSet;
  protected
    { protected declarations }
    procedure ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse); override;
  public
    { Public declarations }
    procedure AfterConstruction; override;
  end;

implementation

uses
  Main, Data.FireDACJSONReflect;

{$R *.dfm}

{ TfrmViewJSONReflection }

procedure TfrmViewJSONReflection.AfterConstruction;
begin
  inherited;
  THorse.Get('/json_reflect', ProcessRequest);

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

  ParseDataSet;
end;

procedure TfrmViewJSONReflection.ParseAddress(const pJSONValue: TJSONValue; const pUserID: Integer);
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

procedure TfrmViewJSONReflection.ParseCompany(const pJSONValue: TJSONValue; const pUserID: Integer);
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

procedure TfrmViewJSONReflection.ParseGeo(const pJSONValue: TJSONValue; const pAddressID: Integer);
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

procedure TfrmViewJSONReflection.ParseUser(const pJSONValue: TJSONValue);
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

procedure TfrmViewJSONReflection.ParseDataSet;
var
  lJSONUsers: TJSONArray;
  lArrayElement: TJSonValue;
begin
  lJSONUsers := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mmoJSONReflectionResponse.Text), 0) as TJSONArray;

  try
    for lArrayElement in lJSONUsers do
      ParseUser(lArrayElement);
  finally
    lJSONUsers.Free;
  end;

  mtUser.First;
end;

procedure TfrmViewJSONReflection.ProcessRequest(pRequest: THorseRequest; pResponse: THorseResponse);
var
  lFDJSONDataSets: TFDJSONDataSets;
  lJSONObjectSend: TJSONObject;
begin
  TThread.Synchronize(nil, procedure
  begin
    frmMain.PageControl.ActivePage := frmMain.tbsJSONReflect;
  end);

  inherited ProcessRequest(pRequest, pResponse);

  lFDJSONDataSets := TFDJSONDataSets.Create;
  try
    TFDJSONDataSetsWriter.ListAdd(lFDJSONDataSets, 'Users', mtUser);
    TFDJSONDataSetsWriter.ListAdd(lFDJSONDataSets, 'Address', mtAddress);
    TFDJSONDataSetsWriter.ListAdd(lFDJSONDataSets, 'Geo', mtGeo);
    TFDJSONDataSetsWriter.ListAdd(lFDJSONDataSets, 'Company', mtCompany);

    lJSONObjectSend := TJSONObject.Create;
    TFDJSONInterceptor.DataSetsToJSONObject(lFDJSONDataSets, lJSONObjectSend);
    pResponse.Send<TJSONObject>(lJSONObjectSend).Status(200);
  finally
    lFDJSONDataSets.Free;
  end;
end;

end.
