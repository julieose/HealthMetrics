require 'spec_helper'

RSpec.describe HealthMetrics::Calculators::RiskCalculator do
  describe '.assess' do
    it 'flags risks for obese person' do
      result = described_class.assess(bmi: 32, age: 45, sex: :male)
      expect(result[:details][:risks]).to include("Сердечные заболевания")
    end
  end
end
