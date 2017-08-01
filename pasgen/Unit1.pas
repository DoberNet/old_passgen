unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Grids, ValEdit, jpeg;

type
  TGenerator = class(TForm)
    MainMenu1: TMainMenu;
    yyyyy1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    Gen: TTimer;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ValueListEditor1: TValueListEditor;
    hron: TTimer;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N5: TMenuItem;
    N7: TMenuItem;
    CheckBox4: TCheckBox;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    procedure N3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function LockAll():Boolean;
    function UnLockAll():Boolean;
    procedure GenTimer(Sender: TObject);
    function Generate(Num, UpCase, LowCase, SY:Boolean):String;
    procedure Button2Click(Sender: TObject);
    procedure Coder(var text: string; password: string;decode: boolean);
    procedure N2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure hronTimer(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Generator: TGenerator;
  Pass:string;
  DL:integer;
  Passds:TStrings;
  Passwd:string;
  CP, Sh:integer;
  PL:integer;
  FN:string;
  Symb:array[1..19] of string=(']', '[', '?', '/', '~', '#', '`', '!', '@', '$', '^', '&', '*', '+', '=', '|', ':', ';', '>');

implementation

{$R *.dfm}

uses
Unit2,
Unit4;

procedure TGenerator.Button1Click(Sender: TObject);
begin
  if not CheckBox1.Checked and not CheckBox2.Checked and not CheckBox3.Checked and not CheckBox4.Checked then
  Application.MessageBox('Выбери хоть что нить!','Ничто не выбрано!',0)
  else
  begin
    Pass:='';
    DL:=0;
    LockAll;
    Gen.Enabled:=true;
  end;
end;

procedure TGenerator.Button2Click(Sender: TObject);
begin
  if Pass<>'' then
  begin
    ValueListEditor1.Strings.Add('Это можно изменить='+Pass);
  end;
end;

procedure TGenerator.Button3Click(Sender: TObject);
begin
  Sh:=1-Sh;
  if Sh=0 then
  begin
    //ValueListEditor1.Visible:=false;
    Button3.Enabled:=false;
    hron.Enabled:=true;
    Button3.Caption:='Открыть >>';
  end;
  if Sh=1 then
  begin
    Button3.Caption:='<< Закрыть';
    Button3.Enabled:=false;
    hron.Enabled:=true;
    ValueListEditor1.Visible:=True;
  end;
end;

procedure TGenerator.Coder(var text: string; password: string; decode: boolean);
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

procedure TGenerator.ComboBox1Exit(Sender: TObject);
begin
  if StrToInt(ComboBox1.Text)<4 then
  ComboBox1.Text:='4';
  if StrToInt(ComboBox1.Text)>200 then
  ComboBox1.Text:='200';
end;

procedure TGenerator.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#46]) then
  Key:=#0;
end;

procedure TGenerator.FormCreate(Sender: TObject);
var
Load:String;
i:integer;
begin
  FN:='';
  Generator.Width:=213;
  Passds:=TStringList.Create;
  for i:=4 to 100 do
  ComboBox1.Items.Add(IntToStr(i));
end;

function TGenerator.Generate(Num, UpCase, LowCase, SY: Boolean): String;
var
Outp:string;
R:integer;
label
Rl;
begin
  Outp:='';
  Rl:
  R:=1+Random(4);

  if R=1 then
  if Num then
  Outp:=IntToStr(Random(10))
  else
  Goto Rl;

  if R=2 then
  if UpCase then
  Outp:=AnsiUpperCase(Char(1+(65+Random(90-65))))
  else
  Goto Rl;

  if R=3 then
  if LowCase then
  Outp:=AnsiLowerCase(Char(1+(65+Random(90-65))))
  else
  Goto Rl;

  if R=4 then
  if SY then
  Outp:=Symb[1+Random(Length(Symb))]
  else
  Goto Rl;

  //Result:=Char(1+(65+Random(90-65)));
  Result:=Outp;
  //Result:=IntToStr(Random(10));
end;

procedure TGenerator.GenTimer(Sender: TObject);
begin
  DL:=DL+1;
  Pass:=Pass+Generate(CheckBox1.Checked,CheckBox2.Checked,CheckBox3.Checked,CheckBox4.Checked);
  if DL=StrToInt(ComboBox1.Text) then
  begin
    Edit1.Text:=Pass;
    Gen.Enabled:=false;
    UnLockAll;
  end;
end;

procedure TGenerator.hronTimer(Sender: TObject);
var
width:integer;
begin
  width:=Generator.Width;
  if Sh=1 then
  begin
    if width<578 then
    begin
      width:=width+5;
      Generator.Width:=width;
    end
    else
    begin
      hron.Enabled:=False;
      Generator.Width:=578;
      Button3.Enabled:=True;
    end;
  end;
  if Sh=0 then
  begin
    if width>213 then
    begin
      width:=width-5;
      Generator.Width:=width;
    end
    else
    begin
      ValueListEditor1.Visible:=false;
      hron.Enabled:=False;
      Generator.Width:=213;
      Button3.Enabled:=True;
    end;
  end;
end;

function TGenerator.LockAll: Boolean;
begin
  Edit1.Enabled:=false;
  ComboBox1.Enabled:=false;
  Button1.Enabled:=false;
  GroupBox1.Enabled:=false;
  Button2.Enabled:=false;
end;

procedure TGenerator.N1Click(Sender: TObject);
var
Load:string;
CSP:integer;
label
SF;
begin
  if OpenDialog1.Execute then
   begin
     FN:=OpenDialog1.FileName;
     Passds.LoadFromFile(FN,TEncoding.UTF8);//('svpf.spd');
     SF:
     CP:=0;
     Form4.Caption:='Введите пароль!';
     Form4.ShowModal;
     Load:=Passds.Text;
     Coder(Load,Passwd,true);
     CSP:=Pos('{SP:MouseFuck}',Load);
     if CSP=0 then
     begin
       if CP=1 then
       begin
         Application.MessageBox('Пароль неверен!','Шифратор',MB_ICONERROR);
         Goto SF;
       end
     end;
     if CSP<>0 then
     begin
       Delete(Load,CSP,length(Load));
       ValueListEditor1.Strings.Text:=Load;//Memo1.Text:=Fuck;
       //ValueListEditor1.DeleteRow(ValueListEditor1.RowCount-1);

       Button3.Enabled:=true;
       Button1.Enabled:=true;
       N7.Enabled:=true;
       N2.Enabled:=true;
     end;
   end;
end;

procedure TGenerator.N2Click(Sender: TObject);
var
Save:String;
begin
  if ValueListEditor1.Strings.Text='' then
    Application.MessageBox('Что пусто так в таблице?','Таблица паролей',MB_ICONINFORMATION)
  else
  begin
    if FN='' then
    begin
      SaveDialog1.FileName:='svpf';
      if SaveDialog1.Execute then
      begin
        FN:=SaveDialog1.FileName;
        Form4.Caption:='Установите пароль!';
        Form4.ShowModal;
        Save:=ValueListEditor1.Strings.Text;//Memo1.Text;
        Save:=Save+'{SP:MouseFuck}';
        Coder(Save,Passwd,false);
        Passds.Text:=Save;
        Passds.SaveToFile(FN,TEncoding.UTF8);
      end;
    end;
    if FN<>'' then
    begin
      Form4.Caption:='Установите пароль!';
      Form4.ShowModal;
      Save:=ValueListEditor1.Strings.Text;//Memo1.Text;
      Save:=Save+'{SP:MouseFuck}';
      Coder(Save,Passwd,false);
      Passds.Text:=Save;
      Passds.SaveToFile(FN,TEncoding.UTF8);
    end;
  end;
end;

procedure TGenerator.N3Click(Sender: TObject);
begin
  close;
end;

procedure TGenerator.N5Click(Sender: TObject);
begin
FN:='';
ValueListEditor1.Strings.Clear;
Button3.Enabled:=true;
Button1.Enabled:=true;
N7.Enabled:=true;
N2.Enabled:=true;
end;

procedure TGenerator.N6Click(Sender: TObject);
begin
  about.ShowModal;
end;

procedure TGenerator.N7Click(Sender: TObject);
var
Save:string;
begin
  SaveDialog1.FileName:='svpf';
  if SaveDialog1.Execute then
  begin
    FN:=SaveDialog1.FileName;
    Form4.Caption:='Установите пароль!';
    Form4.ShowModal;
    Save:=ValueListEditor1.Strings.Text;//Memo1.Text;
    Save:=Save+'{SP:MouseFuck}';
    Coder(Save,Passwd,false);
    Passds.Text:=Save;
    Passds.SaveToFile(FN,TEncoding.UTF8);
  end;
end;

function TGenerator.UnLockAll: Boolean;
begin
Edit1.Enabled:=true;
ComboBox1.Enabled:=true;
GroupBox1.Enabled:=true;
Button1.Enabled:=true;
Button2.Enabled:=true;
end;

end.
