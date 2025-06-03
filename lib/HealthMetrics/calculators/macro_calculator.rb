module HealthMetrics
  module Calculators
    class MacroCalculator
      GOAL_RATIOS = {
        lose_weight: { protein: 0.4, fat: 0.3, carbs: 0.3 },
        gain_mass: { protein: 0.35, fat: 0.25, carbs: 0.4 },
        maintain: { protein: 0.3, fat: 0.3, carbs: 0.4 }
      }.freeze

      def self.distribution(calories:, goal:)
        ratios = GOAL_RATIOS[goal]
        {
          protein: (calories * ratios[:protein] / 4).round, # 4 kcal per gram
          fat: (calories * ratios[:fat] / 9).round,         # 9 kcal per gram
          carbs: (calories * ratios[:carbs] / 4).round      # 4 kcal per gram
        }
      end
    end
  end
end