program proyjuego;

uses
  Vcl.Forms,
  juego in 'juego.pas' {pantalla},
  objetos in 'objetos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tpantalla, pantalla);
  Application.Run;
end.
