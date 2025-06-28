object pantalla: Tpantalla
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'pantalla'
  ClientHeight = 1200
  ClientWidth = 1600
  Color = clWindowFrame
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  TextHeight = 15
  object Label1: TLabel
    Left = 1520
    Top = 16
    Width = 54
    Height = 15
    Caption = '1600x1200'
  end
  object Shape1: TShape
    Left = 792
    Top = 83
    Width = 121
    Height = 118
    Shape = stCircle
    OnMouseMove = Shape1MouseMove
  end
end
