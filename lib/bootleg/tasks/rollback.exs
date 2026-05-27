alias Bootleg.{Config, UI}
use Bootleg.DSL

task :rollback do
  app = Config.app()

  remote :app do
    "test $(ls -1d releases/*/ 2>/dev/null | wc -l) -ge 2 || (echo 'No previous release to roll back to' && exit 1)"
    "previous=$(ls -1dt releases/*/ | sed -n '2p') && ln -sfn $previous current"
    "current/bin/#{app} restart"
  end

  UI.info("#{app} rolled back")
end
