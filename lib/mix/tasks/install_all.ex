defmodule Mix.Tasks.InstallAll do
  use Mix.Task

  @shortdoc "Installs all deps for elixir node and runs required migrations"
  def run(_) do
    Mix.Task.run("deps.get")
    Mix.Task.run("ecto.migrate")
    File.cd("assets")
    System.cmd("npm", ["install"])
  end
  
end
