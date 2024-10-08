object frmMultipartFormDataAddFile: TfrmMultipartFormDataAddFile
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MultipartFormData - Add File'
  ClientHeight = 121
  ClientWidth = 619
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 619
    Height = 121
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlHeader'
    ShowCaption = False
    TabOrder = 0
    object lblField: TLabel
      Left = 10
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Field'
    end
    object lblFile: TLabel
      Left = 10
      Top = 65
      Width = 16
      Height = 13
      Caption = 'File'
    end
    object btnAdd: TSpeedButton
      Left = 535
      Top = 79
      Width = 70
      Height = 30
      Caption = 'Add'
      Enabled = False
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
    object edtField: TEdit
      Left = 10
      Top = 27
      Width = 200
      Height = 21
      TabOrder = 0
      OnExit = edtFieldExit
      OnKeyPress = edtFieldKeyPress
    end
    object edtFile: TEdit
      Left = 10
      Top = 84
      Width = 511
      Height = 21
      TabOrder = 1
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Any file (*.*)|*.*'
    Title = 'Select File'
    Left = 240
    Top = 8
  end
end
