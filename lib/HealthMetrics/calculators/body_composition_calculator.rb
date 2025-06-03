module HealthMetrics
  module Calculators
    class BodyCompositionCalculator
      # Расчет процента жира по формуле ВМС США (US Navy Method)
      def self.body_fat_percentage(sex:, waist:, neck:, hip: nil, height:)
        if sex == :male
          86.010 * Math.log10(waist - neck) - 70.041 * Math.log10(height) + 36.76
        else
          163.205 * Math.log10(waist + (hip || 0) - neck) - 97.684 * Math.log10(height) - 78.387
        end.round(1)
      end

      # Расчет сухой массы тела (Lean Body Mass)
      def self.lean_body_mass(weight:, body_fat_percentage:)
        (weight * (100 - body_fat_percentage) / 100.0).round(1)
      end
    end
  end
end
