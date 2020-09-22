unit ControleFinanceiro.Model.Query;

interface

uses
  Data.DB, FireDAC.Comp.Client,Datasnap.DBClient,
  Datasnap.Provider,System.SysUtils, FireDAC.Stan.Option,FireDAC.Dapt,System.Classes,ControleFinanceiro.Controller.Conexao;

type

  iModelQuery = interface
   ['{B4AD350F-5693-466E-A7D0-E48946DF34AC}']
   function Open(SQL: String;Index: String; AutoInc: String): TDataSet;
   function Post(aQuery: TDataSet): Boolean;
   function RetornaValorColuna(SQL: string;coluna: string;Param:String='';Valor:String=''):string;
   function ApplyUpdates(dataSet:TDataSet): Boolean;
   procedure CloseAndDestroyQuery(aQuery: TDataSet);
  end;

  TFactoryModelQuery = class
   class function NewModelQuery: iModelQuery;
  end;

implementation

uses
  Vcl.Forms, Winapi.Windows, ControleFinanceiro.Model.Conexao;

type
  TModelQuery = class(TInterfacedObject,iModelQuery)
  private
    function Open(SQL: string; Index: string; AutoInc: string): TDataSet;
    function Post(aQuery: TDataSet): Boolean;
    function RetornaValorColuna(SQL: string;coluna: string;Param:String='';Valor:String=''):string;
    function ApplyUpdates(dataSet:TDataSet): Boolean;
    procedure CloseAndDestroyQuery(aQuery: TDataSet);
  public
    class function New: TModelQuery;
  end;

{ TModelQuery }

function TModelQuery.ApplyUpdates(dataSet:TDataSet): Boolean;
begin
  try
    Result := TFDQuery(dataSet).ApplyUpdates(0)=0;
  except on E:Exception do
    Application.MessageBox(PChar('Falha na gravação no banco de dados! Erro:'+E.Message+'!'), 'Aviso', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TModelQuery.CloseAndDestroyQuery(aQuery: TDataSet);
begin
  TFDQuery(aQuery).Close;
  TFDQuery(aQuery).DisposeOf;
end;

class function TModelQuery.New: TModelQuery;
begin
  Result := TModelQuery.Create;
end;

function TModelQuery.Open(SQL, Index, AutoInc: string): TDataSet;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);

  with Query do
  begin
    CachedUpdates                   := True;
    IndexFieldNames                 := Index;
    Connection                      := TFDConnection(TModelConexao.GetConexao);
    UpdateOptions.AssignedValues    := [uvGeneratorName];
    UpdateOptions.AutoIncFields     := AutoInc;
    UpdateOptions.AutoCommitUpdates := True;
    FetchOptions.RowsetSize         := 1000;
    FetchOptions.Mode               := fmOnDemand;
  end;
  Query.SQL.Text := SQL;
  Query.FieldList.Create(Query);
  Query.Active := True;

  Result := Query;
end;

function TModelQuery.Post(aQuery: TDataSet): Boolean;
begin
 try
   TFDQuery(aQuery).Post;
   Result := True;
 except
   Result := False;
 end;
end;

function TModelQuery.RetornaValorColuna(SQL: string;coluna: string;Param:String='';Valor:String=''):string;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Result := '';
    Query.Connection := TFDConnection(TModelConexao.GetConexao);
    Query.SQL.Text   := SQL;

    if Param <> emptystr then
      Query.ParamByName(Param).Value := Valor;
    Query.Open;
    Result := Query.FieldByName(Coluna).AsString;
  finally
    Query.DisposeOf;
  end;
end;

{ TFactoryModelQuery }

class function TFactoryModelQuery.NewModelQuery: iModelQuery;
begin
  Result := TModelQuery.Create;
end;

end.
