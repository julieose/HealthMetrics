require 'spec_helper'

RSpec.describe HealthMetrics::Profile do
  let(:profile) do
    described_class.new(
      weight: 70,
      height: 1.75,
      age: 30,
      sex: :male
    )
  end

  describe '#calculate_bmi' do
    it 'returns correct BMI' do
      expect(profile.calculate_bmi).to eq(22.86)
    end
  end

  describe '#bmi_category' do
    it 'returns correct category' do
      expect(profile.bmi_category).to eq(:normal)
    end
  end

  describe '#calculate_ideal_weight' do
    it 'returns correct weight for male' do
      expect(profile.calculate_ideal_weight).to eq(67.5)
    end

    it 'returns correct weight for female' do
      female_profile = described_class.new(
        weight: 60,
        height: 1.65,
        age: 25,
        sex: :female
      )
      expect(female_profile.calculate_ideal_weight).to eq(49.5)
    end
  end
end