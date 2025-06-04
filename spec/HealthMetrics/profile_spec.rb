require 'spec_helper'

RSpec.describe HealthMetrics::Profile do
  let(:male_profile) do
    described_class.new(
      weight: 80,
      height: 1.80,
      age: 35,
      sex: :male,
      activity_level: :moderate
    )
  end

  let(:female_profile) do
    described_class.new(
      weight: 65,
      height: 1.65,
      age: 30,
      sex: :female,
      activity_level: :active
    )
  end

  describe "валидация параметров" do
    it "запрещает нулевой вес" do
      expect { described_class.new(weight: 0, height: 1.75, age: 30, sex: :male) }
        .to raise_error(ArgumentError, /Weight must be positive/)
    end

    it "запрещает недопустимый пол" do
      expect { described_class.new(weight: 70, height: 1.75, age: 30, sex: :other) }
        .to raise_error(ArgumentError, /Sex must be :male or :female/)
    end
  end

  describe "основные методы" do
    context "ИМТ расчет" do
      it "корректно рассчитывает ИМТ" do
        expect(male_profile.calculate_bmi).to eq(24.69)
      end

      it "определяет категорию :normal для ИМТ 22" do
        allow(male_profile).to receive(:calculate_bmi).and_return(22)
        expect(male_profile.bmi_category).to eq(:normal)
      end
    end

    it "рассчитывает идеальный вес" do
      expect(male_profile.calculate_ideal_weight).to eq(72.0)
      expect(female_profile.calculate_ideal_weight).to eq(49.5)
    end
  end

  describe "нутриенты и калории" do
    it "рассчитывает суточную норму калорий" do
      expect(male_profile.daily_calorie_needs).to be_between(2400, 2600)
      expect(female_profile.daily_calorie_needs).to be_between(2200, 2400)
    end

    it "распределяет БЖУ для похудения" do
      result = male_profile.calculate_macro_distribution(goal: :lose_weight)
      expect(result[:protein]).to be > result[:fat]
      expect(result.values.sum).to be < male_profile.daily_calorie_needs
    end
  end

  describe "состав тела" do
    it "рассчитывает процент жира для мужчин" do
      composition = male_profile.calculate_body_composition(waist: 90, neck: 40)
      expect(composition[:body_fat_percentage]).to be_between(15.0, 25.0)
    end

    it "рассчитывает процент жира для женщин (с учетом бедер)" do
      composition = female_profile.calculate_body_composition(waist: 70, neck: 30, hip: 95)
      expect(composition[:body_fat_percentage]).to be_between(20.0, 30.0)
    end
  end

  describe "прогнозирование" do
    context "похудение" do
      it "оценивает время для потери 5 кг" do
        result = male_profile.calculate_time_to_reach_target_weight(target_weight: 75)
        expect(result[:weeks]).to be_between(8, 12)
        expect(result[:direction]).to eq(:lose)
      end
    end

    context "набор массы" do
      it "оценивает время для набора 5 кг" do
        result = male_profile.calculate_time_to_reach_target_weight(
          target_weight: 85,
          daily_calorie_surplus: 500
        )
        expect(result[:weeks]).to be_between(8, 12)
        expect(result[:direction]).to eq(:gain)
      end
    end
  end

  describe "оценка рисков" do
    it "определяет риски для ожирения" do
      obese = described_class.new(weight: 120, height: 1.70, age: 45, sex: :male)
      risks = obese.calculate_health_risks
      expect(risks[:details][:risks]).to include("Сердечные заболевания")
    end

    it "добавляет возрастные риски после 50 лет" do
      older = described_class.new(weight: 70, height: 1.75, age: 55, sex: :male)
      expect(older.calculate_health_risks[:additional_risks]).to include("Возрастные риски")
    end
  end

  describe "активность" do
    it "рассчитывает сожженные калории при беге" do
      cals = male_profile.calculate_calories_burned(activity_type: :running, duration: 30)
      expect(cals).to be_between(300, 400)
    end
  end
end