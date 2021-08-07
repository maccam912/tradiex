import Config

config :tradiex,
  http_client: HTTPoison.Base

import_config "secrets.exs"
import_config "#{config_env()}.exs"
