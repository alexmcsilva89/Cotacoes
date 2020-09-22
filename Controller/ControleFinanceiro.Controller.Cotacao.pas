unit ControleFinanceiro.Controller.Cotacao;

interface
uses
  System.JSON, Vcl.Forms, System.SysUtils, Winapi.Windows,REST.Client,REST.Types,REST.Json,REST.Utils,
  Data.DB,IPPeerCommon,IPPeerClient,  System.Classes,System.Generics.Collections,
  ControleFinanceiro.Model.CotacaoDTO, ControleFinanceiro.Model.Cotacao;
type

  TMoeda = ControleFinanceiro.Model.Cotacao.TMoeda;

  iControllerCotacao = interface
   ['{AD40F709-3BD4-486E-84B5-D522D8029E2D}']
   procedure AtualizarCotacao;
   function GetValorCompra(aCotacao: TMoeda):String;
   function GetValorVenda(aCotacao: TMoeda):String;
   function GetVariacao(aCotacao: TMoeda):String;
   procedure GetCotacao;
  end;

  TFactoryControllerCotacao = class
  public
   class function NewControllerCotacao : iControllerCotacao;
  end;

implementation

type
  TControllerCotacao = class(TInterfacedObject,iControllerCotacao)
  private
    FlistaCotacoes: TDictionary<Integer,TCotacao>;
    FModelCotacao :iModelCotacao;
    function Getfinance: Boolean;
    procedure ClearDictionary;
  public
    procedure AtualizarCotacao;
    function GetValorCompra(aCotacao: TMoeda):String;
    function GetValorVenda(aCotacao: TMoeda):String;
    function GetVariacao(aCotacao: TMoeda):String;
    procedure GetCotacao;
    property listaCotacoes: TDictionary<Integer,TCotacao> read FlistaCotacoes;
    constructor Create;
    destructor Destroy;override;
  end;
{ TControllerCotacao }
procedure TControllerCotacao.AtualizarCotacao;
begin
  if Getfinance then
    FModelCotacao.ImportarCotacoes(FlistaCotacoes)
  else
    FModelCotacao.PreencherCotacoes(FListaCotacoes);
end;

procedure TControllerCotacao.ClearDictionary;
var
  Cotacao : TCotacao;
begin
  for Cotacao in FlistaCotacoes.Values do
    Cotacao.Destroy;
  FListaCotacoes.Clear;
end;

constructor TControllerCotacao.Create;
begin
  FlistaCotacoes := TDictionary<Integer,TCotacao>.Create;
  FModelCotacao := TModelCotacaoFactory.NewModelCotacao;
end;

destructor TControllerCotacao.destroy;
var
  LCotacao : TCotacao;
begin
  for LCotacao in FlistaCotacoes.Values do
    LCotacao.Destroy;
  FListaCotacoes.Destroy;
  inherited
end;

procedure TControllerCotacao.GetCotacao;
begin
  FModelCotacao.PreencherCotacoes(FlistaCotacoes);
end;

function TControllerCotacao.Getfinance: Boolean;
var
  request: TRestRequest;
  client: TRestClient;
  jsonRoot: TJSONObject;
  jsonResults: TJSONObject;
  jsonCurrencies: TJSONObject;
  dollar: TDollar;
  euro: TEuro;
  bitCoin: TBitCoin;
begin
  jsonRoot := nil;
  ClearDictionary;
  client := TRESTClient.Create(nil);
  request := TRestRequest.Create(nil);
  Result := False;
  try
    try
      client.BaseURL := 'https://api.hgbrasil.com/finance';
      request.Client := client;
      request.Execute;

      jsonRoot := request.Response.JSONValue as TJSONObject;

      jsonResults := jsonRoot.Get('results').JsonValue as TJSONObject;

      jsonCurrencies := jsonResults.Get('currencies').JsonValue as TJSONObject;


      dollar := TJSON.JsonToObject<TDollar>(jsonCurrencies.Get('USD').JsonValue as TJSONObject);
      if Assigned(dollar) then listaCotacoes.Add(Ord(enDollar),dollar);

      euro := TJSON.JsonToObject<TEuro>(jsonCurrencies.Get('EUR').JsonValue as TJSONObject);
      if Assigned(euro) then listaCotacoes.Add(Ord(enEuro),euro);

      bitCoin := TJSON.JsonToObject<TBitCoin>(jsonCurrencies.Get('BTC').JsonValue as TJSONObject);
      if Assigned(bitCoin) then listaCotacoes.Add(Ord(enBitCoin),bitCoin);

      Application.MessageBox(PChar('Atualização das cotações concluída!'), 'Aviso', MB_OK + MB_ICONINFORMATION);
      Result := listaCotacoes.Count > 0;
    except
      Application.MessageBox(PChar('Falha ao consultar Cotação!'), 'Aviso', MB_OK + MB_ICONWARNING);
    end;
  finally
    client.DisposeOf;
    request.DisposeOf;
  end;
end;

function TControllerCotacao.GetValorCompra(aCotacao: TMoeda): String;
begin
  case aCotacao of
   enDollar:  if FListaCotacoes.ContainsKey(Ord(enDollar)) then Result := FloatToStr(FListaCotacoes.Items[Ord(enDollar)].buy);
   enEuro:    if FListaCotacoes.ContainsKey(Ord(enEuro))   then Result := FloatToStr(FListaCotacoes.Items[Ord(enEuro)].buy);
   enBitCoin: if FListaCotacoes.ContainsKey(Ord(enBitCoin))then Result := FloatToStr(FListaCotacoes.Items[Ord(enBitCoin)].buy);
  end;
end;

function TControllerCotacao.GetValorVenda(aCotacao: TMoeda): String;
begin
  case aCotacao of
   enDollar:  if FListaCotacoes.ContainsKey(Ord(enDollar)) then Result := FloatToStr(FListaCotacoes.Items[Ord(enDollar)].sell);
   enEuro:    if FListaCotacoes.ContainsKey(Ord(enEuro))   then Result := FloatToStr(FListaCotacoes.Items[Ord(enEuro)].sell);
   enBitCoin: if FListaCotacoes.ContainsKey(Ord(enBitCoin))then Result := FloatToStr(FListaCotacoes.Items[Ord(enBitCoin)].sell);
  end;
end;

function TControllerCotacao.GetVariacao(aCotacao: TMoeda): String;
begin
  case aCotacao of
   enDollar:  if FListaCotacoes.ContainsKey(Ord(enDollar)) then Result := FloatToStr(FListaCotacoes.Items[Ord(enDollar)].variation);
   enEuro:    if FListaCotacoes.ContainsKey(Ord(enEuro))   then Result := FloatToStr(FListaCotacoes.Items[Ord(enEuro)].variation);
   enBitCoin: if FListaCotacoes.ContainsKey(Ord(enBitCoin))then Result := FloatToStr(FListaCotacoes.Items[Ord(enBitCoin)].variation);
  end;
end;

{ TFactoryControllerCotacao }

class function TFactoryControllerCotacao.NewControllerCotacao: iControllerCotacao;
begin
  Result := TControllerCotacao.Create;
end;

end.
