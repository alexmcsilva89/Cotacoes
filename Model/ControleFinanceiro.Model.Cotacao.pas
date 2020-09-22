unit ControleFinanceiro.Model.Cotacao;

interface
uses
  ControleFinanceiro.Model.CotacaoDTO, System.Generics.Collections;
type
  TMoeda = (enDollar,enEuro,enBitCoin);

  iModelCotacao = interface
   ['{92CB1B5F-D827-4F86-9D98-56B552B59026}']
  function ImportarCotacoes(aListaCotacoes: TDictionary<Integer,TCotacao>): Boolean;
  procedure PreencherCotacoes(aListaCotacoes: TDictionary<Integer,TCotacao>);
  end;

  TModelCotacaoFactory = class
   class function NewModelCotacao: iModelCotacao;
  end;

implementation

uses
  System.SysUtils, ControleFinanceiro.Model.Query, Data.DB, Vcl.Forms,System.StrUtils,
  Winapi.Windows;

type

  TModelCotacao = class(TInterfacedObject,iModelCotacao)
  private
    FModelQuery: iModelQuery;
    function GetCotacao: TDataSet;
    function GetDataSetCotacao: TDataSet;
    function GetSQL: String;
  public
    function ImportarCotacoes(aListaCotacoes: TDictionary<Integer,TCotacao>): Boolean;
    procedure PreencherCotacoes(aListaCotacoes: TDictionary<Integer,TCotacao>);
    property SQL: String read GetSQL;
    constructor Create;
  end;
{ TModelCotacaoFactory }

class function TModelCotacaoFactory.NewModelCotacao: iModelCotacao;
begin
  Result := TModelCotacao.Create;
end;

{ TModelCotacao }
constructor TModelCotacao.Create;
begin
  FModelQuery := TFactoryModelQuery.NewModelQuery;
end;

function TModelCotacao.GetCotacao: TDataSet;
begin
  Result := FModelQuery.Open(SQL,'SEQ','SEQ');
end;

function TModelCotacao.GetDataSetCotacao: TDataSet;
begin
  Result := FModelQuery.Open('select * from controlefinanceiro.dbo.cotacao_moeda','SEQ','SEQ');
end;

function TModelCotacao.GetSQL: String;
begin
Result :=
' select * from 		              					                     '+
' (select     							                                     '+
'        seq,	                							                     '+
'        moeda,								                                   '+
' 	     compravalor,							                               '+
' 	     vendavalor,							                               '+
' 	     datacotacao,                                            '+
'				 variacaovalor			                                     '+
' from controlefinanceiro.dbo.cotacao_moeda	                     '+
' where upper(moeda) =''DOLLAR''  		                           '+
' and datacotacao = (select max(datacotacao)                     '+
'                    from controlefinanceiro.dbo.cotacao_moeda   '+
' 				           where upper(moeda) =''DOLLAR''))as Dollar	 '+
' 										                    	                     '+
' union                 										                     '+
' 											                                         '+
' select * from 						                                     '+
' (select                                                        '+
'        seq,								                                     '+
'        moeda,							              	                     '+
' 	     compravalor,					            	                     '+
' 	     vendavalor,					            	                     '+
' 	     datacotacao,                                            '+
'        variacaovalor					                                 '+
' from controlefinanceiro.dbo.cotacao_moeda	                     '+
' where upper(moeda) =''EURO''				                           '+
' and datacotacao = (select max(datacotacao)                     '+
'                    from controlefinanceiro.dbo.cotacao_moeda   '+
' 				           where upper(moeda) =''EURO''))as Euro    	 '+
' union								                   		                     '+
' 										                   	                       '+
' select * from 			                   		                     '+
' (select     				                   		                     '+
'        seq,					                   		                     '+
'        moeda,				                   		                     '+
' 	     compravalor,		                   	                     '+
' 	     vendavalor,		                   	                     '+
' 	     datacotacao,		                   	                     '+
' 	     variacaovalor                     	                     '+
' from controlefinanceiro.dbo.cotacao_moeda                      '+
' where upper(moeda) =''BITCOIN''			                           '+
' and datacotacao = (select max(datacotacao)                     '+
'                    from controlefinanceiro.dbo.cotacao_moeda   '+
' 				           where upper(moeda) =''BITCOIN''))as Bitcoin '+
' order by moeda asc                                             ';
end;

