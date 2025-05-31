# frozen_string_literal: true

require_relative "lib/HealthMetrics/version"

Gem::Specification.new do |spec|
  spec.name = "HealthMetrics"
  spec.version = HealthMetrics::VERSION
  spec.authors = ["julieose", "Nastya-22-06"]
  spec.email = ["julianureevs@gmail.com"]

  spec.summary = "Универсальный Ruby-гем для анализа показателей здоровья."
  s.description = <<-DESC
HealthMetrics — это комплексный Ruby-гем для анализа здоровья. 
📊 Основные возможности:
• Расчет ИМТ с категоризацией рисков
• Определение идеального веса (с учетом роста и пола)
• Расчет суточной нормы калорий (по возрасту/весу/росту/полу)
• Анализ состава тела (процент жира, сухая масса)
• Рекомендации БЖУ для похудения/набора массы
• Подсчет сожженных калорий по активности
• Прогноз достижения целевого веса
• Оценка рисков заболеваний
DESC
  spec.homepage = "https://github.com/julieose/HealthMetrics"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"с
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/julieose/HealthMetrics"
  

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
