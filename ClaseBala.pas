unit ClaseBala;

interface
uses Graphics, sysutils,classes,types,PngImage;

type
 TBala = class
  private

  public
    x,y,Alto,Ancho,
    Velocidad,NroJugadorAsignado:Word;
    Imagen:TPNGImage;
    Vivo:Boolean;
    constructor create(v:Word);
    procedure CargarImagen(ruta:String);
end;

implementation

{ Personaje }

procedure TBala.CargarImagen(ruta: String);
begin
  Imagen:=TPNGImage.Create;
  Imagen.LoadFromFile(ruta);
  Ancho:=Imagen.Width;
  Alto:=Imagen.Height;
end;

constructor TBala.create(v:Word);
begin
  Velocidad:=v; Vivo:=False;
end;

end.
