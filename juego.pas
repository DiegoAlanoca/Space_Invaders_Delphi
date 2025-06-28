unit juego;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,JPEG, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TBloqueo = class(TObject)
  public
    x,y,tam:Word; vivo:Boolean;
    constructor Create(ax,ay,xtam:Word);
    procedure Dibujar(Canvas: TCanvas);
    procedure Destruir;
  end;

type
  Tpantalla = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    img : TJPEGIMage; contdes:Word;
    barrera:Array of TBloqueo;
    barrera2:Array of TBloqueo;
    procedure crearbarrera(colum,filas,tam,posx,posy:Word);
  public
    { Public declarations }
  end;

type
  Tplayer = class(TObject)
    private
      colplay:TColor;
      tamrectan:Word;
      tamtri:Word;
      TpTrian:Array[0..2] of TPoint;
    public
      px,py:Word;
      constructor Create;
      procedure Dibujar(Canvas: TCanvas);
    end;

var
  pantalla: Tpantalla;
  player:TPlayer;
  bloqueo:TBloqueo;
implementation

{$R *.dfm}

procedure Tpantalla.crearbarrera(colum,filas,tam,posx,posy:Word);
var
  i,j,index:Word;
begin
  index:=0;
  SetLength(barrera,colum*filas);
  for i:=0 to colum-1 do
    for j:=0 to filas-1 do
    begin
      barrera[index] := TBloqueo.Create(posx+i*tam, posy+j*tam, tam);
      Inc(index);
    end;
end;

procedure Tpantalla.FormCreate(Sender: TObject);
begin
  img:=TJPEGIMage.Create;
  DoubleBuffered:=True; keypreview:=True;
  player:=Tplayer.Create;
  player.px:=800; player.py:=1100; player.tamtri:=15; player.tamrectan:=45;
  player.colplay:=ClLime;
  showcursor(False);
//  SetLength(barrera,32);
  crearbarrera(8,4,10,300,500);
  contdes:=0;

//  img.LoadFromFile('llama.jpg');
end;

procedure Tpantalla.FormDblClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tpantalla.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:Word;
begin
{  if (Key=ord('A'))and(TriX>=60) then
    TriX:=TriX-10
  else if (Key=ord('D'))and(TriX<=740) then
    TriX:=TriX+10;
    if key=VK_Return then
      TriY:=TriY-10;
    if ssShift in shift then
      TriY:=TriY+10;                }
  case key of
    ord('A'):if (player.px>player.tamrectan+15) then player.px:=player.px-8;
    ord('D'):if (player.px<1600-player.tamrectan-15) then player.px:=player.px+8;
  end;

  case key of
    ord('F'):
    begin 
    barrera[contdes].Destruir; inc(contdes);  
    end;
  end;
  
  Invalidate;
end;

procedure Tpantalla.FormPaint(Sender: TObject);
var i:Word;
begin
{ Canvas.Draw(300,50,img); }
  player.Dibujar(Canvas);
  for i:=0 to High(barrera) do
    barrera[i].Dibujar(Canvas);
end;

procedure Tpantalla.Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 { Shape1.Left:=X;
  Shape1.Top:=Y;}
end;


{ player }

constructor Tplayer.Create;
begin

end;

procedure Tplayer.Dibujar(Canvas: TCanvas);
begin
  Canvas.Pen.Width:=4;
  Canvas.Pen.Color:=colplay;
  Canvas.Brush.Color:=colplay;
  Canvas.Rectangle(px-tamrectan, py-tamrectan, px+tamrectan, py+tamrectan-40);

  TpTrian[0]:=Point(px,py-63);
  TpTrian[1]:=Point(px-tamtri,py+tamtri-63);
  TpTrian[2]:=Point(px+tamtri,py+tamtri-63);
  Canvas.Polygon(TpTrian);
end;

{ TBloqueo }

constructor TBloqueo.Create(ax, ay, xtam: Word);
begin
  x:=ax; y:=ay; tam:=xtam; vivo:=True;
end;

procedure TBloqueo.Destruir;
begin
  vivo:=False;
end;

procedure TBloqueo.Dibujar(Canvas: TCanvas);
begin
  if vivo then
  begin
    Canvas.Brush.Color := clLime;
    Canvas.Pen.Color := clLime;
    Canvas.Rectangle(x, y, x + tam, y + tam);
  end;
end;

end.
