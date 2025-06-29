program proyjuego;

uses
  Vcl.Forms,
  juego in 'juego.pas' {pantalla},
  objetos in 'objetos.pas',
  ClasePersonaje in 'ClasePersonaje.pas',
  BloqueoClase in 'BloqueoClase.pas',
  ClaseBala in 'ClaseBala.pas',
  ClaseEnemigo in 'ClaseEnemigo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tpantalla, pantalla);
  Application.Run;
end.
