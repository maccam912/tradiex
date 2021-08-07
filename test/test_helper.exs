ExUnit.start()

Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)

Application.put_env(:tradiex, :http_client, HTTPoison.BaseMock)
