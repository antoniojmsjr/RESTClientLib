object frmFormBenchmarksBase: TfrmFormBenchmarksBase
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmFormBenchmarksBase'
  ClientHeight = 866
  ClientWidth = 1160
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
  object gbxRequestURL: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 76
    Width = 1154
    Height = 70
    Align = alTop
    Caption = ' URL '
    TabOrder = 0
    ExplicitLeft = 8
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
      RightButton.Visible = True
      TabOrder = 1
      Text = 'https://one.one.one.one/'
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
  object pnlClient: TPanel
    Left = 0
    Top = 149
    Width = 1160
    Height = 250
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    ShowCaption = False
    TabOrder = 1
    object gbxNetHTTP: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 230
      Height = 244
      Align = alLeft
      Caption = ' Library NetHTTP '
      TabOrder = 0
      object pnlNetHTTPFooter: TPanel
        Left = 2
        Top = 202
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlNetHTTPFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlNetHTTPFooter: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblNetHTTPRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL'
          DataSource = dsLogNetHTTP
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -2
          ExplicitTop = 15
        end
        object dblblNetHTTPRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG'
          DataSource = dsLogNetHTTP
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 121
          ExplicitTop = 15
        end
      end
      object dbgNetHTTP: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 181
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogNetHTTP
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_DISPLAY'
            Width = 160
            Visible = True
          end>
      end
    end
    object gbxIndy: TGroupBox
      AlignWithMargins = True
      Left = 246
      Top = 3
      Width = 230
      Height = 244
      Margins.Left = 10
      Align = alLeft
      Caption = ' Library Indy'
      TabOrder = 1
      object pnlIndyFooter: TPanel
        Left = 2
        Top = 202
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlIndyFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlIndyFooter: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblIndyRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL'
          DataSource = dsLogIndy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 151
        end
        object dblblIndyRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG'
          DataSource = dsLogIndy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 124
          ExplicitTop = 16
        end
      end
      object dbgIndy: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 181
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogIndy
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_DISPLAY'
            Width = 160
            Visible = True
          end>
      end
    end
    object gbxSynapse: TGroupBox
      AlignWithMargins = True
      Left = 489
      Top = 3
      Width = 230
      Height = 244
      Margins.Left = 10
      Align = alLeft
      Caption = ' Library Synapse'
      TabOrder = 2
      object pnlSynapseFooter: TPanel
        Left = 2
        Top = 202
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlNetHTTPFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlSynapseFooter: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblSynapseRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL'
          DataSource = dsLogSynapse
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 121
          ExplicitTop = 15
        end
        object dblblSynapseRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG'
          DataSource = dsLogSynapse
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 124
          ExplicitTop = 16
        end
      end
      object dbgSynapse: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 181
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogSynapse
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_DISPLAY'
            Width = 160
            Visible = True
          end>
      end
    end
  end
  object pnlRequestExecute: TPanel
    Left = 0
    Top = 399
    Width = 1160
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlRequestExecute'
    ShowCaption = False
    TabOrder = 2
    object bvlRequestExecuteTop: TBevel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1154
      Height = 2
      Align = alTop
      Shape = bsTopLine
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 1158
    end
    object bvlRequestExecuteBottom: TBevel
      Left = 0
      Top = 55
      Width = 1160
      Height = 2
      Align = alBottom
      Shape = bsBottomLine
      ExplicitTop = 7
    end
    object btnRequestExecute: TBitBtn
      AlignWithMargins = True
      Left = 950
      Top = 11
      Width = 200
      Height = 41
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
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 456
    Width = 1160
    Height = 230
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    ShowCaption = False
    TabOrder = 3
    object gbxNetHTTPTotalizer: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 230
      Height = 224
      Align = alLeft
      Caption = ' Library NetHTTP - Totalizer'
      TabOrder = 0
      object pnlNetHTTPTotalizer: TPanel
        Left = 2
        Top = 182
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlNetHTTPFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlNetHTTPTotalizer: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblNetHTTPTotalizerRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL_TOTAL'
          DataSource = dsLogNetHTTPTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -2
          ExplicitTop = 15
        end
        object dblblNetHTTPTotalizerRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG_AVG'
          DataSource = dsLogNetHTTPTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 121
          ExplicitTop = 15
        end
      end
      object dbgNetHTTPTotalizer: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 161
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogNetHTTPTotalizer
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_TOTAL'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_AVG'
            Width = 75
            Visible = True
          end>
      end
    end
    object gbxIndyTotalizer: TGroupBox
      AlignWithMargins = True
      Left = 239
      Top = 3
      Width = 230
      Height = 224
      Align = alLeft
      Caption = ' Library Indy - Totalizer'
      TabOrder = 1
      object pnlIndyTotalizer: TPanel
        Left = 2
        Top = 182
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlNetHTTPFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlIndyTotalizer: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblIndyTotalizerRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL_TOTAL'
          DataSource = dsLogIndyTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -2
          ExplicitTop = 15
        end
        object dblblIndyTotalizerRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG_AVG'
          DataSource = dsLogIndyTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 121
          ExplicitTop = 15
        end
      end
      object dbgIndyTotalizer: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 161
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogIndyTotalizer
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_TOTAL'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_AVG'
            Width = 75
            Visible = True
          end>
      end
    end
    object gbxSynapseTotalizer: TGroupBox
      AlignWithMargins = True
      Left = 475
      Top = 3
      Width = 230
      Height = 224
      Align = alLeft
      Caption = ' Library Synapse - Totalizer'
      TabOrder = 2
      object pnlSynapseTotalizer: TPanel
        Left = 2
        Top = 182
        Width = 226
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlNetHTTPFooter'
        ShowCaption = False
        TabOrder = 0
        object bvlSynapseTotalizer: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 2
          Align = alTop
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 344
        end
        object dblblSynapseTotalizerRequestTimeTotal: TDBText
          AlignWithMargins = True
          Left = 3
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          DataField = 'REQUEST_TIME_TOTAL_TOTAL'
          DataSource = dsLogSynapseTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -2
          ExplicitTop = 15
        end
        object dblblSynapseTotalizerRequestTimeAverage: TDBText
          AlignWithMargins = True
          Left = 116
          Top = 13
          Width = 100
          Height = 24
          Margins.Top = 5
          Margins.Right = 10
          Align = alLeft
          Alignment = taRightJustify
          DataField = 'REQUEST_TIME_AVG_AVG'
          DataSource = dsLogSynapseTotalizer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 121
          ExplicitTop = 15
        end
      end
      object dbgSynapseTotalizer: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 220
        Height = 161
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsLogSynapseTotalizer
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMBER'
            Title.Alignment = taCenter
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_TOTAL'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REQUEST_TIME_AVG'
            Width = 75
            Visible = True
          end>
      end
    end
  end
  object gbxSettings: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 5
    Width = 1154
    Height = 65
    Margins.Top = 5
    Align = alTop
    Caption = 'Settings '
    TabOrder = 4
    object lblRequestTimeout: TLabel
      Left = 260
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
      Left = 360
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
      Left = 465
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
      Left = 545
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
      Left = 530
      Top = 14
      Width = 5
      Height = 50
      Shape = bsLeftLine
    end
    object lblProxyPort: TLabel
      Left = 710
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
      Left = 805
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
      Left = 980
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
    object lblDebugRESTClientLib: TLabel
      Left = 10
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
      Left = 130
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
      Left = 10
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
      TabOrder = 0
      OnClick = ckbDebugRESTClientLibClick
    end
    object edtRequestTimeout: TSpinEdit
      Left = 260
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
      TabOrder = 2
      Value = 15000
    end
    object edtResponseTimeout: TSpinEdit
      Left = 360
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
    object edtRetries: TSpinEdit
      Left = 465
      Top = 39
      Width = 50
      Height = 22
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 4
      Value = 1
    end
    object edtProxyServer: TEdit
      Left = 545
      Top = 39
      Width = 150
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtProxyPort: TSpinEdit
      Left = 710
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
      TabOrder = 6
      Value = 0
    end
    object edtProxyUserName: TEdit
      Left = 805
      Top = 39
      Width = 160
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object edtProxyPassword: TEdit
      Left = 980
      Top = 39
      Width = 160
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object ckbConnectionKeepAlive: TCheckBox
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
      OnClick = ckbConnectionKeepAliveClick
    end
  end
  object memLogNetHTTP: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 27
    Top = 135
    object memLogNetHTTPNUMBER: TIntegerField
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogNetHTTPREQUEST_TIME: TIntegerField
      FieldName = 'REQUEST_TIME'
    end
    object memLogNetHTTPREQUEST_TIME_DISPLAY: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'REQUEST TIME'
      FieldName = 'REQUEST_TIME_DISPLAY'
      Size = 30
    end
    object memLogNetHTTPREQUEST_TIME_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME)'
    end
    object memLogNetHTTPREQUEST_TIME_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME)'
    end
  end
  object dsLogNetHTTP: TDataSource
    AutoEdit = False
    DataSet = memLogNetHTTP
    Left = 99
    Top = 135
  end
  object memLogIndy: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 267
    Top = 143
    object memLogIndyNUMBER: TIntegerField
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogIndyREQUEST_TIME: TIntegerField
      FieldName = 'REQUEST_TIME'
    end
    object memLogIndyREQUEST_TIME_DISPLAY: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'REQUEST TIME'
      FieldName = 'REQUEST_TIME_DISPLAY'
      Size = 30
    end
    object memLogIndyREQUEST_TIME_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME)'
    end
    object memLogIndyREQUEST_TIME_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME)'
    end
  end
  object dsLogIndy: TDataSource
    AutoEdit = False
    DataSet = memLogIndy
    Left = 339
    Top = 143
  end
  object memLogSynapse: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 515
    Top = 143
    object memLogSynapseNUMBER: TIntegerField
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogSynapseREQUEST_TIME: TIntegerField
      FieldName = 'REQUEST_TIME'
    end
    object memLogSynapseREQUEST_TIME_DISPLAY: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'REQUEST TIME'
      FieldName = 'REQUEST_TIME_DISPLAY'
      Size = 30
    end
    object memLogSynapseREQUEST_TIME_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME)'
    end
    object memLogSynapseREQUEST_TIME_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME)'
    end
  end
  object dsLogSynapse: TDataSource
    AutoEdit = False
    DataSet = memLogSynapse
    Left = 587
    Top = 143
  end
  object memLogNetHTTPTotalizer: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 36
    Top = 567
    object memLogNetHTTPTotalizerNUMBER: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogNetHTTPTotalizerREQUEST_TIME_TOTAL: TIntegerField
      DisplayLabel = 'TOTAL'
      FieldName = 'REQUEST_TIME_TOTAL'
      DisplayFormat = '00ms'
    end
    object memLogNetHTTPTotalizerREQUEST_TIME_AVG: TIntegerField
      DisplayLabel = 'AVG'
      FieldName = 'REQUEST_TIME_AVG'
      DisplayFormat = '00ms'
    end
    object memLogNetHTTPTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME_TOTAL)'
    end
    object memLogNetHTTPTotalizerREQUEST_TIME_AVG_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME_AVG)'
    end
  end
  object dsLogNetHTTPTotalizer: TDataSource
    AutoEdit = False
    DataSet = memLogNetHTTPTotalizer
    Left = 116
    Top = 567
  end
  object memLogIndyTotalizer: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 292
    Top = 567
    object memLogIndyTotalizerNUMBER: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogIndyTotalizerREQUEST_TIME_TOTAL: TIntegerField
      DisplayLabel = 'TOTAL'
      FieldName = 'REQUEST_TIME_TOTAL'
      DisplayFormat = '00ms'
    end
    object memLogIndyTotalizerREQUEST_TIME_AVG: TIntegerField
      DisplayLabel = 'AVG'
      FieldName = 'REQUEST_TIME_AVG'
      DisplayFormat = '00ms'
    end
    object memLogIndyTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME_TOTAL)'
    end
    object memLogIndyTotalizerREQUEST_TIME_AVG_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME_AVG)'
    end
  end
  object dsLogIndyTotalizer: TDataSource
    AutoEdit = False
    DataSet = memLogIndyTotalizer
    Left = 372
    Top = 567
  end
  object memLogSynapseTotalizer: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 508
    Top = 567
    object memLogSynapseTotalizerNUMBER: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'N'#186
      FieldName = 'NUMBER'
      DisplayFormat = '00'
    end
    object memLogSynapseTotalizerREQUEST_TIME_TOTAL: TIntegerField
      DisplayLabel = 'TOTAL'
      FieldName = 'REQUEST_TIME_TOTAL'
      DisplayFormat = '00ms'
    end
    object memLogSynapseTotalizerREQUEST_TIME_AVG: TIntegerField
      DisplayLabel = 'AVG'
      FieldName = 'REQUEST_TIME_AVG'
      DisplayFormat = '00ms'
    end
    object memLogSynapseTotalizerREQUEST_TIME_TOTAL_TOTAL: TAggregateField
      FieldName = 'REQUEST_TIME_TOTAL_TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = 'TT: 00ms'
      Expression = 'SUM(REQUEST_TIME_TOTAL)'
    end
    object memLogSynapseTotalizerREQUEST_TIME_AVG_AVG: TAggregateField
      FieldName = 'REQUEST_TIME_AVG_AVG'
      Active = True
      DisplayName = ''
      DisplayFormat = 'AVG: 00ms'
      Expression = 'AVG(REQUEST_TIME_AVG)'
    end
  end
  object dsLogSynapseTotalizer: TDataSource
    AutoEdit = False
    DataSet = memLogSynapseTotalizer
    Left = 588
    Top = 567
  end
end
