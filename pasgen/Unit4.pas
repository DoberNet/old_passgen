unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
Unit1;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
LP:integer;
begin
  LP:=length(Edit1.Text);
  if LP<4 then
  Application.MessageBox('Маловат пароль!','Шифрователь',MB_ICONINFORMATION);
  if LP>=4 then
  begin
    Passwd:=Edit1.Text;
    CP:=1;
    close;
  end;
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
  if not CheckBox1.Checked then
  Edit1.PasswordChar:='*'
  else
  Edit1.PasswordChar:=#0
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if Key in [#13] then
Button1.Click;
end;

end.
