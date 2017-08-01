unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ValEdit, StdCtrls;

type
  THron = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ValueListEditor1: TValueListEditor;
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Coder(var text: string; password: string;decode: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {сука тупая как я заебался}
var
  Hron: THron;
  Passds:TStrings;
  Passwd:string;
  //F:TextFile;

implementation

{$R *.dfm}

uses
Unit1, Unit2;

procedure THron.Coder(var text: string; password: string; decode: boolean);
var
  i, PasswordLength: integer;
  sign: shortint;
begin
  PasswordLength := length(password);
  if PasswordLength = 0 then
    Exit;
  if decode then
    sign := -1
  else
    sign := 1;
  for i := 1 to Length(text) do
    text[i] := chr(ord(text[i]) + sign * ord(password[i mod PasswordLength + 1]));
end;

procedure THron.FormCreate(Sender: TObject);
var
Fuck:string;
begin
  Passds:=TStringList.Create;
  Passwd:='DoljhnoBcePobuTb';
  if FileExists('svpf.spd') then
  begin
    //ValueListEditor1.Strings.LoadFromFile('svpf.spd');
    Passds.LoadFromFile('svpf.spd',TEncoding.UTF8);//('svpf.spd');
    Fuck:=Passds.Text;
    Coder(Fuck,Passwd,true);
    ValueListEditor1.Strings.Text:=Fuck;//Memo1.Text:=Fuck;
    ValueListEditor1.DeleteRow(ValueListEditor1.RowCount-1);
end;
end;

procedure THron.N3Click(Sender: TObject);
var
Suck:string;
begin
  Suck:=ValueListEditor1.Strings.Text;//Memo1.Text;
  Coder(Suck,Passwd,false);
  Passds.Text:=Suck;
  Passds.SaveToFile('svpf.spd',TEncoding.UTF8);
  //ValueListEditor1.Strings.SaveToFile('svpf.spd');
end;

procedure THron.N4Click(Sender: TObject);
begin
Close;
end;

procedure THron.N6Click(Sender: TObject);
begin
Generator.Show;
end;

procedure THron.N7Click(Sender: TObject);
begin
about.ShowModal;
end;

end.
