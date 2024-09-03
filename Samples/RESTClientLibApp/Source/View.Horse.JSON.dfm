inherited frmViewHorseJSON: TfrmViewHorseJSON
  Caption = 'View Horse JSON'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbxRequest: TGroupBox
    inherited gbxRequestBody: TGroupBox
      object mmoRequestBody: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 1247
        Height = 137
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          '{'
          '  "id": 1,'
          '  "name": "Leanne Graham",'
          '  "username": "Bret",'
          '  "email": "Sincere@april.biz",'
          '  "address": {'
          '    "street": "Kulas Light",'
          '    "suite": "Apt. 556",'
          '    "city": "Gwenborough",'
          '    "zipcode": "92998-3874",'
          '    "geo": {'
          '      "lat": "-37.3159",'
          '      "lng": "81.1496"'
          '    }'
          '  },'
          '  "phone": "1-770-736-8031 x56442",'
          '  "website": "hildegard.org",'
          '  "company": {'
          '    "name": "Romaguera-Crona",'
          '    "catchPhrase": "Multi-layered client-server neural-net",'
          '    "bs": "harness real-time e-markets"'
          '  }'
          '}')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    inherited gbxRequestURL: TGroupBox
      inherited edtRequestResource: TButtonedEdit
        Text = 'json'
      end
    end
  end
  inherited gbxResponse: TGroupBox
    inherited pgcResponseBody: TPageControl
      inherited tbsResponseBody: TTabSheet
        object mmoResponseBody: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 58
          Width = 1249
          Height = 127
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
  end
end
