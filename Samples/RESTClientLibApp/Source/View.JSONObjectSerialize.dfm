inherited frmViewJSONObjectSerialize: TfrmViewJSONObjectSerialize
  Caption = 'frmViewJSONObjectSerialize'
  ClientHeight = 800
  ExplicitHeight = 800
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbxGET: TGroupBox
    Height = 716
    ExplicitHeight = 716
    inherited gbxRequestGETURL: TGroupBox
      inherited edtRequestGETURL: TButtonedEdit
        Left = 3
        Text = 'https://jsonplaceholder.typicode.com'
        ExplicitLeft = 3
      end
      inherited edtRequestGETResource: TButtonedEdit
        Text = 'users'
      end
    end
    inherited gbxResponseGET: TGroupBox
      inherited mmoResponseGETBody: TMemo
        Lines.Strings = ()
      end
    end
    inherited gbxResponseGETData: TGroupBox
      Height = 448
      ExplicitHeight = 448
      object lblResponseGETDataUser: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 1249
        Height = 15
        Align = alTop
        AutoSize = False
        Caption = '   User'
        Color = cl3DLight
        ParentColor = False
        Transparent = False
        ExplicitLeft = 10
        ExplicitTop = 26
        ExplicitWidth = 580
      end
      object lblResponseGETDataAddress: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 145
        Width = 1249
        Height = 15
        Align = alTop
        AutoSize = False
        Caption = '   Address'
        Color = cl3DLight
        ParentColor = False
        Transparent = False
        ExplicitLeft = 7
        ExplicitWidth = 580
      end
      object lblResponseGETDataGeo: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 221
        Width = 1249
        Height = 15
        Align = alTop
        AutoSize = False
        Caption = '   Geo'
        Color = cl3DLight
        ParentColor = False
        Transparent = False
        ExplicitLeft = 7
        ExplicitTop = 224
        ExplicitWidth = 580
      end
      object lblResponseGETDataCompany: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 297
        Width = 1249
        Height = 15
        Align = alTop
        AutoSize = False
        Caption = '   Company'
        Color = cl3DLight
        ParentColor = False
        Transparent = False
        ExplicitLeft = 7
        ExplicitTop = 294
        ExplicitWidth = 580
      end
      object dbgResponseGETDataUser: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 39
        Width = 1249
        Height = 100
        Align = alTop
        BorderStyle = bsNone
        DataSource = dsUser
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'phone'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'username'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'website'
            Width = 150
            Visible = True
          end>
      end
      object dbgResponseGETDataAddress: TDBGrid
        Left = 2
        Top = 163
        Width = 1255
        Height = 55
        Align = alTop
        BorderStyle = bsNone
        DataSource = dsAddress
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'street'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'suite'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'city'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'zipcode'
            Width = 100
            Visible = True
          end>
      end
      object dbgResponseGETDataGeo: TDBGrid
        Left = 2
        Top = 239
        Width = 1255
        Height = 55
        Align = alTop
        BorderStyle = bsNone
        DataSource = dsGeo
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'lat'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'lng'
            Width = 100
            Visible = True
          end>
      end
      object dbgResponseGETDataCompany: TDBGrid
        Left = 2
        Top = 315
        Width = 1255
        Height = 55
        Align = alTop
        BorderStyle = bsNone
        DataSource = dsCompany
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'name'
            Width = 185
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'catchPhrase'
            Width = 185
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bs'
            Width = 185
            Visible = True
          end>
      end
    end
  end
  object mtUser: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 109
    Top = 373
    object mtUserid: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'id'
    end
    object mtUsername: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Size = 100
    end
    object mtUserusername: TStringField
      DisplayLabel = 'User'
      FieldName = 'username'
      Size = 100
    end
    object mtUseremail: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'email'
      Size = 150
    end
    object mtUserphone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'phone'
      Size = 50
    end
    object mtUserwebsite: TStringField
      DisplayLabel = 'Site'
      FieldName = 'website'
      Size = 150
    end
  end
  object dsUser: TDataSource
    AutoEdit = False
    DataSet = mtUser
    Left = 157
    Top = 373
  end
  object mtAddress: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 107
    Top = 425
    object mtAddressid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
    end
    object mtAddressstreet: TStringField
      DisplayLabel = 'Street'
      FieldName = 'street'
      Size = 100
    end
    object mtAddresssuite: TStringField
      DisplayLabel = 'Suite'
      FieldName = 'suite'
      Size = 100
    end
    object mtAddresscity: TStringField
      DisplayLabel = 'City'
      FieldName = 'city'
      Size = 100
    end
    object mtAddresszipcode: TStringField
      DisplayLabel = 'Zipcode'
      FieldName = 'zipcode'
      Size = 15
    end
    object mtAddressuserid: TIntegerField
      FieldName = 'userid'
    end
  end
  object dsAddress: TDataSource
    AutoEdit = False
    DataSet = mtAddress
    Left = 152
    Top = 425
  end
  object mtGeo: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 104
    Top = 473
    object mtGeoaddressid: TIntegerField
      FieldName = 'addressid'
    end
    object mtGeolat: TStringField
      FieldName = 'lat'
    end
    object mtGeolng: TStringField
      FieldName = 'lng'
    end
  end
  object dsGeo: TDataSource
    AutoEdit = False
    DataSet = mtGeo
    Left = 152
    Top = 473
  end
  object mtCompany: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 104
    Top = 529
    object mtCompanyname: TStringField
      FieldName = 'name'
      Size = 100
    end
    object mtCompanycatchPhrase: TStringField
      FieldName = 'catchPhrase'
      Size = 100
    end
    object mtCompanybs: TStringField
      FieldName = 'bs'
      Size = 300
    end
    object mtCompanyuserid: TIntegerField
      FieldName = 'userid'
    end
  end
  object dsCompany: TDataSource
    AutoEdit = False
    DataSet = mtCompany
    Left = 152
    Top = 529
  end
end