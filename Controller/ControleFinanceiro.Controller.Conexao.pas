unit ControleFinanceiro.Controller.Conexao;

interface

uses
  ControleFinanceiro.Model.Conexao, Data.DB;
type
  iControllerConexao = interface
    ['{44C993A7-8FF8-4BDD-A276-482D92932C22}']
    function Open: Boolean;
    function GetConexao: TCustomConnection;
    procedure Close;
  end;

  TFactoryControllerConexao = class
   public
      class function NewControllerConexao: iControllerConexao;
  end;

implementation

type
  TControllerConexao = class(TInterfacedObject,iControllerConexao)
  public
    function Open: Boolean;
    function GetConexao: TCustomConnection;
    procedure Close;
  end;
{ TControllerConexao }
procedure TControllerConexao.Close;
begin
  TModelConexao.Close;
end;

function TControllerConexao.GetConexao: TCustomConnection;
begin
  TModelConexao.Open;
  Result := TModelConexao.GetConexao;
end;

function TControllerConexao.Open: Boolean;
begin
  Result := TModelConexao.Open;
end;

{ TFactoryControllerConexao }

class function TFactoryControllerConexao.NewControllerConexao: iControllerConexao;
begin
  Result := TControllerConexao.Create;
end;

end.
