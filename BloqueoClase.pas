unit BloqueoClase;

interface
uses Sysutils,Vcl.Graphics;
type
  TBloqueo = class(TObject)
  public
    x,y,tam:Word; vivo:Boolean;
    constructor Create(ax,ay,xtam:Word);
    procedure Dibujar(Canvas: TCanvas);
    procedure Destruir;
  end;


implementation

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
