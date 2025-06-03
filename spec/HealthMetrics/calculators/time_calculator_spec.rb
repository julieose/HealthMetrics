require 'spec_helper'

RSpec.describe HealthMetrics::Calculators::TimeCalculator do
  describe '.estimate' do
    context 'при похудении' do
      it 'рассчитывает правильное время для потери веса' do
        result = described_class.estimate(
          current_weight: 80,
          target_weight: 75,
          daily_deficit: -500
        )
        expect(result[:weeks]).to eq(10) # 5кг * 7700 / 500 = 77 дней ≈ 11 недель
        expect(result[:direction]).to eq(:lose)
      end
    end

    context 'при наборе массы' do
      it 'рассчитывает правильное время для набора веса' do
        result = described_class.estimate(
          current_weight: 70,
          target_weight: 75,
          daily_surplus: 500
        )
        expect(result[:weeks]).to eq(10) # 5кг * 7700 / 500 = 77 дней ≈ 11 недель
        expect(result[:direction]).to eq(:gain)
      end
    end

    context 'когда вес уже достигнут' do
      it 'возвращает 0 дней' do
        result = described_class.estimate(
          current_weight: 70,
          target_weight: 70
        )
        expect(result[:days]).to eq(0)
        expect(result[:message]).to include("достигнут")
      end
    end

    context 'с кастомными параметрами' do
      it 'корректно работает с разными дефицитами/профицитами' do
        lose_result = described_class.estimate(current_weight: 80, target_weight: 75, daily_deficit: -250)
        gain_result = described_class.estimate(current_weight: 70, target_weight: 75, daily_surplus: 250)
        
        expect(lose_result[:days]).to eq(gain_result[:days])
        expect(lose_result[:days]).to be > 150 # Увеличивается время при меньшем дефиците
      end
    end
  end
end
