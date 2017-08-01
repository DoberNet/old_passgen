program passgen;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Generator},
  Unit2 in 'Unit2.pas' {about},
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Password generator By Dober';
  Application.CreateForm(TGenerator, Generator);
  Application.CreateForm(Tabout, about);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
