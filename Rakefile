require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"

# Задача по умолчанию (запускается при `bundle exec rake`)
task default: %i[spec standard]

# RSpec задачи
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--color --format progress"
end

# StandardRB задачи
namespace :lint do
  task :standard do
    require "standard"
    Standard::Cli.new.run
  end
end


# Генерация CHANGELOG.md (опционально)
task :changelog do
  require "github_changelog_generator/task"
  GitHubChangelogGenerator::RakeTask.new do |config|
    config.user = "ваш-username"
    config.project = "HealthMetrics"
    config.future_release = "v#{HealthMetrics::VERSION}"
  end
end

# Доп. утилиты
desc "Запуск интерактивной консоли с загруженным гемом"
task :console do
  require "irb"
  require "health_metrics"
  ARGV.clear
  IRB.start
end