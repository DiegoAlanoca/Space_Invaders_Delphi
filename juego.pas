unit juego;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,JPEG, Vcl.StdCtrls, Vcl.ExtCtrls,PngImage,ClasePersonaje,
  BloqueoClase,ClaseEnemigo, Vcl.MPlayer,ClaseBala;
const VelocidadBalaJugador=8; CantEnemigosColumnas=11;CantEnemigosFilas=5;
DistanciaHorzEnem=150; DistanciaFilEnem=90;
type
  Tpantalla = class(TForm)
    Label1: TLabel;
    TimerPersonaje: TTimer;
    TimerEnemigosYBalas: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerPersonajeTimer(Sender: TObject);
    procedure TimerEnemigosYBalasTimer(Sender: TObject);
  private
    IzqPers,DerPers:Boolean; AnchoPantalla,LargoPantalla:Word;
    fondo: TJPEGIMage;
    p:Personaje;
    contdes:Word;
    barrera:Array of TBloqueo;
    barrera2:Array of TBloqueo;
    barrera3:Array of TBloqueo;
    barrera4:Array of TBloqueo;
    EnemigosAliens:Array of enemigo;
    BalaJugador:TBala;
    procedure crearbarrera(colum,filas,tam,posx,posy:Word);
    procedure CrearEnemigos(PosIX,PosIY:Word);

  public
    { Public declarations }
  end;

var
  pantalla: Tpantalla;
  bloqueo:TBloqueo;
implementation

{$R *.dfm}

procedure Tpantalla.crearbarrera(colum,filas,tam,posx,posy:Word);
var
  i,j,index,posxtemp:Word;
begin
  index:=0;
  SetLength(barrera,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
  index:=0; posx:=posx+400;
  SetLength(barrera2,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera2[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
  index:=0; posx:=posx+400;
  SetLength(barrera3,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera3[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
  index:=0; posx:=posx+400;
  SetLength(barrera4,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera4[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
end;


procedure Tpantalla.CrearEnemigos(PosIX, PosIY: Word);
var I,J,Itemp,PosicionYActual,DistanciaEnemXActual: Integer;
rutaimagen:String;
begin
  SetLength(EnemigosAliens,CantEnemigosColumnas*CantEnemigosFilas);
  PosicionYActual:=PosIY; I:=1;
  for J:=1 to CantEnemigosFilas do
  begin
    case J of
      1:rutaimagen:='enemigos\alien1.png';
      2:rutaimagen:='enemigos\alien2.png';
      3:rutaimagen:='enemigos\alien2.png';
      4:rutaimagen:='enemigos\alien3.png';
      5:rutaimagen:='enemigos\alien3.png';
    end;
    Itemp:=I+CantEnemigosColumnas; DistanciaEnemXActual:=PosIX;
    repeat
      EnemigosAliens[I-1]:=enemigo.Create;
      EnemigosAliens[I-1].CargarImagen(rutaimagen);
      EnemigosAliens[I-1].x:=DistanciaEnemXActual-(EnemigosAliens[I-1].Ancho div 2);
      EnemigosAliens[I-1].y:=PosicionYActual;
      DistanciaEnemXActual:=DistanciaEnemXActual+DistanciaHorzEnem;
      Inc(I);
    until I=Itemp;
    PosicionYActual:=PosicionYActual+DistanciaFilEnem;

  end;
end;

procedure Tpantalla.FormCreate(Sender: TObject);
begin
  AnchoPantalla:=Screen.Width;
  LargoPantalla:=Screen.Height;
  p:=Personaje.Create; p.x:=(AnchoPantalla div 2)-(p.Ancho div 2); p.y:=LargoPantalla-200;
  p.CargarImagen('personaje.png');
  fondo:=TJPEGIMage.Create;
  DoubleBuffered:=True; keypreview:=True;
  showcursor(False);
  fondo.LoadFromFile('fondo.jpg');
  crearbarrera(12,6,10,300,p.y-110);
  CrearEnemigos(200,100);
  contdes:=0;
  BalaJugador:=TBala.Create(VelocidadBalaJugador);
  BalaJugador.CargarImagen('bala.png');
end;

procedure Tpantalla.FormDblClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tpantalla.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:Word;
begin
  case key of
    37: IzqPers:=True;
    39: DerPers:=True;
    ord('A'):begin
              if not BalaJugador.Vivo then
              begin
                BalaJugador.Vivo:=True;
                BalaJugador.x:=p.x+(p.Ancho div 2)-6;
                BalaJugador.y:=p.y;
              end;
              end;
    ord('F'):
    begin
      barrera[contdes].Destruir;
      barrera2[contdes].Destruir;
      inc(contdes);
      Exit;
    end;
  end;
  Invalidate;
end;

procedure Tpantalla.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    37:IzqPers:=False;
    39:DerPers:=False;
  end;
end;

procedure Tpantalla.FormPaint(Sender: TObject);
var i:Word;
begin
  Canvas.StretchDraw(Rect(0,0,Screen.Width,Screen.Height),fondo);
  Canvas.Draw(p.x,p.y,p.Imagen);
  for i:=0 to High(barrera) do
    barrera[i].Dibujar(Canvas);
  for i:=0 to High(barrera2) do
    barrera2[i].Dibujar(Canvas);
  for i:=0 to High(barrera3) do
    barrera3[i].Dibujar(Canvas);
  for i:=0 to High(barrera4) do
    barrera4[i].Dibujar(Canvas);

  for I:=0 to (CantEnemigosColumnas*CantEnemigosFilas)-1 do
    if EnemigosAliens[I].Vivo then
      Canvas.Draw(EnemigosAliens[I].x,EnemigosAliens[I].y,EnemigosAliens[I].Imagen);


  if BalaJugador.Vivo then Canvas.Draw(BalaJugador.x,BalaJugador.y,BalaJugador.Imagen);

end;

procedure Tpantalla.TimerEnemigosYBalasTimer(Sender: TObject);
var I,J:Integer;
begin
   if (BalaJugador.Vivo)and(BalaJugador.y>1) then BalaJugador.y:=BalaJugador.y-10
  else BalaJugador.Vivo:=False;

  for I:=0 to (CantEnemigosColumnas*CantEnemigosFilas)-1 do
  begin
    if (BalaJugador.y<=EnemigosAliens[I].y)and
    (BalaJugador.x>=EnemigosAliens[I].x)and(BalaJugador.x<=EnemigosAliens[I].ancho+EnemigosAliens[I].x)
    and(BalaJugador.Vivo)and(EnemigosAliens[I].Vivo)
    then
    begin
      EnemigosAliens[I].Vivo:=False;
      BalaJugador.Vivo:=False;
    end;
  end;

end;

procedure Tpantalla.TimerPersonajeTimer(Sender: TObject);
begin
  if (IzqPers)and(p.x>(p.Ancho div 2)-50) then p.x:=p.x-10;
  if (DerPers)and(p.x+p.Ancho<AnchoPantalla) then p.x:=p.x+10;
  Repaint;
end;

end.
