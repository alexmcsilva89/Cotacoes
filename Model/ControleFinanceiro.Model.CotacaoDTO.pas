unit ControleFinanceiro.Model.CotacaoDTO;

interface

type

  TCotacao = class
  private
    Fname: String;
    Fvariation: Double;
    Fsell: Currency;
    Fbuy: Currency;
    procedure Setbuy(const Value: Currency);
    procedure Setname(const Value: String);
    procedure Setsell(const Value: Currency);
    procedure Setvariation(const Value: Double);
  public
    property name: String read Fname write Setname;
    property buy: Currency read Fbuy write Setbuy;
    property sell: Currency read Fsell write Setsell;
    property variation: Double read Fvariation write Setvariation;
  end;

  TDollar = class(TCotacao);
  TBitCoin = class(TCotacao);
  TEuro = class(TCotacao);

implementation

{ TCotacao }

procedure TCotacao.Setbuy(const Value: Currency);
begin
  Fbuy := Value;
end;

procedure TCotacao.Setname(const Value: String);
begin
  Fname := Value;
end;

procedure TCotacao.Setsell(const Value: Currency);
begin
  Fsell := Value;
end;

procedure TCotacao.Setvariation(const Value: Double);
begin
  Fvariation := Value;
end;

end.
