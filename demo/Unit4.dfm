object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 683
  ClientWidth = 969
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 969
    Height = 683
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 905
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 959
      Height = 30
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Demo BrComponents'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6244659
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 8
      ExplicitTop = 2
    end
    object Memo1: TMemo
      Left = 0
      Top = 284
      Width = 969
      Height = 358
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 905
    end
    object Panel7: TPanel
      Left = 0
      Top = 642
      Width = 969
      Height = 41
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 648
      ExplicitWidth = 1021
      object Button2: TButton
        Left = 139
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Criar Pasta root'
        Enabled = False
        TabOrder = 0
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 1
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Alimentar Auth'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 277
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Criar Pasta Filho'
        Enabled = False
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 415
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Pasta existe'
        Enabled = False
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 553
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Upload Arquivo'
        Enabled = False
        TabOrder = 4
        OnClick = Button5Click
        ExplicitLeft = 547
        ExplicitTop = 6
      end
      object Button6: TButton
        Left = 691
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Deletar Arquivo'
        Enabled = False
        TabOrder = 5
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 829
        Top = 1
        Width = 138
        Height = 39
        Align = alLeft
        Caption = 'Download Arquivo'
        Enabled = False
        TabOrder = 6
        OnClick = Button7Click
        ExplicitLeft = 835
        ExplicitTop = 6
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 43
      Width = 963
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 834
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 957
        Height = 21
        Margins.Top = 0
        Align = alTop
        Caption = 'ClientID'
        ExplicitWidth = 55
      end
      object edClientID: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 957
        Height = 25
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 29
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 104
      Width = 963
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitWidth = 834
      object Label3: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 957
        Height = 21
        Margins.Top = 0
        Align = alTop
        Caption = 'ClientSecret'
        ExplicitWidth = 83
      end
      object edClientSecret: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 957
        Height = 25
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 29
      end
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 165
      Width = 963
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      ExplicitTop = 226
      ExplicitWidth = 834
      object Label5: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 957
        Height = 21
        Margins.Top = 0
        Align = alTop
        Caption = 'RefreshToken'
        ExplicitWidth = 93
      end
      object edRefreshToken: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 957
        Height = 25
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 29
      end
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 226
      Width = 963
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      ExplicitTop = 287
      ExplicitWidth = 834
      object Label6: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 957
        Height = 21
        Margins.Top = 0
        Align = alTop
        Caption = 'API KEY'
        ExplicitWidth = 53
      end
      object edAPIKEY: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 957
        Height = 25
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 29
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 624
    Top = 464
  end
  object SaveDialog1: TSaveDialog
    Left = 696
    Top = 464
  end
end
