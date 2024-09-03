inherited frmViewMultipartFormData: TfrmViewMultipartFormData
  Width = 750
  Height = 603
  ExplicitWidth = 750
  ExplicitHeight = 603
  inherited gbxRequestURL: TGroupBox
    Width = 750
    ExplicitWidth = 750
    inherited edtRequestURL: TEdit
      Width = 736
      ExplicitWidth = 736
    end
  end
  inherited pnlLeft: TPanel
    Height = 552
    ExplicitHeight = 552
    inherited bvlLeft: TBevel
      Height = 529
      ExplicitHeight = 373
    end
    inherited vleHeader: TValueListEditor
      Height = 529
      ExplicitHeight = 529
    end
  end
  inherited pnlClient: TPanel
    Width = 491
    Height = 552
    ExplicitWidth = 491
    ExplicitHeight = 552
    inherited lblRoute: TLabel
      Width = 488
      Caption = ' POST /form-data'
      ExplicitLeft = -3
      ExplicitTop = 3
      ExplicitWidth = 464
    end
    object gbxStream: TGroupBox
      Left = 0
      Top = 23
      Width = 491
      Height = 105
      Align = alTop
      Caption = ' Stream '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object imgStream: TImage
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 481
        Height = 82
        Align = alClient
        Center = True
        ExplicitLeft = 112
        ExplicitTop = 40
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
    object gbxFields: TGroupBox
      Left = 0
      Top = 128
      Width = 491
      Height = 144
      Align = alTop
      Caption = ' Fields '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object vleFields: TValueListEditor
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 481
        Height = 121
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ColWidths = (
          217
          258)
      end
    end
    object gbxFiles: TGroupBox
      Left = 0
      Top = 272
      Width = 491
      Height = 45
      Align = alTop
      Caption = ' Files '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object lblFile: TLabel
        Left = 11
        Top = 20
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
