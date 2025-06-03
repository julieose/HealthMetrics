require 'spec_helper'

RSpec.describe HealthMetrics do
  let(:user) do
    HealthMetrics::Profile.new(
      weight: 70,     # кг
      height: 1.75,   # метры
      age: 30,
      sex: :male,
      activity_level: :moderate
    )
  end

  describe "Основные методы" do
    it "рассчитывает ИМТ и категорию" do
      expect(user.calculate_bmi).to eq(22.86)
      expect(user.bmi_category).to eq(:normal)
    end

    it "рассчитывает идеальный вес" do
      expect(user.calculate_ideal_weight).to be_between(65, 75) # ~67.5 для мужчины
    end
  end

  describe "Нутриенты и калории" do
    it "рассчитывает суточную норму калорий" do
      expect(user.daily_calorie_needs).to be_between(2000, 3000)
    end

    it "распределяет БЖУ для похудения" do
      macros = user.calculate_macro_distribution(goal: :lose_weight)
      expect(macros[:protein]).to be > macros[:fat]
      expect(macros.values.sum).to be <= user.daily_calorie_needs
    end
  end

  describe "Состав тела" do
    it "рассчитывает процент жира" do
      composition = user.calculate_body_composition(waist: 85, neck: 38)
      expect(composition[:body_fat_percentage]).to be_between(10, 25)
      expect(composition[:lean_mass]).to be_between(50, 65)
    end
  end

  describe "Прогнозирование" do
    context "похудение" do
      it "оценивает время достижения цели" do
        result = user.calculate_time_to_reach_target_weight(target_weight: 65)
        expect(result[:weeks]).to be_between(8, 12)
        expect(result[:direction]).to eq(:lose)
      end
    end

    context "набор массы" do
      it "оценивает время достижения цели" do
        result = user.calculate_time_to_reach_target_weight(
          target_weight: 75,
          daily_calorie_surplus: 500
        )
        expect(result[:weeks]).to be_between(8, 12)
        expect(result[:direction]).to eq(:gain)
      end
    end
  end

  describe "Риски здоровья" do
    it "определяет категорию риска" do
      risks = user.calculate_health_risks
      expect(risks[:category]).to eq(:normal)
      expect(risks[:details][:advice]).to include("Поддерживайте")
    end

    context "при ожирении" do
      it "показывает повышенные риски" do
        obese_user = HealthMetrics::Profile.new(
          weight: 100,
          height: 1.70,
          age: 45,
          sex: :male
        )
        risks = obese_user.calculate_health_risks
        expect(risks[:details][:risks]).to include("Сердечные")
      end
    end
  end

  describe "Edge cases" do
    it "работает с нулевым ростом (выбрасывает ошибку)" do
      expect {
        HealthMetrics::Profile.new(weight: 70, height: 0, age: 30, sex: :male)
      }.to raise_error(ArgumentError)
    end

    it "корректно обрабатывает достигнутый вес" do
      result = user.calculate_time_to_reach_target_weight(target_weight: 70)
      expect(result[:days]).to eq(0)
    end
  end
end

