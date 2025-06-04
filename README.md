<h1 align="center">
  HealthMetrics
</h1>

<p align="center">
  <strong>Универсальный Ruby-гем для анализа показателей здоровья</strong>
</p>


<br>

<h2>📊 Возможности</h2>

<ul>
  <li><b>📏 Индекс массы тела (ИМТ)</b> с категоризацией рисков</li>
  <li><b>⚖️ Идеальный вес</b> с учётом роста и пола</li>
  <li><b>🔥 Суточная норма калорий</b> (учитывает возраст, вес, рост и пол)</li>
  <li><b>💪 Состав тела:</b> процент жира, сухая масса тела</li>
  <li><b>🍎 Распределение БЖУ</b> по целям: похудение или набор массы</li>
  <li><b>🏃 Расчет сожженных калорий</b> по виду деятельности</li>
  <li><b>⏱️ Прогноз достижения целевого веса</b></li>
  <li><b>⚠️ Оценка рисков заболеваний</b> на основе параметров</li>
</ul>

<h2>🎯 Идеальное решение для</h2>

<li><b>Приложений для ЗОЖ</b></li>
<li><b>Фитнес-приложений</b></li>
<li><b>Персональных трекеров прогресса</b></li>

# HealthMetrics API

API для расчета ключевых показателей здоровья и фитнеса


```ruby
user = HealthMetrics::Profile.new(
  weight: 70,    # в кг
  height: 1.75,  # в метрах
  age: 30,
  sex: :male     # :male / :female
  activity_level: moderate
)
Доступные методы:
📊 Основные показатели:

Расчет ИМТ
bmi = user.calculate(weight, height)
category = user.category(bmi)
Возвращает индекс массы тела

Идеальный вес
ideal_weight = user.ideal_weight(height, sex)

Расчет оптимального веса по формуле

🔥 Нутриенты и калории
Суточная норма калорий
daily_calories = user.daily_needs(weight, height, age, sex, activity_level)
calories_burned = user.burned (activity, duration, weight)
Количество калорий для поддержания веса

Распределение БЖУ
macro_distribution = user.distribution(calories:, goal:)
Оптимальное соотношение белков/жиров/углеводов

💪 Состав тела
Анализ тела
body_composition = user.body_fat_percentage(sex:, waist:, neck:, hip: nil, height:)
Расчет процента жира и мышечной массы

⏱ Прогнозирование
Время до цели
time_to_goal = user.estimate(current_weight:, target_weight:, daily_deficit: 500)
Оценка времени достижения целевого веса

Сожженные калории
calories_burned = user.calculate_calories_burned(activity_type: :running, duration: 60)

⚠️ Риски здоровья
Оценка рисков
health_risk = user.assess(bmi:, age:, sex:)
Анализ потенциальных заболеваний
