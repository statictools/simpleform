ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Simpleform.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Simpleform.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Simpleform.Repo)

