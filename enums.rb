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
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |n| arr.push(n) if yield n }
    arr
  end

  def my_all?(para = nil, &block)
    if !para && !block_given?
      return my_select { |n| !n.nil? && n != false }.size == size
    end

    if para
      case para
      when Regexp
        return my_select { |n| n.match(para) }.size == size
      when Class
        return my_select { |n| n.is_a?(para) }.size == size
      else
        return my_each { |n| n == para }
      end
    end
    return my_select(&block).size == size if block_given?
  end

  def my_any?(para = nil, &block)
    if !para && !block_given?
      return my_select { |n| n.nil? || n == false }.size.positive? ? false : true
    end

    if para
      case para
      when Regexp
        return my_select { |n| n.match(para) }.size.positive?
      when Class
        return my_select { |n| n.is_a?(para) }.size.positive?
      else
        return my_each { |n| n == para }
      end
    end
    return my_select(&block).size.positive? if block_given?
  end

  def my_none?(para = nil, &block)
    if !para && !block_given?
      return my_select { |n| n == true }.size.positive? ? false : true
    end

    if para
      case para
      when Regexp
        return !my_select { |n| n.match(para) }.size.positive?
      when Class
        return !my_select { |n| n.is_a?(para) }.size.positive?
      else
        return my_each { |n| n != para }
      end
    end
    return !my_select(&block).size.positive? if block_given?
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
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each { |n| arr.push(yield(n)) } if block_given? && !proc
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
