object pantalla: Tpantalla
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'pantalla'
  ClientHeight = 1200
  ClientWidth = 1600
  Color = clWindowFrame
  DoubleBuffered = True
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
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  TextHeight = 15
  object Label1: TLabel
    Left = 1520
    Top = 16
    Width = 53
    Height = 15
    Caption = '1600x1200'
  end
  object TimerPersonaje: TTimer
    Interval = 10
    OnTimer = TimerPersonajeTimer
    Left = 56
    Top = 48
  end
  object TimerEnemigos: TTimer
    Interval = 10
    Left = 168
    Top = 48
  end
end
