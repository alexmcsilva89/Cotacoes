unit ControleFinanceiro.Model.Conexao;

interface
uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client,FireDAC.Comp.UI,FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,IniFiles;

type

  TModelConexao = class
  private
    class var FConn: TFDConnection;
  public
    class function Open: Boolean;
    class function Close: Boolean;
    class function GetConexao: TCustomConnection;
    destructor Destroy;override;
  end;

implementation

uses
  Vcl.Forms, Winapi.Windows;

type
  TFuncoes = class
  private
    class function Getarquivo: String; static;
    class function GetNameServer: String; static;
  public
    class function LerIni(Chave1, Chave2: String; ValorPadrao: String = ''): String;
    class procedure GravarIni;
    class property arquivo: String read Getarquivo;
  end;

{ TModelConnFiredac }
class function TModelConexao.Close: Boolean;
begin
  try
    if FConn.Connected then
        FConn.Connected := False;
    FConn.Destroy;
    Result := True;
  except on E:Exception do
    begin
      Application.MessageBox(PChar('Ocorreu uma falha ao desconectar do banco de dados: ' + E.Message), 'Aviso', MB_OK + MB_ICONWARNING);
      Result := False;
    end;
  end;
end;

destructor TModelConexao.Destroy;
begin
  FConn.DisposeOf;
  inherited;
end;

class function TModelConexao.GetConexao: TCustomConnection;
begin
  if not Assigned(FConn) then
    FConn := TFDConnection.Create(nil);
  Result := FConn;
end;

class function TModelConexao.Open: Boolean;
begin
  if not Assigned(FConn) then
    FConn := TFDConnection.Create(nil);

  try
    TFuncoes.GravarIni;
    with FConn do
    begin
      Params.Clear;
      Params.Values['DriverID']  := 'MSSQL';
      Params.Values['Server']    := TFuncoes.LerIni('SQLSERVER','Server');
      Params.Values['Database']  := TFuncoes.LerIni('SQLSERVER','Database');
      Params.Values['User_Name'] := TFuncoes.LerIni('SQLSERVER','User');
      Params.Values['Password']  := TFuncoes.LerIni('SQLSERVER','Password');
      LoginPrompt := False;
      Connected := True;
      Result := True;
    end;
  except on E:Exception do
    begin
      Application.MessageBox(PChar('Ocorreu uma falha ao conectar no banco de dados: ' + E.Message), 'Aviso', MB_OK + MB_ICONWARNING);
      Result := False;
    end;
  end;
end;

{ TFuncoes }
class function TFuncoes.Getarquivo: String;
begin
  Result := Copy(Application.ExeName,0,Length(Application.ExeName)-4) +'.ini';
end;

class function TFuncoes.GetNameServer: String;
  function GetNameComputer: String;
  const
    Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
  var
    lpBuffer : PChar;
    nSize : DWord;
  begin
    nSize := Buff_Size;
    lpBuffer := StrAlloc(Buff_Size);
    GetComputerName(lpBuffer, nSize);
    Result := String(lpBuffer);
    StrDispose(lpBuffer);
  end;
begin
  Result := GetNameComputer+'\'+'SQLEXPRESS';
end;

class procedure TFuncoes.GravarIni;
var
  FileIni: TIniFile;
begin
  try
    FileIni := TIniFile.Create(Arquivo);
    if not FileExists(Arquivo) then
    begin
      FileIni.WriteString('SQLSERVER','Server',GetNameServer);
      FileIni.WriteString('SQLSERVER','User','administrador');
      FileIni.WriteString('SQLSERVER','Password','210920');
      FileIni.WriteString('SQLSERVER','Database','controlefinanceiro');
    end;
  finally
    FreeAndNil(FileIni)
  end;
end;

class function TFuncoes.LerIni(Chave1, Chave2, ValorPadrao: String): String;
var
  FileIni: TIniFile;
begin
  result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

end.
