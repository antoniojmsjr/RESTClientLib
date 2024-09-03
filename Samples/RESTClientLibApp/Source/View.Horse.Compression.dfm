inherited frmViewHorseCompression: TfrmViewHorseCompression
  Caption = 'View Horse Compression'
  ClientHeight = 642
  ClientWidth = 814
  ExplicitWidth = 814
  ExplicitHeight = 642
  PixelsPerInch = 96
  TextHeight = 13
  inherited splMain: TSplitter
    Top = 295
    Width = 808
    ExplicitTop = 295
    ExplicitWidth = 808
  end
  inherited gbxRequest: TGroupBox
    Width = 806
    Height = 208
    ExplicitWidth = 806
    ExplicitHeight = 208
    inherited pnlRequestExecute: TPanel
      Top = 156
      Width = 802
      ExplicitTop = 156
      ExplicitWidth = 802
      inherited bvlRequestExecute: TBevel
        Width = 796
        ExplicitWidth = 796
      end
      inherited btnRequestExecute: TBitBtn
        Left = 592
        ExplicitLeft = 592
      end
      inherited ckbRequestExecuteThread: TCheckBox
        Left = 508
        ExplicitLeft = 508
      end
    end
    inherited gbxRequestBody: TGroupBox
      Width = 796
      Height = 59
      ExplicitWidth = 796
      ExplicitHeight = 59
    end
    inherited gbxRequestURL: TGroupBox
      Width = 796
      ExplicitWidth = 796
      inherited edtRequestResource: TButtonedEdit
        Text = 'compression'
      end
    end
  end
  inherited gbxResponse: TGroupBox
    Top = 310
    Width = 806
    Height = 329
    ExplicitTop = 310
    ExplicitWidth = 806
    ExplicitHeight = 329
    inherited pnlResponseStatus: TPanel
      Width = 796
      ExplicitWidth = 796
    end
    inherited pgcResponseBody: TPageControl
      Width = 802
      Height = 266
      ExplicitWidth = 802
      ExplicitHeight = 266
      inherited tbsResponseBody: TTabSheet
        ExplicitLeft = 0
        ExplicitWidth = 794
        ExplicitHeight = 231
        object lblStatus: TLabel [0]
          AlignWithMargins = True
          Left = 3
          Top = 215
          Width = 3
          Height = 13
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        inherited gbxResponseBinary: TGroupBox
          Width = 788
          ExplicitWidth = 788
        end
        object mmoResponseBody: TMemo
          Left = 0
          Top = 55
          Width = 794
          Height = 157
          Align = alClient
          BorderStyle = bsNone
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          ExplicitLeft = 3
          ExplicitTop = -28
          ExplicitHeight = 176
        end
      end
      inherited tbsResponseHeaders: TTabSheet
        ExplicitWidth = 794
        ExplicitHeight = 231
        inherited mmoResponseHeaders: TMemo
          Width = 788
          Height = 225
          ExplicitWidth = 788
          ExplicitHeight = 225
        end
      end
      inherited tbsResponseCookies: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 31
        ExplicitWidth = 794
        ExplicitHeight = 231
        inherited mmoResponseCookies: TMemo
          Width = 788
          Height = 225
          ExplicitWidth = 788
          ExplicitHeight = 225
        end
      end
    end
  end
  inherited gbxSettings: TGroupBox
    Width = 806
    ExplicitWidth = 806
  end
end
