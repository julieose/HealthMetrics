module HealthMetrics
  module Calculators
    class CalorieCalculator
      ACTIVITY_FACTORS = {
        sedentary: 1.2,
        light: 1.375,
        moderate: 1.55,
        active: 1.725,
        very_active: 1.9
      }.freeze

      def self.daily_needs(weight, height, age, sex, activity_level)
        bmr = if sex == :male
                88.362 + (13.397 * weight) + (4.799 * height * 100) - (5.677 * age)
              else
                447.593 + (9.247 * weight) + (3.098 * height * 100) - (4.330 * age)
              end

        (bmr * ACTIVITY_FACTORS[activity_level]).round
      end

      def self.burned(activity, duration, weight)
        # METs values for common activities
        mets = {
          running: 7.5,
          cycling: 6.0,
          swimming: 5.8,
          walking: 3.0
        }

        calories = mets[activity] * duration * (weight / 60.0)
        calories.round
      end
    end
  end
end