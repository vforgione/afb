defmodule Afb.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Afb.Repo, []),
      supervisor(AfbWeb.Endpoint, []),
      supervisor(Afb.Scheduler, []),
    ]

    :ok = :error_logger.add_report_handler(Sentry.Logger)

    opts = [strategy: :one_for_one, name: Afb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    AfbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
