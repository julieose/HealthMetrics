module HealthMetrics
  module Calculators
    class TimeCalculator
      # Расчет времени до цели с учетом направления изменения веса
      # daily_surplus - профицит калорий для набора массы (по умолчанию +500 ккал)
      # daily_deficit - дефицит калорий для похудения (по умолчанию -500 ккал)
      def self.estimate(current_weight:, target_weight:, daily_deficit: -500, daily_surplus: 500)
        weight_diff = current_weight - target_weight
        direction = weight_diff <=> 0 # 1 = lose, -1 = gain, 0 = maintain

        case direction
        when 1 # Похудение
          days = (weight_diff.abs * 7700 / daily_deficit.abs.to_f).ceil
        when -1 # Набор массы
          days = (weight_diff.abs * 7700 / daily_surplus.to_f).ceil
        else
          return { weeks: 0, days: 0, message: "Целевой вес достигнут" }
        end

        {
          weeks: (days / 7.0).ceil,
          days: days,
          direction: direction == 1 ? :lose : :gain
        }
      end
    end
  end
end
