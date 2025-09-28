unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, System.JSON,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TWebModule1 = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure GetEmployeesHandler(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  end;

implementation

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  Actions.Add.PathInfo := '/employees';
  Actions.Add.OnAction := GetEmployeesHandler;
end;

procedure TWebModule1.GetEmployeesHandler(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  Arr: TJSONArray;
  Obj: TJSONObject;
begin
  Conn := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);
  Arr := TJSONArray.Create;
  try
    Conn.Params.Text :=
      'DriverID=MSSQL;' +
      'Server=.\SQLEXPRESS;' +
      'Database=CompanyDB;' +
      'User_Name=sa;' +
      'Password=12345;' +
      'LoginPrompt=No;' +
      'Encrypt=No;' +
      'TrustServerCertificate=True;';
    Conn.Connected := True;

    Query.Connection := Conn;
    Query.SQL.Text := 'SELECT Id, FullName, Position, Salary FROM Employees';
    Query.Open;

    while not Query.Eof do
    begin
      Obj := TJSONObject.Create;
      Obj.AddPair('id', Query.FieldByName('Id').AsInteger);
      Obj.AddPair('name', Query.FieldByName('FullName').AsString);
      Obj.AddPair('position', Query.FieldByName('Position').AsString);
      Obj.AddPair('salary', Query.FieldByName('Salary').AsFloat);
      Arr.AddElement(Obj);
      Query.Next;
    end;

    Response.ContentType := 'application/json';
    Response.Content := Arr.ToJSON;
    Response.SendResponse;
  except
    on E: Exception do
    begin
      Response.StatusCode := 500;
      Response.Content := '{"error":"' + E.Message + '"}';
      Response.SendResponse;
    end;
  end;
  Handled := True;
end;

end.
