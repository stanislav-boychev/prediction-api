# Class idicating failed result
class ServiceErrorResult
  attr_reader :errors

  def initialize(errors)
    if errors.nil?
      raise 'cannot create an error result given a nil error object'
    end
    if errors.empty?
      raise 'cannot create an error result given an empty error object'
    end
    @errors = errors
  end

  def success?
    false
  end

  def fail?
    !success?
  end
end
