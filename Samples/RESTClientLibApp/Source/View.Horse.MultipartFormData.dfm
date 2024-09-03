inherited frmViewHorseMultipartFormData: TfrmViewHorseMultipartFormData
  Caption = 'View Horse MultipartFormData'
  OldCreateOrder = True
  OnDestroy = FormDestroy
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
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
      end
    end
    inherited gbxRequestURL: TGroupBox
      inherited edtRequestResource: TButtonedEdit
        Text = 'form-data'
      end
    end
  end
  inherited gbxResponse: TGroupBox
    inherited pgcResponseBody: TPageControl
      inherited tbsResponseBody: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 31
        ExplicitWidth = 1255
        ExplicitHeight = 188
      end
      inherited tbsResponseHeaders: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 31
        ExplicitWidth = 1255
        ExplicitHeight = 188
      end
      inherited tbsResponseCookies: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 31
        ExplicitWidth = 1255
        ExplicitHeight = 188
      end
    end
  end
end
