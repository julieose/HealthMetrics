require 'spec_helper'

RSpec.describe HealthMetrics::Calculators::MacroCalculator do
  describe '.distribution' do
    it 'returns proper macros for weight loss' do
      result = described_class.distribution(calories: 2000, goal: :lose_weight)
      expect(result[:protein]).to be > result[:fat]
    end
  end
end