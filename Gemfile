source "https://rubygems.org"

# Указываем gemspec для основных зависимостей
gemspec

# Development dependencies (не попадут в итоговый гем)
group :development, :test do
  gem "rspec", "~> 3.12"          # Тестирование
  gem "standard", "~> 1.31"        # Линтинг
  gem "rubocop-rspec", "~> 2.26"   # RSpec-специфичные правила
  gem "simplecov", "~> 0.22", require: false # Покрытие кода (опционально)
  
  # Для работы с GitHub Actions
  gem "rake", "~> 13.1"            # Задачи сборки
  gem "github_changelog_generator", "~> 1.16" # Генератор CHANGELOG (опционально)
end

group :development do
  gem "pry", "~> 0.14"             # Интерактивная отладка
  gem "pry-byebug", "~> 3.10"      # Отладчик
  gem "irb", "~> 1.8"              # Улучшенный REPL
end