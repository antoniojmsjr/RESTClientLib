object frmFormJSONSerializeBase: TfrmFormJSONSerializeBase
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'FormDataSerializeBase'
  ClientHeight = 468
  ClientWidth = 1275
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbxGET: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 81
    Width = 1269
    Height = 384
    Align = alClient
    Caption = ' GET '
    TabOrder = 0
    object gbxRequestGETURL: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 1259
      Height = 70
      Align = alTop
      Caption = ' URL '
      TabOrder = 0
      object lblRequestGETURL: TLabel
        Left = 10
        Top = 20
        Width = 45
        Height = 13
        Caption = 'Base URL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblRequestGETResource: TLabel
        Left = 335
        Top = 20
        Width = 45
        Height = 13
        Caption = 'Resource'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtRequestGETURL: TButtonedEdit
        Left = 10
        Top = 39
        Width = 300
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        RightButton.Visible = True
        TabOrder = 0
      end
      object edtRequestGETResource: TButtonedEdit
        Left = 335
        Top = 39
        Width = 100
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        RightButton.Visible = True
        TabOrder = 1
      end
      object btnRequestGETExecute: TBitBtn
        AlignWithMargins = True
        Left = 1132
        Top = 28
        Width = 120
        Height = 34
        Margins.Top = 13
        Margins.Right = 5
        Margins.Bottom = 6
        Align = alRight
        Caption = 'Execute'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FF7AC1EE
          D6ECF9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFECF6FD58B0E8B0DAF4FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          8CC9EF58B0E888C7EFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFF9FCFF58B0E858B0E86AB8EAFDFEFFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9DD1F258B0E858B0E858B0E8E4F2FCFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF58B0E858B0E858B0E858
          B0E8C1E2F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFAED9F458B0E858B0E858B0E858B0E898CEF1FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5FB3E958B0E858
          B0E858B0E858B0E875BEECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          5FB4EB5DB2E960B4E95DB2E958B0E858B0E858B0E858B0E858B0E85BB2E8EFF7
          FDFF00FFFF00FFFF00FFFF00FFFF00FFCEE8F958B0E858B0E858B0E858B0E858
          B0E858B0E85CB2E95FB3E958B0E858B0E8D1EAF9FF00FFFF00FFFF00FFFF00FF
          FF00FF81C3EE58B0E858B0E858B0E858B0E858B0E858B0E8E3F2FBFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFCFEFF58B0E858B0E858B0E858
          B0E858B0E858B0E858B0E8C9E5F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFB9DEF658B0E858B0E858B0E858B0E858B0E858B0E858B0E8BADE
          F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6DBAEB58B0E858
          B0E858B0E858B0E858B0E858B0E858B0E8AAD7F3FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFEEF7FD58B0E858B0E858B0E858B0E858B0E858B0E858B0
          E858B0E89BD0F1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9D6F358
          B0E858B0E858B0E858B0E858B0E858B0E858B0E858B0E890CAF0}
        ParentFont = False
        Spacing = 10
        TabOrder = 2
        OnClick = btnRequestGETExecuteClick
      end
    end
    object gbxResponseGET: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 94
      Width = 1259
      Height = 163
      Align = alTop
      Caption = ' Body '
      TabOrder = 1
      object mmoResponseGETBody: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 1249
        Height = 140
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object gbxResponseGETData: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 263
      Width = 1259
      Height = 116
      Align = alClient
      Caption = ' Data '
      TabOrder = 2
    end
  end
  object gbxSettings: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 5
    Width = 1267
    Height = 70
    Margins.Top = 5
    Margins.Right = 5
    Align = alTop
    Caption = 'Settings '
    TabOrder = 1
    object lblRequestTimeout: TLabel
      Left = 380
      Top = 20
      Width = 81
      Height = 13
      Caption = 'Request Timeout'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblResponseTimeout: TLabel
      Left = 480
      Top = 20
      Width = 88
      Height = 13
      Caption = 'Response Timeout'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRetries: TLabel
      Left = 585
      Top = 20
      Width = 34
      Height = 13
      Caption = 'Retries'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblProxyServer: TLabel
      Left = 665
      Top = 20
      Width = 63
      Height = 13
      Caption = 'Proxy Server'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object bvlConfig: TBevel
      Left = 650
      Top = 14
      Width = 5
      Height = 50
      Shape = bsLeftLine
    end
    object lblProxyPort: TLabel
      Left = 830
      Top = 20
      Width = 51
      Height = 13
      Caption = 'Proxy Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblProxyUserName: TLabel
      Left = 925
      Top = 20
      Width = 80
      Height = 13
      Caption = 'Proxy UserName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblProxyPassword: TLabel
      Left = 1070
      Top = 20
      Width = 77
      Height = 13
      Caption = 'Proxy Password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRequestLibrary: TLabel
      Left = 10
      Top = 20
      Width = 76
      Height = 13
      Caption = 'Request Library'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDebugRESTClientLib: TLabel
      Left = 130
      Top = 20
      Width = 104
      Height = 13
      Caption = 'Debug RESTClientLib?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblConnectionKeepAlive: TLabel
      Left = 250
      Top = 20
      Width = 113
      Height = 13
      Caption = 'Connection Keep-Alive?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ckbDebugRESTClientLib: TCheckBox
      Left = 130
      Top = 41
      Width = 99
      Height = 17
      Caption = ' false'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtRequestTimeout: TSpinEdit
      Left = 380
      Top = 39
      Width = 80
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 3
      Value = 15000
    end
    object edtResponseTimeout: TSpinEdit
      Left = 480
      Top = 39
      Width = 80
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 4
      Value = 15000
    end
    object edtRetries: TSpinEdit
      Left = 585
      Top = 39
      Width = 50
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 5
      Value = 1
    end
    object edtProxyServer: TEdit
      Left = 665
      Top = 39
      Width = 150
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edtProxyPort: TSpinEdit
      Left = 830
      Top = 39
      Width = 80
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 7
      Value = 0
    end
    object edtProxyUserName: TEdit
      Left = 925
      Top = 39
      Width = 130
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object edtProxyPassword: TEdit
      Left = 1070
      Top = 39
      Width = 130
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object cbxRequestLibrary: TComboBox
      Left = 10
      Top = 39
      Width = 100
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'NetHTTP'
      Items.Strings = (
        'NetHTTP'
        'Indy')
    end
    object ckbConnectionKeepAlive: TCheckBox
      Left = 250
      Top = 39
      Width = 99
      Height = 17
      Caption = ' false'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
end
