object frmRequestBase: TfrmRequestBase
  Left = 0
  Top = 0
  Width = 700
  Height = 407
  Color = clWindow
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object gbxRequestURL: TGroupBox
    Left = 0
    Top = 0
    Width = 700
    Height = 45
    Align = alTop
    Caption = ' Request URL '
    TabOrder = 0
    object edtRequestURL: TEdit
      AlignWithMargins = True
      Left = 9
      Top = 18
      Width = 686
      Height = 22
      Margins.Left = 7
      Align = alClient
      ReadOnly = True
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
  object pnlLeft: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 48
    Width = 250
    Height = 356
    Margins.Left = 0
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlLeft'
    ShowCaption = False
    TabOrder = 1
    object bvlLeft: TBevel
      Left = 248
      Top = 23
      Width = 2
      Height = 333
      Align = alRight
      Shape = bsRightLine
      ExplicitLeft = 390
      ExplicitTop = 1
      ExplicitHeight = 360
    end
    object lblHeaders: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 247
      Height = 17
      Margins.Left = 0
      Align = alTop
      AutoSize = False
      Caption = ' Headers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExplicitLeft = 6
      ExplicitWidth = 244
    end
    object vleHeader: TValueListEditor
      Left = 0
      Top = 23
      Width = 248
      Height = 333
      Align = alClient
      BorderStyle = bsNone
      DefaultColWidth = 130
      DefaultRowHeight = 20
      DisplayOptions = [doColumnTitles, doKeyColFixed]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
      ScrollBars = ssHorizontal
      TabOrder = 0
      TitleCaptions.Strings = (
        'Field'
        'Value')
      ColWidths = (
        104
        248)
    end
  end
  object pnlClient: TPanel
    AlignWithMargins = True
    Left = 256
    Top = 48
    Width = 441
    Height = 356
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlClient'
    ShowCaption = False
    TabOrder = 2
    object lblRoute: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 438
      Height = 17
      Margins.Left = 0
      Align = alTop
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExplicitLeft = 6
      ExplicitTop = 11
      ExplicitWidth = 435
    end
  end
end
