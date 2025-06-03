module HealthMetrics
  module Calculators
    class RiskCalculator
      RISK_CATEGORIES = {
        underweight: {
          risks: ["Остеопороз", "Анемия", "Нарушения иммунитета"],
          advice: "Рекомендуется увеличить калорийность питания"
        },
        normal: {
          risks: ["Минимальные риски"],
          advice: "Поддерживайте текущий режим"
        },
        overweight: {
          risks: ["Диабет 2 типа", "Гипертония"],
          advice: "Рекомендуется снижение веса на 5-10%"
        },
        obese: {
          risks: ["Сердечные заболевания", "Инсульт", "Апноэ"],
          advice: "Требуется консультация врача"
        }
      }.freeze

      def self.assess(bmi:, age:, sex:)
        category = if bmi < 18.5
                     :underweight
                   elsif bmi < 25
                     :normal
                   elsif bmi < 30
                     :overweight
                   else
                     :obese
                   end

        {
          category: category,
          details: RISK_CATEGORIES[category],
          additional_risks: (age > 50 && category != :normal) ? ["Возрастные риски"] : []
        }
      end
    end
  end
end
