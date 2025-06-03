require "spec_helper"

RSpec.describe HealthMetrics::Calculators::CalorieCalculator do
  describe ".daily_needs" do
    it "calculates for male" do
      expect(described_class.daily_needs(70, 1.75, 30, :male, :moderate)).to eq(2503)
    end
  end
end