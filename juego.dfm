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
  object MediaPlayer1: TMediaPlayer
    Left = 32
    Top = 144
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 0
  end
  object TimerPersonaje: TTimer
    Interval = 15
    OnTimer = TimerPersonajeTimer
    Left = 56
    Top = 48
  end
  object TimerEnemigosYBalas: TTimer
    Interval = 15
    OnTimer = TimerEnemigosYBalasTimer
    Left = 168
    Top = 48
  end
  object Colisiones: TTimer
    Interval = 15
    OnTimer = ColisionesTimer
    Left = 272
    Top = 48
  end
end
