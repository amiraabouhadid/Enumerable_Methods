# rubocop:disable Style/LineLength, Style/StringLiterals
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
    case args.length
    when 0
      block_given? ? my_select { |n| yield n }.length == size : false
    when 1
      args.first.is_a?(Regexp) ?
      my_select { |n| n.match(args.first) }.length == length :
      my_select { |n| n.is_a?(args.first) }.length == length
    end
  end

  def my_any?(*args)
    case args.length
    when 0
      block_given? ? my_select { |n| yield n }.length.positive? : false
    when 1
      args.first.is_a?(Regexp) ?
      my_select { |n| n.match(args.first) }.length.positive? :
      my_select { |n| n.is_a?(args.first) }.length.positive?
    end
  end

  def my_none?(*args)
    case args.length
    when 0
      block_given? ? !my_select { |n| yield n }.length.positive? : !my_select { |n| n == true }.length.positive?
    when 1
      args.first.is_a?(Regexp) ?
      !my_select { |n| n.match(args.first) }.length.positive? :
      !my_select { |n| n.is_a?(args.first) }.length.positive?
    end
  end

  def my_count(*args)
    case args.length
    when 0
      block_given? ? my_select { |n| yield n }.length : length
    when 1
      block_given? ? my_select { |n| yield(args.first, n) && n == args.first }.length : my_select { |n| n == args.first }.length
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
# rubocop:enable Style/LineLength, Style/StringLiterals
