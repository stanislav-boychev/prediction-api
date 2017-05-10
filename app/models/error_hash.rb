# Convinient class for storing errors
class ErrorHash < Hash
  def initialize
    super { |h, k| h[k] = [] }
  end

  def add(name, msg)
    self[name.to_sym] << msg
  end
end
