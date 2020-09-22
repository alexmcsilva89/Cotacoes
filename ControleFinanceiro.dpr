program ControleFinanceiro;

uses
  Vcl.Forms,
  ControleFinanceiro.View.ConsultaAplicacao in 'View\ControleFinanceiro.View.ConsultaAplicacao.pas' {frmConsultaAplicacao},
  ControleFinanceiro.Model.Conexao in 'Model\ControleFinanceiro.Model.Conexao.pas',
  ControleFinanceiro.Controller.Conexao in 'Controller\ControleFinanceiro.Controller.Conexao.pas',
  ControleFinanceiro.Model.Query in 'Model\ControleFinanceiro.Model.Query.pas',
  ControleFinanceiro.Controller.Cotacao in 'Controller\ControleFinanceiro.Controller.Cotacao.pas',
  ControleFinanceiro.Model.CotacaoDTO in 'Model\ControleFinanceiro.Model.CotacaoDTO.pas',
  ControleFinanceiro.Model.Cotacao in 'Model\ControleFinanceiro.Model.Cotacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConsultaAplicacao, frmConsultaAplicacao);
  Application.Run;
end.
