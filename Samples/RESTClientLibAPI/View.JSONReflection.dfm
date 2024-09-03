inherited frmViewJSONReflection: TfrmViewJSONReflection
  Width = 664
  Height = 428
  ExplicitWidth = 664
  ExplicitHeight = 428
  inherited gbxRequestURL: TGroupBox
    Width = 664
    ExplicitWidth = 664
    inherited edtRequestURL: TEdit
      Width = 650
      ExplicitWidth = 650
    end
  end
  inherited pnlLeft: TPanel
    Height = 377
    ExplicitHeight = 377
    inherited bvlLeft: TBevel
      Height = 354
    end
    inherited vleHeader: TValueListEditor
      Height = 354
      ExplicitHeight = 354
    end
  end
  inherited pnlClient: TPanel
    Width = 405
    Height = 377
    ExplicitWidth = 405
    ExplicitHeight = 377
    inherited lblRoute: TLabel
      Width = 402
      Caption = 'GET /json_reflect'
      ExplicitWidth = 402
    end
    object gbxJSONReflectionResponse: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 26
      Width = 399
      Height = 348
      Align = alClient
      Caption = ' Response '
      TabOrder = 0
      object mmoJSONReflectionResponse: TMemo
        Left = 2
        Top = 15
        Width = 395
        Height = 331
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '['
          '  {'
          '    "id": 1,'
          '    "name": "Leanne Graham",'
          '    "username": "Bret",'
          '    "email": "Sincere@april.biz",'
          '    "address": {'
          '      "street": "Kulas Light",'
          '      "suite": "Apt. 556",'
          '      "city": "Gwenborough",'
          '      "zipcode": "92998-3874",'
          '      "geo": {'
          '        "lat": "-37.3159",'
          '        "lng": "81.1496"'
          '      }'
          '    },'
          '    "phone": "1-770-736-8031 x56442",'
          '    "website": "hildegard.org",'
          '    "company": {'
          '      "name": "Romaguera-Crona",'
          '      "catchPhrase": "Multi-layered client-server neural-net",'
          '      "bs": "harness real-time e-markets"'
          '    }'
          '  },'
          '  {'
          '    "id": 2,'
          '    "name": "Ervin Howell",'
          '    "username": "Antonette",'
          '    "email": "Shanna@melissa.tv",'
          '    "address": {'
          '      "street": "Victor Plains",'
          '      "suite": "Suite 879",'
          '      "city": "Wisokyburgh",'
          '      "zipcode": "90566-7771",'
          '      "geo": {'
          '        "lat": "-43.9509",'
          '        "lng": "-34.4618"'
          '      }'
          '    },'
          '    "phone": "010-692-6593 x09125",'
          '    "website": "anastasia.net",'
          '    "company": {'
          '      "name": "Deckow-Crist",'
          '      "catchPhrase": "Proactive didactic contingency",'
          '      "bs": "synergize scalable supply-chains"'
          '    }'
          '  },'
          '  {'
          '    "id": 3,'
          '    "name": "Clementine Bauch",'
          '    "username": "Samantha",'
          '    "email": "Nathan@yesenia.net",'
          '    "address": {'
          '      "street": "Douglas Extension",'
          '      "suite": "Suite 847",'
          '      "city": "McKenziehaven",'
          '      "zipcode": "59590-4157",'
          '      "geo": {'
          '        "lat": "-68.6102",'
          '        "lng": "-47.0653"'
          '      }'
          '    },'
          '    "phone": "1-463-123-4447",'
          '    "website": "ramiro.info",'
          '    "company": {'
          '      "name": "Romaguera-Jacobson",'
          '      "catchPhrase": "Face to face bifurcated interface",'
          '      "bs": "e-enable strategic applications"'
          '    }'
          '  },'
          '  {'
          '    "id": 4,'
          '    "name": "Patricia Lebsack",'
          '    "username": "Karianne",'
          '    "email": "Julianne.OConner@kory.org",'
          '    "address": {'
          '      "street": "Hoeger Mall",'
          '      "suite": "Apt. 692",'
          '      "city": "South Elvis",'
          '      "zipcode": "53919-4257",'
          '      "geo": {'
          '        "lat": "29.4572",'
          '        "lng": "-164.2990"'
          '      }'
          '    },'
          '    "phone": "493-170-9623 x156",'
          '    "website": "kale.biz",'
          '    "company": {'
          '      "name": "Robel-Corkery",'
          '      "catchPhrase": "Multi-tiered zero tolerance productivity",'
          '      "bs": "transition cutting-edge web services"'
          '    }'
          '  },'
          '  {'
          '    "id": 5,'
          '    "name": "Chelsey Dietrich",'
          '    "username": "Kamren",'
          '    "email": "Lucio_Hettinger@annie.ca",'
          '    "address": {'
          '      "street": "Skiles Walks",'
          '      "suite": "Suite 351",'
          '      "city": "Roscoeview",'
          '      "zipcode": "33263",'
          '      "geo": {'
          '        "lat": "-31.8129",'
          '        "lng": "62.5342"'
          '      }'
          '    },'
          '    "phone": "(254)954-1289",'
          '    "website": "demarco.info",'
          '    "company": {'
          '      "name": "Keebler LLC",'
          '      "catchPhrase": "User-centric fault-tolerant solution",'
          '      "bs": "revolutionize end-to-end systems"'
          '    }'
          '  },'
          '  {'
          '    "id": 6,'
          '    "name": "Mrs. Dennis Schulist",'
          '    "username": "Leopoldo_Corkery",'
          '    "email": "Karley_Dach@jasper.info",'
          '    "address": {'
          '      "street": "Norberto Crossing",'
          '      "suite": "Apt. 950",'
          '      "city": "South Christy",'
          '      "zipcode": "23505-1337",'
          '      "geo": {'
          '        "lat": "-71.4197",'
          '        "lng": "71.7478"'
          '      }'
          '    },'
          '    "phone": "1-477-935-8478 x6430",'
          '    "website": "ola.org",'
          '    "company": {'
          '      "name": "Considine-Lockman",'
          '      "catchPhrase": "Synchronised bottom-line interface",'
          '      "bs": "e-enable innovative applications"'
          '    }'
          '  },'
          '  {'
          '    "id": 7,'
          '    "name": "Kurtis Weissnat",'
          '    "username": "Elwyn.Skiles",'
          '    "email": "Telly.Hoeger@billy.biz",'
          '    "address": {'
          '      "street": "Rex Trail",'
          '      "suite": "Suite 280",'
          '      "city": "Howemouth",'
          '      "zipcode": "58804-1099",'
          '      "geo": {'
          '        "lat": "24.8918",'
          '        "lng": "21.8984"'
          '      }'
          '    },'
          '    "phone": "210.067.6132",'
          '    "website": "elvis.io",'
          '    "company": {'
          '      "name": "Johns Group",'
          '      "catchPhrase": "Configurable multimedia task-force",'
          '      "bs": "generate enterprise e-tailers"'
          '    }'
          '  },'
          '  {'
          '    "id": 8,'
          '    "name": "Nicholas Runolfsdottir V",'
          '    "username": "Maxime_Nienow",'
          '    "email": "Sherwood@rosamond.me",'
          '    "address": {'
          '      "street": "Ellsworth Summit",'
          '      "suite": "Suite 729",'
          '      "city": "Aliyaview",'
          '      "zipcode": "45169",'
          '      "geo": {'
          '        "lat": "-14.3990",'
          '        "lng": "-120.7677"'
          '      }'
          '    },'
          '    "phone": "586.493.6943 x140",'
          '    "website": "jacynthe.com",'
          '    "company": {'
          '      "name": "Abernathy Group",'
          '      "catchPhrase": "Implemented secondary concept",'
          '      "bs": "e-enable extensible e-tailers"'
          '    }'
          '  },'
          '  {'
          '    "id": 9,'
          '    "name": "Glenna Reichert",'
          '    "username": "Delphine",'
          '    "email": "Chaim_McDermott@dana.io",'
          '    "address": {'
          '      "street": "Dayna Park",'
          '      "suite": "Suite 449",'
          '      "city": "Bartholomebury",'
          '      "zipcode": "76495-3109",'
          '      "geo": {'
          '        "lat": "24.6463",'
          '        "lng": "-168.8889"'
          '      }'
          '    },'
          '    "phone": "(775)976-6794 x41206",'
          '    "website": "conrad.com",'
          '    "company": {'
          '      "name": "Yost and Sons",'
          '      "catchPhrase": "Switchable contextually-based project",'
          '      "bs": "aggregate real-time technologies"'
          '    }'
          '  },'
          '  {'
          '    "id": 10,'
          '    "name": "Clementina DuBuque",'
          '    "username": "Moriah.Stanton",'
          '    "email": "Rey.Padberg@karina.biz",'
          '    "address": {'
          '      "street": "Kattie Turnpike",'
          '      "suite": "Suite 198",'
          '      "city": "Lebsackbury",'
          '      "zipcode": "31428-2261",'
          '      "geo": {'
          '        "lat": "-38.2386",'
          '        "lng": "57.2232"'
          '      }'
          '    },'
          '    "phone": "024-648-3804",'
          '    "website": "ambrose.net",'
          '    "company": {'
          '      "name": "Hoeger LLC",'
          '      "catchPhrase": "Centralized empowering task-force",'
          '      "bs": "target end-to-end models"'
          '    }'
          '  }'
          ']')
        ScrollBars = ssVertical
        TabOrder = 0
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
    Left = 45
    Top = 77
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
    Left = 43
    Top = 128
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
    Left = 40
    Top = 168
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
  object mtCompany: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 40
    Top = 216
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
  object dsUser: TDataSource
    AutoEdit = False
    DataSet = mtUser
    Left = 93
    Top = 77
  end
  object dsAddress: TDataSource
    AutoEdit = False
    DataSet = mtAddress
    Left = 88
    Top = 128
  end
  object dsGeo: TDataSource
    AutoEdit = False
    DataSet = mtGeo
    Left = 88
    Top = 168
  end
  object dsCompany: TDataSource
    AutoEdit = False
    DataSet = mtCompany
    Left = 88
    Top = 216
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 32
    Top = 280
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 88
    Top = 280
  end
end
