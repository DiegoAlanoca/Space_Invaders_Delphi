unit objetos;

interface
uses graphics;

type
  jugador = class
    Jx,Jy:Word;
    colorp:TColor;
    tamtri:Word;
  private

  public
    constructor create(x,y:Word;colorplayer:TColor);
    procedure dibujar(Canvas:TCanvas);

  private

  end;


implementation

{ jugador }

constructor jugador.create(x, y: Word;colorplayer:TColor);
begin
  Jx:=x; Jy:=y; colorp:=colorplayer;
end;

procedure jugador.dibujar(Canvas:TCanvas);
begin
  Canvas.Pen.Width:=4;
  Canvas.Pen.Color:=ClGreen;
  Canvas.Brush.Color:=ClGreen;
  Canvas.Rectangle(500,500,750,750);
end;

end.
