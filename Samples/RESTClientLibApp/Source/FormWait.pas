unit FormWait;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmWait = class(TFrame)
    pnlLeft: TPanel;
    pnlIndicator: TPanel;
    actIndicator: TActivityIndicator;
    pnlMessage: TPanel;
    lblMessage: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
