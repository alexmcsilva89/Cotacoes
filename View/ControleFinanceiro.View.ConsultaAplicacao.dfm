object frmConsultaAplicacao: TfrmConsultaAplicacao
  Left = 0
  Top = 0
  Caption = 'Consulta de Aplica'#231#227'o Financeira'
  ClientHeight = 148
  ClientWidth = 567
  Color = clBtnFace
  Constraints.MinHeight = 148
  Constraints.MinWidth = 583
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 148
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnCotacao: TPanel
      Left = 0
      Top = 39
      Width = 567
      Height = 106
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object pnBitcoin: TPanel
        Left = 375
        Top = 5
        Width = 185
        Height = 96
        Align = alLeft
        BevelOuter = bvNone
        Padding.Left = 5
        Padding.Top = 5
        Padding.Right = 5
        Padding.Bottom = 5
        TabOrder = 0
        object shBitcoin: TShape
          Left = 5
          Top = 5
          Width = 175
          Height = 86
          Align = alClient
          Brush.Color = clBtnFace
          ExplicitLeft = -2
          ExplicitTop = 6
          ExplicitWidth = 173
          ExplicitHeight = 88
        end
        object lblBitcoin: TLabel
          Left = 14
          Top = 11
          Width = 39
          Height = 13
          Align = alCustom
          Caption = 'Bitcoin:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblVendaB: TLabel
          Left = 48
          Top = 30
          Width = 35
          Height = 13
          Caption = 'Venda:'
        end
        object lblBitcoinVenda: TLabel
          Left = 89
          Top = 30
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblCompraB: TLabel
          Left = 48
          Top = 45
          Width = 43
          Height = 13
          Caption = 'Compra:'
        end
        object lblBitcoinCompra: TLabel
          Left = 94
          Top = 45
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblVariacaoB: TLabel
          Left = 48
          Top = 61
          Width = 46
          Height = 13
          Caption = 'Varia'#231#227'o:'
        end
        object lblBitcoinVariacao: TLabel
          Left = 96
          Top = 61
          Width = 33
          Height = 13
          Caption = '0.00 %'
        end
      end
      object pnDolar: TPanel
        Left = 5
        Top = 5
        Width = 185
        Height = 96
        Align = alLeft
        BevelOuter = bvNone
        Padding.Left = 5
        Padding.Top = 5
        Padding.Right = 5
        Padding.Bottom = 5
        TabOrder = 1
        object spDolar: TShape
          Left = 5
          Top = 5
          Width = 175
          Height = 86
          Align = alClient
          Brush.Color = clBtnFace
          ExplicitLeft = 6
          ExplicitTop = 0
          ExplicitWidth = 173
          ExplicitHeight = 88
        end
        object lblDolar: TLabel
          Left = 12
          Top = 11
          Width = 31
          Height = 13
          Align = alCustom
          Caption = 'D'#243'lar:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblVendaD: TLabel
          Left = 40
          Top = 30
          Width = 35
          Height = 13
          Caption = 'Venda:'
        end
        object lblDolarVenda: TLabel
          Left = 81
          Top = 30
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblCompraD: TLabel
          Left = 40
          Top = 45
          Width = 43
          Height = 13
          Caption = 'Compra:'
        end
        object lblDolarCompra: TLabel
          Left = 86
          Top = 45
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblVariacaoD: TLabel
          Left = 40
          Top = 61
          Width = 46
          Height = 13
          Caption = 'Varia'#231#227'o:'
        end
        object lblDolarVariacao: TLabel
          Left = 88
          Top = 61
          Width = 33
          Height = 13
          Caption = '0.00 %'
        end
      end
      object pnEuro: TPanel
        Left = 190
        Top = 5
        Width = 185
        Height = 96
        Align = alLeft
        BevelOuter = bvNone
        Padding.Left = 5
        Padding.Top = 5
        Padding.Right = 5
        Padding.Bottom = 5
        TabOrder = 2
        object spEuro: TShape
          Left = 5
          Top = 5
          Width = 175
          Height = 86
          Align = alClient
          Brush.Color = clBtnFace
          ExplicitHeight = 60
        end
        object lblEuro: TLabel
          Left = 12
          Top = 11
          Width = 27
          Height = 13
          Align = alCustom
          Caption = 'Euro:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblVendaE: TLabel
          Left = 45
          Top = 30
          Width = 35
          Height = 13
          Caption = 'Venda:'
        end
        object lblEuroVenda: TLabel
          Left = 86
          Top = 30
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblCompraE: TLabel
          Left = 45
          Top = 45
          Width = 43
          Height = 13
          Caption = 'Compra:'
        end
        object lblEuroCompra: TLabel
          Left = 91
          Top = 45
          Width = 37
          Height = 13
          Caption = 'R$ 0.00'
        end
        object lblVariacaoE: TLabel
          Left = 45
          Top = 61
          Width = 46
          Height = 13
          Caption = 'Varia'#231#227'o:'
        end
        object lblEuroVariacao: TLabel
          Left = 93
          Top = 61
          Width = 33
          Height = 13
          Caption = '0.00 %'
        end
      end
    end
    object pnAtualizar: TPanel
      Left = 0
      Top = 0
      Width = 567
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Padding.Left = 10
      Padding.Top = 5
      Padding.Right = 10
      Padding.Bottom = 5
      ParentFont = False
      TabOrder = 1
      object lblDataCotacao: TLabel
        AlignWithMargins = True
        Left = 102
        Top = 10
        Width = 3
        Height = 21
        Margins.Top = 5
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 13
      end
      object lblCotacoes: TLabel
        AlignWithMargins = True
        Left = 13
        Top = 10
        Width = 83
        Height = 21
        Margins.Top = 5
        Align = alLeft
        Caption = 'Cota'#231#245'es do dia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 13
      end
      object btnAtualizar: TButton
        Left = 444
        Top = 5
        Width = 113
        Height = 29
        Align = alRight
        Caption = 'Atualizar Cota'#231#245'es'
        TabOrder = 0
        OnClick = btnAtualizarClick
      end
    end
  end
end
