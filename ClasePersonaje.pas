unit ClasePersonaje;

interface
uses sysutils, Vcl.Graphics,PngImage,ClaseBala;

type
  Personaje=class
  private

  public
    x,y,Alto,Ancho,
    v:Word;
    Imagen:TPNGImage;
    constructor create;
    procedure CargarImagen(ruta:String);
end;

implementation

{ Personaje }

procedure Personaje.CargarImagen(ruta: String);
begin
  Imagen:=TPNGImage.Create;
  Imagen.LoadFromFile(ruta);
  Ancho:=Imagen.Width;
  Alto:=Imagen.Height;
end;

constructor Personaje.create;
begin
  v := 0;
end;


end.
