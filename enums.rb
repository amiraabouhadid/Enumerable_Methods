# rubocop:disable Style/Linesize, Style/NestedTernaryOperator, Style/MultilineTernaryOperator, Style/ParallelAssignment, Style/IfUnlessModifier, Style/ExplicitBlockArgument, Style/For, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  def my_select
    arr = []
    return to_enum(:my_select) unless block_given?

    my_each { |n| arr.push(n) if yield n }
    arr
  end

  def my_all?(*args)
    case args.size
    when 0
      block_given? ? my_select { |n| yield n }.size == size : true
    when 1
      args.first.is_a?(Regexp) ?
      my_select { |n| n.match(args.first) }.size == size :
      my_select { |n| n.is_a?(args.first) }.size == size
    end
  end

  def my_any?(*args)
    case args.size
    when 0
      block_given? ? my_select { |n| yield n }.size.positive? : true
    when 1
      args.first.is_a?(Regexp) ?
      my_select { |n| n.match(args.first) }.size.positive? :
      my_select { |n| n.is_a?(args.first) }.size.positive?
    end
  end

  def my_none?(*args)
    case args.size
    when 0
      block_given? ? !my_select { |n| yield n }.size.positive? : !my_select { |n| n == true }.size.positive?
    when 1
      args.first.is_a?(Regexp) ?
      !my_select { |n| n.match(args.first) }.size.positive? :
      !my_select { |n| n.is_a?(args.first) }.size.positive?
    end
  end

  def my_count(*args)
    case args.size
    when 0
      block_given? ? my_select { |n| yield n }.size : size
    when 1
      block_given? ? my_select { |n| yield(args.first, n) && n == args.first }.size : my_select { |n| n == args.first }.size
    end
  end

  def my_map(proc = nil)
    arr = []
    return to_enum(:my_map) unless block_given?
    my_each { |n| arr.push(yield(n)) } if block_given?
    my_each { |n| arr.push(proc.call(n)) } if proc
    arr
  end

  def my_inject(total = nil, symb = nil)
    if (total.is_a?(Symbol) || total.is_a?(String)) && symb.nil?
      symb, total = total, nil
    end
    !block_given? && !symb.nil? ?
    my_each { |n| total = total.nil? ? n : total.send(symb, n) } :
    my_each { |n| total = total.nil? ? n : yield(total, n) }
    total
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, n| product * n }
end
# rubocop:enable Style/Linesize, Style/NestedTernaryOperator, Style/MultilineTernaryOperator, Style/ParallelAssignment, Style/IfUnlessModifier, Style/ExplicitBlockArgument, Style/For, Metrics/CyclomaticComplexity
