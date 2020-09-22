unit ControleFinanceiro.View.ConsultaAplicacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, ControleFinanceiro.Controller.Conexao,
  ControleFinanceiro.Controller.Cotacao;

type
  TfrmConsultaAplicacao = class(TForm)
    pnPrincipal: TPanel;
    pnCotacao: TPanel;
    pnBitcoin: TPanel;
    shBitcoin: TShape;
    pnDolar: TPanel;
    spDolar: TShape;
    pnEuro: TPanel;
    spEuro: TShape;
    pnAtualizar: TPanel;
    lblDataCotacao: TLabel;
    lblCotacoes: TLabel;
    btnAtualizar: TButton;
    lblDolar: TLabel;
    lblVendaD: TLabel;
    lblDolarVenda: TLabel;
    lblCompraD: TLabel;
    lblDolarCompra: TLabel;
    lblVariacaoD: TLabel;
    lblDolarVariacao: TLabel;
    lblEuro: TLabel;
    lblVendaE: TLabel;
    lblEuroVenda: TLabel;
    lblCompraE: TLabel;
    lblEuroCompra: TLabel;
    lblVariacaoE: TLabel;
    lblEuroVariacao: TLabel;
    lblBitcoin: TLabel;
    lblVendaB: TLabel;
    lblBitcoinVenda: TLabel;
    lblCompraB: TLabel;
    lblBitcoinCompra: TLabel;
    lblVariacaoB: TLabel;
    lblBitcoinVariacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ExibirCotacoes;
  public
    { Public declarations }
    controllerConexao: iControllerConexao;
    controllerCotacao: iControllerCotacao;
  end;

var
  frmConsultaAplicacao: TfrmConsultaAplicacao;

implementation
{$R *.dfm}

procedure TfrmConsultaAplicacao.btnAtualizarClick(Sender: TObject);
begin
  controllerCotacao.AtualizarCotacao;
  ExibirCotacoes;
end;

procedure TfrmConsultaAplicacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  controllerConexao.Close;
  frmConsultaAplicacao := nil;
  action := caFree;
end;

procedure TfrmConsultaAplicacao.FormCreate(Sender: TObject);
begin
  controllerConexao    := TFactoryControllerConexao.NewControllerConexao;
  controllerConexao.Open;
  controllerCotacao    := TFactoryControllerCotacao.NewControllerCotacao;
end;

procedure TfrmConsultaAplicacao.FormShow(Sender: TObject);
begin
  controllerCotacao.GetCotacao;
  ExibirCotacoes;
end;

procedure TfrmConsultaAplicacao.ExibirCotacoes;
begin
  with controllerCotacao do
  begin
    lblDataCotacao.Caption   := '('+FormatDateTime('dd/mm/yyyy',Now)+')';
    lblDolarVenda.Caption    := 'R$ '+GetValorVenda(TMoeda.enDollar);
    lblDolarCompra.Caption   := 'R$ '+GetValorCompra(TMoeda.enDollar);
    lblDolarVariacao.Caption := GetVariacao(TMoeda.enDollar)+' %';

    lblEuroVenda.Caption     := 'R$ '+GetValorVenda(TMoeda.enEuro);
    lblEuroCompra.Caption    := 'R$ '+GetValorCompra(TMoeda.enEuro);
    lblEuroVariacao.Caption  := GetVariacao(TMoeda.enEuro)+' %';

    lblBitcoinVenda.Caption    := 'R$ '+GetValorVenda(TMoeda.enBitCoin);
    lblBitcoinCompra.Caption   := 'R$ '+GetValorCompra(TMoeda.enBitCoin);
    lblBitcoinVariacao.Caption := GetVariacao(TMoeda.enBitCoin)+' %';
  end;
end;
initialization
  ReportMemoryLeaksOnShutdown := true;
end.
