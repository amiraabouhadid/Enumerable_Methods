module Enumerable
  def my_each
    for i in self
      yield i
    end
  end

  def my_each_with_index
    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  def my_select
    arr = []
    my_each { |i| arr << i if yield i }
    arr
  end
end
