object frmQueryParams: TfrmQueryParams
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'URL - Query Params'
  ClientHeight = 201
  ClientWidth = 474
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object QueryParams: TValueListEditor
    Left = 0
    Top = 95
    Width = 474
    Height = 106
    Align = alClient
    DefaultRowHeight = 20
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 0
    TitleCaptions.Strings = (
      'Query'
      'Value')
    ColWidths = (
      220
      248)
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 95
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlHeader'
    ShowCaption = False
    TabOrder = 1
    object lblQueryName: TLabel
      Left = 10
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Query'
    end
    object lblQueryValue: TLabel
      Left = 202
      Top = 8
      Width = 26
      Height = 13
      Caption = 'Value'
    end
    object btnAdd: TSpeedButton
      Left = 400
      Top = 20
      Width = 70
      Height = 30
      Caption = 'Add'
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFEFEFEE1EAD5BCD1A0A4C07D98B86C99B86DA5C17EBED2
        A2E4ECD8FFFFFEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFE3EBD7A0BD7788AC5688AC5588AC5588AC5588AC5588AC5589AD5688AC56
        A3BF7BE6EEDCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC8D9B18AAE
        5888AC5588AC5588AC5588AC5588AC5588AC5588AC5589AD5688AC5688AC568B
        AE5ACEDCB8FF00FFFF00FFFF00FFFF00FFFF00FFC7D8AF88AC5688AC5688AC55
        88AC5588AC5588AC5588AC5588AC5588AC5589AD5688AC5688AC5688AC5688AC
        56CEDCB8FF00FFFF00FFFF00FFE2EBD68AAD5888AC5688AC5688AC5688AC5688
        AC56A5C07FFF00FFFF00FFA2BE7A88AC5688AC5688AC5688AC5688AC568BAE59
        E7EEDCFF00FFFEFEFD9EBB7488AC5588AC5588AC5689AD5689AD5689AD56A5C0
        7EFF00FFFF00FFA2BE7A89AD5688AC5588AC5588AC5588AC5588AC55A4BF7CFF
        FFFEE0E9D288AC5688AC5588AC5588AC5689AD5689AD5689AD56A5C07EFF00FF
        FF00FFA2BE7A89AD5688AC5588AC5588AC5588AC5588AC5588AC56E4ECD8B9CE
        9A88AC5588AC5588AC5588AC5689AD5689AD5689AD56A5C07EFF00FFFF00FFA2
        BE7A89AD5688AC5588AC5588AC5588AC5588AC5588AC55BED2A2A0BD7788AC55
        88AC5588AC55A6C180A6C180A6C180A6C180BBD09EFF00FFFF00FFB9CE9BA6C1
        80A6C180A6C180A6C18088AC5588AC5588AC55A5C07E94B46588AC5588AC5588
        AC55FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF88AC5588AC5588AC5599B86D93B46588AC5588AC5588AC55FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF88AC5588AC5588AC5598B76C9EBC7488AC5588AC5588AC55A2BE7BA2BF7A
        A2BF7AA2BF7AB8CE9AFF00FFFF00FFB6CC97A2BF7AA2BE7AA2BE7AA2BE7A88AC
        5588AC5588AC55A4BF7CB6CD9789AD5689AD5689AD5688AC5689AD5689AD5689
        AD56A5C07EFF00FFFF00FFA2BE7A89AD5689AD5689AD5689AD5689AD5689AD56
        89AD56BBD09EDBE6CC88AC5688AC5688AC5688AC5688AC5588AC5588AC55A5C0
        7EFF00FFFF00FFA2BE7989AD5688AC5688AC5688AC5688AC5688AC5688AC56E1
        EAD4FDFDFC9AB96F88AC5688AC5688AC5688AC5588AC5588AC55A5C07EFF00FF
        FF00FFA2BE7989AD5688AC5688AC5688AC5688AC5688AC569FBC76FEFEFEFF00
        FFDCE7CE89AD5688AC5688AC5688AC5588AC5588AC55A5C07EFF00FFFF00FFA2
        BE7989AD5688AC5688AC5688AC5688AC568AAD58E2EAD5FF00FFFF00FFFF00FF
        BFD2A488AC5688AC5688AC5588AC5588AC5588AC5588AC5588AC5588AC5589AD
        5688AC5688AC5688AC5688AC56C6D7ADFF00FFFF00FFFF00FFFF00FFFEFEFEBF
        D2A389AD5688AC5588AC5588AC5588AC5588AC5588AC5588AC5589AD5688AC56
        88AC5689AD57C4D6AAFFFFFEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDAE5
        CA98B76C88AC5588AC5588AC5588AC5588AC5588AC5589AD5688AC569AB96FDD
        E8CFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFCFDFA
        D7E3C6B2C99098B76C8EB05D8EB05E99B86EB3CA92DAE5CAFDFDFCFF00FFFF00
        FFFF00FFFF00FFFF00FF}
      Spacing = 10
      OnClick = btnAddClick
    end
    object btnClear: TSpeedButton
      Left = 400
      Top = 59
      Width = 70
      Height = 30
      Caption = 'Clear'
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFDFEFFCCD2F28C9AE26275D84D63D34E64D36477D88E9C
        E3D0D6F3FEFEFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFCFD5F35B6FD5334CCB324BCB324BCB324BCB324BCB324BCB334CCC334CCB
        6073D7D4DAF4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1ACE7364F
        CC324BCB324BCB324BCB324BCB324BCB324BCB324BCB334CCC334CCB334CCB38
        50CCAAB4E9FF00FFFF00FFFF00FFFF00FFFF00FF9FAAE7334CCB334CCB324BCB
        324BCB324BCB324BCB324BCB324BCB324BCB334CCC334CCB334CCB334CCB334C
        CBAAB4E9FF00FFFF00FFFF00FFCDD3F2354ECC334CCB334CCB334CCB334CCB33
        4CCB334CCB334CCB334CCB334CCB334CCB334CCB334CCB334CCB334CCB374FCC
        D5DAF4FF00FFFDFDFE586CD5324BCB324BCB334CCB334CCC334CCC334CCC334C
        CC334CCC334CCC334CCC334CCC324BCB324BCB324BCB324BCB324BCB6175D7FE
        FEFFC9CFF1334CCB324BCB324BCB334CCB334CCC334CCC334CCC334CCC334CCC
        334CCC334CCC334CCC324BCB324BCB324BCB324BCB324BCB334CCBD0D6F38594
        E1324BCB324BCB324BCB334CCB334CCC334CCC334CCC334CCC334CCC334CCC33
        4CCC334CCC324BCB324BCB324BCB324BCB324BCB324BCB8F9DE35B6FD6324BCB
        324BCB3D55CE6679D86678D86678D86678D86678D86678D86678D86678D86678
        D86578D86578D86578D84259CF324BCB324BCB6477D8455CD1324BCB324BCB5E
        72D6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF6F81DB324BCB324BCB4F64D2455BD0324BCB324BCB5E72D6FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF6F81DB324BCB324BCB4E64D2586CD5324BCB324BCB3C54CE6074D75F73D7
        5F73D75F73D75F73D75F73D75F73D75F73D75F73D75F73D75F73D75F73D74057
        CF324BCB324BCB6175D78191E0334CCC334CCC334CCC334CCB334CCC334CCC33
        4CCC334CCC334CCC334CCC334CCC334CCC334CCC334CCC334CCC334CCC334CCC
        334CCC8A99E1C1C9F0334CCB334CCB334CCB334CCB324BCB324BCB324BCB324B
        CB324BCB324BCB324BCB334CCC334CCB334CCB334CCB334CCB334CCB334CCBCB
        D1F2FBFBFE5167D3334CCB334CCB334CCB324BCB324BCB324BCB324BCB324BCB
        324BCB324BCB334CCC334CCB334CCB334CCB334CCB334CCB596ED5FDFEFFFF00
        FFC4CBF0344CCB334CCB334CCB324BCB324BCB324BCB324BCB324BCB324BCB32
        4BCB334CCC334CCB334CCB334CCB334CCB354ECCCCD3F2FF00FFFF00FFFF00FF
        919EE3334CCB334CCB324BCB324BCB324BCB324BCB324BCB324BCB324BCB334C
        CC334CCB334CCB334CCB334CCB9CA8E6FF00FFFF00FFFF00FFFF00FFFDFEFF90
        9EE3344CCB324BCB324BCB324BCB324BCB324BCB324BCB324BCB334CCC334CCB
        334CCB344DCC99A5E5FEFEFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFC7
        EF4D63D2324BCB324BCB324BCB324BCB324BCB324BCB334CCC334CCB5167D3C5
        CCF0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF9FAFE
        BBC3EE7A8ADD4E64D23C53CD3C54CE5065D37C8CDEBFC7EFFBFBFEFF00FFFF00
        FFFF00FFFF00FFFF00FF}
      Spacing = 10
      OnClick = btnClearClick
    end
    object edtQueryName: TEdit
      Left = 10
      Top = 27
      Width = 170
      Height = 21
      TabOrder = 0
    end
    object edtQueryValue: TEdit
      Left = 202
      Top = 27
      Width = 170
      Height = 21
      TabOrder = 1
    end
  end
end
