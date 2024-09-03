object frmFormHorseBase: TfrmFormHorseBase
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'FormHorseBase'
  ClientHeight = 700
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
  object splMain: TSplitter
    AlignWithMargins = True
    Left = 3
    Top = 396
    Width = 1269
    Height = 7
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    Color = 14404799
    ParentColor = False
    ResizeStyle = rsUpdate
    ExplicitLeft = 1
    ExplicitTop = 563
  end
  object gbxRequest: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 81
    Width = 1267
    Height = 309
    Margins.Right = 5
    Align = alTop
    Caption = ' Request '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlRequestExecute: TPanel
      Left = 2
      Top = 257
      Width = 1263
      Height = 50
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlRequestExecute'
      ShowCaption = False
      TabOrder = 0
      object bvlRequestExecute: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1257
        Height = 2
        Align = alTop
        Shape = bsBottomLine
        ExplicitLeft = 2
        ExplicitTop = 522
        ExplicitWidth = 784
      end
      object btnRequestExecute: TBitBtn
        AlignWithMargins = True
        Left = 1053
        Top = 11
        Width = 200
        Height = 36
        Margins.Right = 10
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
        TabOrder = 0
        OnClick = btnRequestExecuteClick
      end
      object ckbRequestExecuteThread: TCheckBox
        Left = 969
        Top = 8
        Width = 81
        Height = 42
        Align = alRight
        Caption = 'Use thread?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object gbxRequestBody: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 94
      Width = 1257
      Height = 160
      Align = alClient
      Caption = ' Body '
      TabOrder = 1
    end
    object gbxRequestURL: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 1257
      Height = 70
      Align = alTop
      Caption = ' URL '
      TabOrder = 2
      object lblRequestMethod: TLabel
        Left = 10
        Top = 20
        Width = 36
        Height = 13
        Caption = 'Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblRequestBaseURL: TLabel
        Left = 110
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
      object lblRequestResource: TLabel
        Left = 725
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
      object cbxRequestMethod: TComboBox
        Left = 10
        Top = 39
        Width = 80
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'GET'
        Items.Strings = (
          'GET'
          'POST'
          'PUT'
          'PATCH'
          'DELETE'
          'MERGE'
          'HEAD'
          'OPTIONS'
          'TRACE')
      end
      object edtRequestBaseURL: TButtonedEdit
        Left = 110
        Top = 39
        Width = 600
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
        Text = 'http://localhost:9000'
      end
      object edtRequestResource: TButtonedEdit
        Left = 725
        Top = 39
        Width = 275
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        RightButton.Visible = True
        TabOrder = 2
      end
    end
  end
  object gbxResponse: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 411
    Width = 1267
    Height = 286
    Margins.Top = 5
    Margins.Right = 5
    Align = alClient
    Caption = ' Response '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pnlResponseStatus: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 1257
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlResponseStatus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      object lblResponseURL: TLabel
        Left = 10
        Top = 5
        Width = 12
        Height = 13
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblResponseStatus: TLabel
        Left = 10
        Top = 24
        Width = 12
        Height = 13
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object pgcResponseBody: TPageControl
      Left = 2
      Top = 61
      Width = 1263
      Height = 223
      ActivePage = tbsResponseBody
      Align = alClient
      TabHeight = 25
      TabOrder = 1
      TabWidth = 150
      object tbsResponseBody: TTabSheet
        Caption = 'Body'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object gbxResponseBinary: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1249
          Height = 49
          Align = alTop
          Caption = 'Body Info'
          TabOrder = 0
          object lblResponseMIMETypeTitle: TLabel
            Left = 11
            Top = 24
            Width = 57
            Height = 13
            Caption = 'MIME Type:'
          end
          object lblResponseMIMEType: TLabel
            Left = 74
            Top = 24
            Width = 12
            Height = 13
            Caption = '...'
          end
          object lblResponseMIMETypeExtTitle: TLabel
            Left = 255
            Top = 24
            Width = 76
            Height = 13
            Caption = 'MIME Type Ext:'
          end
          object lblResponseMIMETypeExt: TLabel
            Left = 340
            Top = 24
            Width = 12
            Height = 13
            Caption = '...'
          end
          object lblResponseCharSetTitle: TLabel
            Left = 410
            Top = 24
            Width = 43
            Height = 13
            Caption = 'CharSet:'
          end
          object lblResponseCharSet: TLabel
            Left = 465
            Top = 24
            Width = 12
            Height = 13
            Caption = '...'
          end
          object ckbResponseIsBinary: TCheckBox
            Left = 545
            Top = 23
            Width = 70
            Height = 17
            Caption = 'Is Binary?'
            TabOrder = 0
          end
          object btnResponseSaveToFile: TBitBtn
            Left = 680
            Top = 19
            Width = 120
            Height = 25
            Caption = 'Save to file'
            TabOrder = 1
            OnClick = btnResponseSaveToFileClick
          end
        end
      end
      object tbsResponseHeaders: TTabSheet
        Caption = 'Headers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 1
        ParentFont = False
        object mmoResponseHeaders: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1249
          Height = 182
          Align = alClient
          Lines.Strings = (
            '')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WordWrap = False
        end
      end
      object tbsResponseCookies: TTabSheet
        Caption = 'Cookies'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 2
        ParentFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object mmoResponseCookies: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1249
          Height = 182
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          WordWrap = False
        end
      end
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
    TabOrder = 2
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
  object sdlSaveFile: TSaveDialog
    Title = 'Save File'
    Left = 512
    Top = 65533
  end
end
