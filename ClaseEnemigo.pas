unit ClaseEnemigo;

interface
uses Vcl.Graphics,sysutils,ClaseBala,PngImage;
type
  enemigo = class
  private

  public
    x,y,Alto,Ancho,
    Valor:Word;
    Imagen:TPNGImage;
    Vivo:Boolean;
    constructor Create;
    procedure CargarImagen(ruta:String);
  end;

implementation

constructor enemigo.Create;
begin
  Valor:=0; Vivo:=True;
end;

procedure enemigo.cargarImagen(ruta:String);
begin
  Imagen:=TPNGImage.Create;
  Imagen.LoadFromFile(ruta);
  Alto:=Imagen.Height;
  Ancho:=Imagen.Width;
end;

end.
