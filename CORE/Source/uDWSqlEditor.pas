{
 Esse editor SQL foi desenvolvido para integrar mais um recurso ao pacote de
 componentes REST Dataware, a intenção é ajudar na produtividade.
 Desenvolvedor : Julio César Andrade dos Anjos
 Data : 19/02/2018
}

unit uDWSqlEditor;

interface

uses
  SysUtils, Dialogs, Forms, ExtCtrls, StdCtrls, ComCtrls, DBGrids, uRESTDWPoolerDB, DB{$IFNDEF FPC}, Grids{$ENDIF}, Controls,
  Classes;

 Type
  TFrmDWSqlEditor = class(TForm)
    PnlSQL: TPanel;
    PnlButton: TPanel;
    BtnExecute: TButton;
    PageControl: TPageControl;
    TabSheetSQL: TTabSheet;
    Memo: TMemo;
    PnlAction: TPanel;
    BtnOk: TButton;
    BtnCancelar: TButton;
    Splitter1: TSplitter;
    PageControlResult: TPageControl;
    TabSheetTable: TTabSheet;
    DBGridRecord: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnExecuteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
 Private
  { Private declarations }
  DataSource : TDataSource;
 Public
  { Public declarations }
  RESTDWClientSQL : TRESTDWClientSQL;
 End;

Implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

Procedure TFrmDWSqlEditor.BtnExecuteClick(Sender: TObject);
Begin
 Screen.Cursor := crHourGlass;
 Try
  RESTDWClientSQL.Close;
  RESTDWClientSQL.SQL.Clear;
  RESTDWClientSQL.SQL.Add(Memo.Lines.Text);
  RESTDWClientSQL.Open;
 Finally
  Screen.Cursor := crDefault;
 End;
End;

Procedure TFrmDWSqlEditor.FormCreate(Sender: TObject);
Begin
 RESTDWClientSQL := TRESTDWClientSQL.Create(Self);
 DataSource := TDataSource.Create(Self);
 DataSource.DataSet := RESTDWClientSQL;
 DBGridRecord.DataSource := DataSource;
End;

procedure TFrmDWSqlEditor.FormDestroy(Sender: TObject);
Begin
 RESTDWClientSQL.DataBase := nil;
 FreeAndNil(DataSource);
 FreeAndNil(RESTDWClientSQL);
End;

procedure TFrmDWSqlEditor.FormShow(Sender: TObject);
begin
 PnlButton.Visible         := RESTDWClientSQL.DataBase <> Nil;
 Splitter1.Visible         := PnlButton.Visible;
 PageControlResult.Visible := Splitter1.Visible;
end;

end.
