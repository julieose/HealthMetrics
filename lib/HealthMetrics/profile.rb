module HealthMetrics
  class Profile
    attr_reader :weight, :height, :age, :sex, :activity_level

    def initialize(weight:, height:, age:, sex:, activity_level: :moderate)
      @weight = weight.to_f
      @height = height.to_f
      @age = age.to_i
      @sex = sex.to_sym
      @activity_level = activity_level.to_sym
      validate_inputs
    end

    # Основные показатели
    def calculate_bmi
      Calculators::BMICalculator.calculate(weight, height)
    end

    def bmi_category
      Calculators::BMICalculator.category(calculate_bmi)
    end

    def calculate_ideal_weight
      Calculators::BMICalculator.ideal_weight(height, sex)
    end

    # Нутриенты и калории
    def daily_calorie_needs
      Calculators::CalorieCalculator.daily_needs(weight, height, age, sex, activity_level)
    end

    def calculate_macro_distribution(goal: :maintain)
      Calculators::MacroCalculator.distribution(
        calories: daily_calorie_needs,
        goal: goal
      )
    end

    # Состав тела
    def calculate_body_composition(waist:, neck:, hip: nil)
      Calculators::BodyCompositionCalculator.analyze(
        sex: sex,
        waist: waist,
        neck: neck,
        hip: hip,
        height: height,
        weight: weight
      )
    end

    # Прогнозирование
    def calculate_time_to_reach_target_weight(target_weight:, daily_calorie_deficit: nil, daily_calorie_surplus: nil)
  Calculators::TimeCalculator.estimate(
    current_weight: weight,
    target_weight: target_weight,
    daily_deficit: daily_calorie_deficit,
    daily_surplus: daily_calorie_surplus
  )
end

    def calculate_calories_burned(activity_type:, duration:)
      Calculators::CalorieCalculator.burned(
        activity: activity_type,
        duration: duration,
        weight: weight
      )
    end

    # Риски здоровья
    def calculate_health_risks
      Calculators::RiskCalculator.assess(
        bmi: calculate_bmi,
        age: age,
        sex: sex
      )
    end

    private

    def validate_inputs
      raise ArgumentError, "Weight must be positive" unless weight.positive?
      raise ArgumentError, "Height must be positive" unless height.positive?
      raise ArgumentError, "Age must be positive" unless age.positive?
      unless %i[male female].include?(sex)
        raise ArgumentError, "Sex must be :male or :female"
      end
    end
  end
end