function TModelCotacao.ImportarCotacoes(aListaCotacoes: TDictionary<Integer,TCotacao>): Boolean;
var
  dataAtual:TDateTime;
  Query: TDataSet;
  QueryInsert: TDataSet;
  moeda :TCotacao;
begin
  dataAtual := Now;
  Query := GetCotacao;
  QueryInsert := GetDataSetCotacao;
  Result := False;
  try
    try
      if Query.IsEmpty then
      begin
        for moeda in aListaCotacoes.Values do
        begin
          QueryInsert.Append;
          QueryInsert.FieldByName('MOEDA').AsString         := moeda.name;
          QueryInsert.FieldByName('COMPRAVALOR').AsCurrency := moeda.buy;
          QueryInsert.FieldByName('VENDAVALOR').AsCurrency  := moeda.sell;
          QueryInsert.FieldByName('VARIACAOVALOR').AsFloat  := moeda.variation;
          QueryInsert.FieldByName('DATACOTACAO').AsDateTime := dataAtual;
          QueryInsert.Post;
          FModelQuery.ApplyUpdates(QueryInsert);
          Result := True;
        end;
      end
      else
      begin
        for moeda in aListaCotacoes.Values do
        begin
          if Query.Locate('MOEDA',moeda.name,[loCaseInsensitive,loPartialKey]) then
          begin
             if (Query.FieldByName('COMPRAVALOR').AsCurrency <> moeda.buy) and
                (Query.FieldByName('VENDAVALOR').AsCurrency <> moeda.sell) and
                (Query.FieldByName('VARIACAOVALOR').AsFloat <> moeda.variation) then
             begin
               QueryInsert.Append;
               QueryInsert.FieldByName('MOEDA').AsString         := moeda.name;
               QueryInsert.FieldByName('COMPRAVALOR').AsCurrency := moeda.buy;
               QueryInsert.FieldByName('VENDAVALOR').AsCurrency  := moeda.sell;
               QueryInsert.FieldByName('VARIACAOVALOR').AsFloat  := moeda.variation;
               QueryInsert.FieldByName('DATACOTACAO').AsDateTime := dataAtual;
               QueryInsert.Post;
               FModelQuery.ApplyUpdates(QueryInsert);
               Result := True;
             end;
          end;
        end;
      end;
    except on E:Exception do
      begin
        Result := False;
        Application.MessageBox(PChar('Falha ao gravar cotação!'+' Erro: '+E.Message), 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    FModelQuery.CloseAndDestroyQuery(Query);
    FModelQuery.CloseAndDestroyQuery(QueryInsert);
  end;
end;

procedure TModelCotacao.PreencherCotacoes(aListaCotacoes: TDictionary<Integer, TCotacao>);
var
  Cotacao: TCotacao;
  Query: TDataSet;
begin
  aListaCotacoes.Clear;
  Query := GetCotacao;
  try
    Query.First;
    while not Query.Eof do
    begin
      Cotacao           := TCotacao.Create;
      Cotacao.name      := Query.FieldByName('MOEDA').AsString;
      Cotacao.buy       := Query.FieldByName('COMPRAVALOR').AsCurrency;
      Cotacao.sell      := Query.FieldByName('VENDAVALOR').AsCurrency;
      Cotacao.variation := Query.FieldByName('VARIACAOVALOR').AsFloat;

      case TMoeda(AnsiIndexStr(Query.FieldByName('MOEDA').AsString,['Dollar','Euro','Bitcoin'])) of
        enDollar:  aListaCotacoes.Add(Ord(enDollar),Cotacao);
        enEuro:    aListaCotacoes.Add(Ord(enEuro),Cotacao);
        enBitCoin: aListaCotacoes.Add(Ord(enBitCoin),Cotacao);
      end;
      Query.Next;
    end;
  finally
    FModelQuery.CloseAndDestroyQuery(Query);
  end;
end;

end.
