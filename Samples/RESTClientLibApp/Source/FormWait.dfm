object frmWait: TfrmWait
  Left = 0
  Top = 0
  Width = 659
  Height = 45
  Align = alLeft
  Color = clWindow
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 45
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlLeft'
    ShowCaption = False
    TabOrder = 0
  end
  object pnlIndicator: TPanel
    Left = 200
    Top = 0
    Width = 80
    Height = 45
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlIndicator'
    ShowCaption = False
    TabOrder = 1
    object actIndicator: TActivityIndicator
      Left = 6
      Top = 0
      FrameDelay = 40
      IndicatorSize = aisLarge
      IndicatorType = aitSectorRing
    end
  end
  object pnlMessage: TPanel
    Left = 280
    Top = 0
    Width = 379
    Height = 45
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMessage'
    ShowCaption = False
    TabOrder = 2
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 10
      Width = 379
      Height = 25
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Working ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 102
    end
  end
end
