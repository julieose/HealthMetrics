require 'spec_helper'

RSpec.describe HealthMetrics::Calculators::BMICalculator do
  describe '.calculate' do
    it 'returns correct BMI for normal weight' do
      expect(described_class.calculate(70, 1.75)).to eq(22.86)
    end
  end

  describe '.category' do
    it 'identifies obesity' do
      expect(described_class.category(32)).to eq(:obese_class1)
    end
  end
end