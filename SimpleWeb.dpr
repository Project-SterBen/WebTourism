program SimpleWeb;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  IdContext,
  IdCustomHTTPServer,
  IdHTTPServer;

type
  TMyServer = class(TIdHTTPServer)
    procedure HandleCommand(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  end;

procedure TMyServer.HandleCommand(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if ARequestInfo.URI = '/order' then
  begin
    AResponseInfo.ContentText :=
      '<html><body><h1>Заказ оформлен (демо)</h1></body></html>';
  end
  else
  begin
    AResponseInfo.ContentText :=
      '<html><head><meta charset="utf-8"><title>Туры</title></head><body>' +
      '<h1>Доступные туры</h1>' +
      '<table border="1"><tr><th>Название</th><th>Направление</th><th>Дней</th><th>Цена</th></tr>' +
      '<tr><td>Турция всё включено</td><td>Турция</td><td>7</td><td>50000</td></tr>' +
      '</table>' +
      '<h2>Оформить заказ</h2>' +
      '<form method="POST" action="/order">' +
      'ID клиента: <input type="text" name="clientid"><br>' +
      '<input type="submit" value="Заказать">' +
      '</form>' +
      '</body></html>';
  end;
end;

var
  Server: TMyServer;

begin
  try
    Server := TMyServer.Create(nil);
    try
      Server.DefaultPort := 8080;
      Server.OnCommandGet := Server.HandleCommand;   // теперь метод класса
      Server.Active := True;
      Writeln('Веб-сервер запущен на http://localhost:8080/');
      Writeln('Нажмите Enter для выхода...');
      Readln;
    finally
      Server.Free;
    end;
  except
    on E: Exception do
      Writeln('Ошибка: ', E.Message);
  end;
end.
