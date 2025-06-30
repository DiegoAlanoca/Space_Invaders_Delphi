unit juego;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,JPEG, Vcl.StdCtrls, Vcl.ExtCtrls,PngImage,ClasePersonaje,
  BloqueoClase,ClaseEnemigo, Vcl.MPlayer,ClaseBala;
const VelocidadBalaJugador=40; CantEnemigosColumnas=11;CantEnemigosFilas=5;
DistanciaHorzEnem=110; DistanciaFilEnem=70; Velocidad_Enemigo=3; //Impar por proporcion
DistanciaFilBajadasMovimiento=4; MargenMovimientoHorzAlien=50;

EspaciadoHorzBarreras=400; PosicionX_Inicial_barreras=300; Columnas_Barrera=12; Filas_Barrera=6;
TamBloqBarrera=10;
type
  Tpantalla = class(TForm)
    Label1: TLabel;
    TimerPersonaje: TTimer;
    TimerEnemigosYBalas: TTimer;
    TPlayerMusFondo: TMediaPlayer;
    Colisiones: TTimer;
    score: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerPersonajeTimer(Sender: TObject);
    procedure TimerEnemigosYBalasTimer(Sender: TObject);
    procedure ColisionesTimer(Sender: TObject);
    procedure TPlayerMusFondoNotify(Sender: TObject);
  private
    IzqPers,DerPers:Boolean; AnchoPantalla,LargoPantalla,ContadorScore:Word;
    fondo: TJPEGIMage;
    p:Personaje;
    contdes,PosicionYIBarrera:Word;
    barrera:Array of TBloqueo;
    barrera2:Array of TBloqueo;
    barrera3:Array of TBloqueo;
    barrera4:Array of TBloqueo;
    EnemigosAliens:Array of enemigo;
    BalaJugador:TBala;
    CantBalasEnemigasEnPant:Word;
    BalasEnemigos:Array of TBala;
    DireccionDerechaAliens:Boolean;
    procedure crearbarrera(colum,filas,tam,posx,posy:Word);
    procedure CrearEnemigos(PosIX,PosIY:Word);
    procedure CrearBalasEnemigos;
    procedure VerificarColisionesBarrerasSuperior;
    procedure VerificarColisionesBarrerasInferior;
    procedure MovimientoDeAliens;
  public
    { Public declarations }
  end;

var
  pantalla: Tpantalla;
  bloqueo:TBloqueo;
implementation

{$R *.dfm}

procedure Tpantalla.CrearBalasEnemigos;
var I,J,VelocidadBalaEnemigos: Integer;
begin
  Randomize;
  CantBalasEnemigasEnPant:=Random(6)+1;
  Setlength(BalasEnemigos,CantBalasEnemigasEnPant);
  I:=0;
  while I<length(BalasEnemigos) do
  begin
    Randomize; J:=Random(CantEnemigosColumnas*CantEnemigosFilas-1);
    VelocidadBalaEnemigos:=Random(40)+1;
    if EnemigosAliens[J].Vivo then
    begin
      BalasEnemigos[I]:=TBala.create(VelocidadBalaEnemigos);
      BalasEnemigos[I].CargarImagen('bala.png');
      BalasEnemigos[I].NroJugadorAsignado:=J;
      BalasEnemigos[I].x:=EnemigosAliens[J].x+(EnemigosAliens[J].Ancho div 2);
      BalasEnemigos[I].y:=EnemigosAliens[J].y;
      BalasEnemigos[I].Vivo:=True;
      Inc(I);
    end;
  end;
