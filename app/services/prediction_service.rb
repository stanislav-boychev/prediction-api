# Service class responsible for calculating the probability
# of team1 winning over team2
class PredictionService
  WORD = 'defeats'.split('').freeze

  def call(team1:, team2:)
    errors = validate(team1, team2)
    return ServiceErrorResult.new(errors) if errors.any?

    letters = team1.downcase + team2.downcase
    numbers = generate_numbers(letters)

    value = calculate_probability(numbers)
    return ServiceValueResult.new(value) if value

    errors[:probability] << "can't be calculated"
    ServiceErrorResult.new(errors)
  end

  private

  def generate_numbers(letters)
    WORD.each_with_object([]) do |l, arr|
      arr << letters.count(l)
    end
  end

  def calculate_probability(numbers, log: [])
    return numbers.join.to_d / 100 if numbers.size <= 2
    return unless calculation_feasible?(numbers, log)

    log << numbers
    next_numbers = calculate_next(numbers)
    calculate_probability(next_numbers, log: log)
  end

  def calculation_feasible?(numbers, log)
    log.exclude?(numbers) &&
      !superset_of_initial?(numbers, log)
  end

  def superset_of_initial?(numbers, log)
    return false if log.empty?
    init_numbers = log.first
    numbers.size > init_numbers.size &&
      log.any? { |entry| numbers.join.include?(entry.join) }
  end

  def calculate_next(numbers)
    new_numbers = (0..numbers.size - 2).flat_map do |i|
      new_number = numbers[i] + numbers[i + 1]
      new_number.to_s.split('')
    end

    new_numbers.map(&:to_i)
  end

  def validate(team1, team2)
    errors = ErrorHash.new

    errors[:team1] << 'must be present' if team1.nil?
    errors[:team1] << 'must be String' unless team1.is_a? String

    errors[:team2] << 'must be present' if team2.nil?
    errors[:team2] << 'must be String' unless team2.is_a? String

    errors
  end
end
