unit ClaseEnemigo;

interface
uses Vcl.Graphics,sysutils,ClaseBala,PngImage;
type
  enemigo = class
  private

  public
    x,y,Alto,Ancho,
    V:Word;
    Imagen:TPNGImage;
    Vivo:Boolean;
    constructor Create;
    procedure CargarImagen(ruta:String);
  end;

implementation

constructor enemigo.Create;
begin
  V:=0; Vivo:=True;
end;

procedure enemigo.cargarImagen(ruta:String);
begin
{  b := TBala.Create(2); // Bala del enemigo
  randomize;
  case random(8) of
    0: begin nave.LoadFromFile('enemigos\alien1.png'); v := 1000; end;
    1: begin nave.LoadFromFile('enemigos\alien1.png'); v := 200; end;
    2: begin nave.LoadFromFile('enemigos\alien1.png'); v := 360; end;
    3: begin nave.LoadFromFile('enemigos\alien1.png'); v := 100; end;
    4: begin nave.LoadFromFile('enemigos\alien1.png'); v := 300; end;
    5: begin nave.LoadFromFile('enemigos\alien1.png'); v := 50; end;
    6: begin nave.LoadFromFile('enemigos\alien1.png'); v := 400; end;
    7: begin nave.LoadFromFile('enemigos\alien1.png'); v := 250; end;
  end;
  w := nave.Width;
  h := nave.Height;}
  Imagen:=TPNGImage.Create;
  Imagen.LoadFromFile(ruta);
  Alto:=Imagen.Height;
  Ancho:=Imagen.Width;
end;

end.