end;

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
  index:=0; posx:=posx+EspaciadoHorzBarreras;
  SetLength(barrera2,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera2[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
  index:=0; posx:=posx+EspaciadoHorzBarreras;
  SetLength(barrera3,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera3[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
  index:=0; posx:=posx+EspaciadoHorzBarreras;
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
      case J of
       1:EnemigosAliens[I-1].Valor:=30;
       2:EnemigosAliens[I-1].Valor:=20;
       3:EnemigosAliens[I-1].Valor:=20;
       4:EnemigosAliens[I-1].Valor:=10;
       5:EnemigosAliens[I-1].Valor:=10;
      end;
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
  PosicionYIBarrera:=p.y-110;
  crearbarrera(Columnas_Barrera,Filas_Barrera,TamBloqBarrera,PosicionX_Inicial_barreras,PosicionYIBarrera);
  CrearEnemigos(400,150);
  contdes:=0;
  BalaJugador:=TBala.Create(VelocidadBalaJugador);
  BalaJugador.CargarImagen('bala.png');
  CrearBalasEnemigos;
  DireccionDerechaAliens:=True;
  ContadorScore:=0;
  try
    TPlayerMusFondo.FileName := 'sonidos\Background.mp3';
    TPlayerMusFondo.Open;
    TPlayerMusFondo.Notify := True;
    TPlayerMusFondo.OnNotify := TPlayerMusFondoNotify;
    TPlayerMusFondo.Play;
    except
    on E: Exception do
      ShowMessage('Error al cargar la música de fondo: ' + E.Message);
  end;
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
    37: if (p.Vivo) then IzqPers:=True;
    39: if (p.Vivo) then DerPers:=True;
    ord('A'):begin
              if (not BalaJugador.Vivo)and(p.Vivo) then
              begin
                BalaJugador.Vivo:=True;
                BalaJugador.x:=p.x+(p.Ancho div 2)-6;
                BalaJugador.y:=p.y;
              end;
              end;
    ord('V'):begin
              if not p.Vivo then
                p.Vivo:=True;
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

  for I:=0 to Length(BalasEnemigos)-1 do
    if (BalasEnemigos[I].Vivo)
    then Canvas.Draw(BalasEnemigos[I].x,BalasEnemigos[I].y,BalasEnemigos[I].Imagen);

end;

procedure Tpantalla.MovimientoDeAliens;
var i,movimientoX, movimientoY:Integer; tocoElBorde: Boolean;
begin
  tocoElBorde := False;
  for i := 0 to High(EnemigosAliens) do
  begin
    if EnemigosAliens[i].Vivo then
    begin
      if (EnemigosAliens[i].x + EnemigosAliens[i].Ancho >= AnchoPantalla-MargenMovimientoHorzAlien) and
      (DireccionDerechaAliens) then
      begin
        tocoElBorde := True;
        break;
      end;
      if (EnemigosAliens[i].x <= MargenMovimientoHorzAlien) and (not DireccionDerechaAliens) then
      begin
        tocoElBorde := True;
        break;
      end;
    end;
  end;

  if tocoElBorde then
  begin
    DireccionDerechaAliens := not DireccionDerechaAliens;
    movimientoY := DistanciaFilBajadasMovimiento;
  end
  else
  begin
    movimientoY := 0;
  end;
  if DireccionDerechaAliens then
    movimientoX := Velocidad_Enemigo
  else
    movimientoX := -Velocidad_Enemigo;

  for i := 0 to High(EnemigosAliens) do
  begin
    if EnemigosAliens[i].Vivo then
    begin
      EnemigosAliens[i].x := EnemigosAliens[i].x + movimientoX;
      EnemigosAliens[i].y := EnemigosAliens[i].y + movimientoY;
    end;
  end;
end;


procedure Tpantalla.TimerEnemigosYBalasTimer(Sender: TObject);
var I,J:Integer; BanBalasTodas,TodosEnemVivos:Boolean;
begin
  if (BalaJugador.Vivo)and(BalaJugador.y>1) then BalaJugador.y:=BalaJugador.y-VelocidadBalaJugador
  else BalaJugador.Vivo:=False;

  for I:=0 to CantBalasEnemigasEnPant-1 do
  if (BalasEnemigos[I].Vivo)and(BalasEnemigos[I].y<LargoPantalla) then BalasEnemigos[I].y:=BalasEnemigos[I].y+10
  else BalasEnemigos[I].Vivo:=False;

  for I:=0 to length(BalasEnemigos)-1 do
    if BalasEnemigos[I].Vivo then
    begin
      BanBalasTodas:=True;
      Break;
    end
    else BanBalasTodas:=False;
  if BanBalasTodas=False then CrearBalasEnemigos;

  MovimientoDeAliens;

  for I:=0 to High(EnemigosAliens) do
    if EnemigosAliens[I].Vivo then
    begin
      TodosEnemVivos:=True;
      Break;
    end
    else TodosEnemVivos:=False;

  if TodosEnemVivos=False then
  begin
    Application.Terminate;
    Showmessage('GANASTE');
  end;
end;

procedure Tpantalla.TimerPersonajeTimer(Sender: TObject);
begin
  if (IzqPers)and(p.x>(p.Ancho div 2)-50) then p.x:=p.x-10;
  if (DerPers)and(p.x+p.Ancho<AnchoPantalla) then p.x:=p.x+10;
  Repaint;
  Update;
end;

procedure Tpantalla.TPlayerMusFondoNotify(Sender: TObject);
var mp: TMediaPlayer;
begin
  mp := Sender as TMediaPlayer;
  if mp.NotifyValue = nvSuccessful then
  begin
    mp.Position := 0;
    mp.Play;
    mp.Notify := True;
  end;
end;

procedure Tpantalla.ColisionesTimer(Sender: TObject);
var I:Integer;
begin
  for I:=0 to (CantEnemigosColumnas*CantEnemigosFilas)-1 do
  begin
    if (BalaJugador.y<=EnemigosAliens[I].y)and
    (BalaJugador.x>=EnemigosAliens[I].x)and(BalaJugador.x<=EnemigosAliens[I].ancho+EnemigosAliens[I].x)
    and(BalaJugador.Vivo)and(EnemigosAliens[I].Vivo)
    then
    begin
      EnemigosAliens[I].Vivo:=False;
      ContadorScore:=ContadorScore+EnemigosAliens[I].Valor;
      score.Caption:=IntToStr(ContadorScore);
      BalaJugador.Vivo:=False;
    end;
  end;

  if p.Vivo then
  begin
    for I:=0 to length(BalasEnemigos) - 1 do
    begin
      if BalasEnemigos[I].Vivo then
      begin
        if (BalasEnemigos[I].y <= p.y + p.Alto) and
           (BalasEnemigos[I].y + BalasEnemigos[I].alto >= p.y) and
           (BalasEnemigos[I].x + BalasEnemigos[I].ancho >= p.x) and
           (BalasEnemigos[I].x <= p.x + p.ancho) then
        begin
          p.Vivo := False;
          BalasEnemigos[I].Vivo := False;
          IzqPers:=False;
          DerPers:=False;
          ShowMessage('Game Over. Presiona "V" para otra moneda');
          break;
        end;
      end;
    end;
  end;
  VerificarColisionesBarrerasSuperior;
end;

procedure Tpantalla.VerificarColisionesBarrerasInferior;
var I,PosActX:Integer;
begin
//BalaJugador
  PosActX:=PosicionX_Inicial_barreras;
    if (BalaJugador.Vivo) then
      if (BalaJugador.y>=PosicionYIBarrera+(Filas_Barrera*TamBloqBarrera))  and  //Otro and para que este dentro de barrera
      (BalaJugador.x>=PosActX+(Columnas_Barrera*TamBloqBarrera))  and
      (BalaJugador.x<=PosActX)
      then
      begin
        BalaJugador.Vivo:=False; randomize;
        barrera[Random(Columnas_Barrera*Filas_Barrera)].vivo:=False;
      end;
  PosActX:=PosActX+DistanciaHorzEnem;
end;

procedure Tpantalla.VerificarColisionesBarrerasSuperior;
var I,PosActX:Integer;
begin
  PosActX:=PosicionX_Inicial_barreras;
  for I:=0 to length(BalasEnemigos)-1 do
    if (BalasEnemigos[I].Vivo) then
      if (BalasEnemigos[I].y+BalasEnemigos[I].Alto>=PosicionYIBarrera)  and
      (BalasEnemigos[I].y<=PosicionYIBarrera+(Filas_Barrera*TamBloqBarrera)) and
      (BalasEnemigos[I].x>=PosActX)  and
      (BalasEnemigos[I].x+BalasEnemigos[I].Ancho<=PosActX+(Columnas_Barrera*TamBloqBarrera))
      then
      begin
        BalasEnemigos[I].Vivo:=False; randomize;
        barrera[Random(Columnas_Barrera*Filas_Barrera)].vivo:=False;
      end;
  PosActX:=PosActX+EspaciadoHorzBarreras;
  for I:=0 to length(BalasEnemigos)-1 do
    if (BalasEnemigos[I].Vivo) then
      if (BalasEnemigos[I].y+BalasEnemigos[I].Alto>=PosicionYIBarrera)  and
      (BalasEnemigos[I].y<=PosicionYIBarrera+(Filas_Barrera*TamBloqBarrera)) and
      (BalasEnemigos[I].x>=PosActX)  and
      (BalasEnemigos[I].x+BalasEnemigos[I].Ancho<=PosActX+(Columnas_Barrera*TamBloqBarrera))
      then
      begin
        BalasEnemigos[I].Vivo:=False; randomize;
        barrera2[Random(Columnas_Barrera*Filas_Barrera)].vivo:=False;
      end;
  PosActX:=PosActX+EspaciadoHorzBarreras;
  for I:=0 to length(BalasEnemigos)-1 do
    if (BalasEnemigos[I].Vivo) then
      if (BalasEnemigos[I].y+BalasEnemigos[I].Alto>=PosicionYIBarrera)  and
      (BalasEnemigos[I].y<=PosicionYIBarrera+(Filas_Barrera*TamBloqBarrera)) and
      (BalasEnemigos[I].x>=PosActX)  and
      (BalasEnemigos[I].x+BalasEnemigos[I].Ancho<=PosActX+(Columnas_Barrera*TamBloqBarrera))
      then
      begin
        BalasEnemigos[I].Vivo:=False; randomize;
        barrera3[Random(Columnas_Barrera*Filas_Barrera)].vivo:=False;
      end;
  PosActX:=PosActX+EspaciadoHorzBarreras;
  for I:=0 to length(BalasEnemigos)-1 do
    if (BalasEnemigos[I].Vivo) then
      if (BalasEnemigos[I].y+BalasEnemigos[I].Alto>=PosicionYIBarrera)  and
      (BalasEnemigos[I].y<=PosicionYIBarrera+(Filas_Barrera*TamBloqBarrera)) and
      (BalasEnemigos[I].x>=PosActX)  and
      (BalasEnemigos[I].x+BalasEnemigos[I].Ancho<=PosActX+(Columnas_Barrera*TamBloqBarrera))
      then
      begin
        BalasEnemigos[I].Vivo:=False; randomize;
        barrera4[Random(Columnas_Barrera*Filas_Barrera)].vivo:=False;
      end;
end;

end.
