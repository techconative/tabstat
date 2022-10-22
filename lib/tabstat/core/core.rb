
# Represents an operation in an expression.
class Operation
  attr_accessor :operator, :param

  def initialize(op, param)
    @operator = op
    @param = param
  end
end

# Represents the context that will be passed to each operator
class Context
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def with_data(data)
    Context.new(data)
  end
end