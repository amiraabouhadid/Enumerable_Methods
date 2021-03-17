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
    return unless block_given?

    arr = []
    my_each { |n| arr << n if yield n }
    arr
  end

  def my_all?
    return unless block_given?

    my_select { |n| yield n }.length == length
  end

  def my_any?
    return unless block_given?

    my_select { |n| yield n }.length.positive?
  end

  def my_none?
    return unless block_given?

    !my_any?
  end

  def my_count
    return unless block_given?

    my_select { |n| yield n }.length
  end

  def my_map
    arr=[]
    my_each { |n| arr << yield(n) } if block_given?
    arr
  end

  def my_inject
  end
end
