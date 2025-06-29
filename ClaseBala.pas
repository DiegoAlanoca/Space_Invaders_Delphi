unit ClaseBala;

interface
uses Vcl.Graphics, system.sysutils;

type
 TBala = class
  private
   w, h: word;
  public
   Top: word;
   Left: word;
   textura: TBitMap;
   property Width: word read w;
   property Height: word read h;
   constructor Create(tipo: byte);
end;

implementation

{ TBala }

constructor TBala.Create(tipo: byte);
begin
{  textura := TBitMap.Create;
  case tipo of //1 = el usuario | 2 = los enemigos
    1: textura.LoadFromFile('balas\bala.bmp');
    2: textura.LoadFromFile('balas\balaenemiga.bmp');
  end;
  textura.Transparent := true;
  textura.TransparentColor := textura.Canvas.pixels[1, 1];
  textura.TransparentMode := tmAuto;
  w:= textura.Width;
  h:= textura.Height;  }
end;

end.
