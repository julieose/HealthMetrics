module HealthMetrics
  module Calculators
    class BMICalculator
      def self.calculate(weight, height)
        (weight / (height ** 2)).round(2)
      end

      def self.category(bmi)
        case bmi
        when 0..18.5 then :underweight
        when 18.5..24.9 then :normal
        when 25..29.9 then :overweight
        when 30..34.9 then :obese_class1
        when 35..39.9 then :obese_class2
        else :obese_class3
        end
      end

      def self.ideal_weight(height, sex)
        case sex
        when :male then (height * 100 - 100) * 0.9
        when :female then (height * 100 - 110) * 0.9
        end.round(2)
      end
    end
  end
end