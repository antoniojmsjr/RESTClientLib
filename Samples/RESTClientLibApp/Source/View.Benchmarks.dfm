inherited frmViewBenchmarks: TfrmViewBenchmarks
  Caption = 'frmViewBenchmarks'
  ClientHeight = 510
  ClientWidth = 1144
  ExplicitTop = 2
  ExplicitWidth = 1144
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbxRequestURL: TGroupBox
    Width = 1138
    ExplicitTop = 76
    ExplicitWidth = 1138
  end
  inherited pnlClient: TPanel
    Width = 1144
    Height = 290
    ExplicitTop = 149
    ExplicitWidth = 1144
    ExplicitHeight = 290
    inherited gbxNetHTTP: TGroupBox
      Height = 284
      ExplicitHeight = 294
      inherited pnlNetHTTPFooter: TPanel
        Top = 242
        ExplicitTop = 252
      end
      inherited dbgNetHTTP: TDBGrid
        Height = 221
      end
    end
    inherited gbxIndy: TGroupBox
      Height = 284
      ExplicitHeight = 294
      inherited pnlIndyFooter: TPanel
        Top = 242
        ExplicitTop = 252
      end
      inherited dbgIndy: TDBGrid
        Height = 221
      end
    end
    inherited gbxSynapse: TGroupBox
      Height = 284
      ExplicitHeight = 294
      inherited pnlSynapseFooter: TPanel
        Top = 242
        ExplicitTop = 252
      end
      inherited dbgSynapse: TDBGrid
        Height = 221
      end
    end
  end
  inherited pnlRequestExecute: TPanel
    Top = 439
    Width = 1144
    ExplicitTop = 449
    ExplicitWidth = 1144
    inherited bvlRequestExecuteTop: TBevel
      Width = 1138
      ExplicitWidth = 1138
    end
    inherited bvlRequestExecuteBottom: TBevel
      Width = 1144
      ExplicitWidth = 1144
    end
    inherited btnRequestExecute: TBitBtn
      Left = 934
      ExplicitLeft = 934
    end
  end
  inherited pnlBottom: TPanel
    Top = 496
    Width = 1144
    ExplicitTop = 506
    ExplicitWidth = 1144
    inherited gbxNetHTTPTotalizer: TGroupBox
      ExplicitHeight = 224
      inherited pnlNetHTTPTotalizer: TPanel
        ExplicitTop = 182
      end
    end
    inherited gbxIndyTotalizer: TGroupBox
      ExplicitHeight = 224
      inherited pnlIndyTotalizer: TPanel
        ExplicitTop = 182
      end
    end
    inherited gbxSynapseTotalizer: TGroupBox
      ExplicitHeight = 224
      inherited pnlSynapseTotalizer: TPanel
        ExplicitTop = 182
      end
    end
  end
  inherited gbxSettings: TGroupBox
    Width = 1138
    ExplicitWidth = 1138
  end
end
