require 'spec_helper'

RSpec.describe HealthMetrics::Calculators::BodyCompositionCalculator do
  describe '.body_fat_percentage' do
    it 'calculates correctly for female' do
      result = described_class.body_fat_percentage(
        sex: :female,
        waist: 70,
        neck: 30,
        hip: 95,
        height: 1.65
      )
      expect(result).to be_between(15.0, 35.0)
    end
  end
end
