module Enumerable
  def my_each
    return unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  def my_select
    arr = []
    my_each { |n| arr << n if yield n } if block_given?
    arr
  end

  def my_all?
    my_select { |n| yield n }.length == length if block_given?
  end

  def my_any?
    my_select { |n| yield n }.length.positive? if block_given?
  end

  def my_none?
    !my_any? if block_given?
  end

  def my_count
    my_select { |n| yield n }.length if block_given?
  end

  def my_map(proc = nil)
    arr = []
    my_each { |n| arr << yield(n) } if block_given?
    my_each { |n| arr << proc.call(n) } if proc
    arr
  end

  def my_inject(*arguments)
    case arguments.length
    when 1
      arguments.first.is_a?(Symbol) ? operator = arguments.first : total = arguments.first
    when 2
      total = arguments.first
      operator = arguments.last
    end
    total ||= 0
    my_each { |n| total = block_given? ? yield(total, n) : total.send(operator, n) }
    total
  end

  def multiply_els
    my_inject(1) { |product, n| product * n }
  end
end
