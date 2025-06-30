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
  object score: TLabel
    Left = 8
    Top = 8
    Width = 145
    Height = 58
    Caption = 'score'
    Color = clWindow
    FocusControl = TPlayerMusFondo
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -48
    Font.Name = 'Unispace'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object TPlayerMusFondo: TMediaPlayer
    Left = 48
    Top = 504
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 0
    OnNotify = TPlayerMusFondoNotify
  end
  object TimerPersonaje: TTimer
    Interval = 16
    OnTimer = TimerPersonajeTimer
    Left = 72
    Top = 408
  end
  object TimerEnemigosYBalas: TTimer
    Interval = 16
    OnTimer = TimerEnemigosYBalasTimer
    Left = 184
    Top = 408
  end
  object Colisiones: TTimer
    Interval = 16
    OnTimer = ColisionesTimer
    Left = 288
    Top = 408
  end
  object Repintado: TTimer
    Interval = 16
    OnTimer = RepintadoTimer
    Left = 352
    Top = 408
  end
end
