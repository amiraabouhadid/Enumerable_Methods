require_relative '../enums'

describe Enumerable do
  describe '#my_each' do
    it 'Returns my_each object if no block given' do
      expect((1..3).my_each).to be_a(Enumerable)
    end

    it 'Returns itself' do
      expect((1..3).my_each { |el| el }).to eq((1..3))
      expect({ key1: 10, key2: 20 }.my_each { |el| el }).to eq({ key1: 10, key2: 20 })
    end
  end

  describe '#my_each_with_index' do
    it 'Returns my_each_with_index object if no block given' do
      expect((1..3).my_each_with_index).to be_a(Enumerable)
    end

    it 'Returns itself' do
      expect((1..3).my_each_with_index { |el| el }).to eq((1..3))
      expect({ key1: 10, key2: 20 }.my_each_with_index { |el| el }).to eq({ key1: 10, key2: 20 })
    end
  end

  describe '#my_select' do
    it 'Returns my_select object if no block given' do
      expect((1..3).my_select).to be_a(Enumerable)
    end

    it 'Returns Array' do
      expect((1..3).my_select { |el| el }).to be_a(Array)
      expect({ key1: 10, key2: 20 }.my_select { |el| el }).to be_a(Array)
    end
  end

  describe '#my_all?' do
    it 'Returns true if self is empty' do
      expect([].my_all?).to be(true)
    end

    it 'Returns true if All Items include particular string, when only RegExp param given' do
      expect(%w[name man van].my_all?(/n/)).to be(true)
    end

    it 'Returns false if not all items include particular string, when only RegExp param given' do
      expect(%w[name man hat].my_all?(/n/)).to be(false)
    end

    it 'Returns true if All Items are of given Class, when only Class param given' do
      expect(%w[name man van].my_all?(String)).to be(true)
    end

    it 'Returns false if not all items are of given Class, when only Class param given' do
      expect(['name', 'man', :van].my_all?(String)).to be(false)
    end

    it 'Returns true if all items are equal to item given as param' do
      expect(%w[man man man].my_all?('man')).to be(true)
    end

    it 'Returns false if not all items are equal to item given as param' do
      expect(%w[man man woman].my_all?('man')).to be(false)
    end

    it 'Returns true if none of items are nil/false, when no param nor block given' do
      expect(%w[name man van].my_all?).to be(true)
    end

    it 'Returns false if any of items are nil/false, when no param nor block given' do
      expect(['name', 'man', nil].my_all?).to be(false)
    end

    it 'Returns true if all items yields to true, if only block given' do
      expect((1..3).my_all? { |el| el > 0 }).to be(true)
    end

    it 'Returns false if not all items yields to true, if only block given' do
      expect((1..3).my_all? { |el| el > 2 }).to be(false)
    end
  end

  describe '#my_any?' do
    it 'Returns true if at least one item have particular string, when only RegExp param given' do
      expect(%w[name man van].my_any?(/e/)).to be(true)
    end

    it 'Returns false if not one item have particular string, when only RegExp param given' do
      expect(%w[mom man van].my_any?(/e/)).to be(false)
    end

    it 'Returns true at least one item is of given Class, when only Class param given' do
      expect([nil, :fake, 'str'].my_any?(String)).to be(true)
    end

    it 'Returns false if not one item is of given Class, when only Class param given' do
      expect([nil, :fake, 1].my_any?(String)).to be(false)
    end

    it 'Returns true if at least one item yields true, if only block given' do
      expect((1..3).my_any? { |el| el > 2 }).to be(true)
    end

    it 'Returns false if not one item yields true, if only block given' do
      expect(([1,2]).my_any? { |el| el > 2 }).to be(false)
    end

    it 'Returns true if at least one of items is not nil/false, when no param nor block given' do
      expect(['name', false, nil].my_any?).to be(true)
    end

    it 'Returns false if none of items is not nil/false, when no param nor block given' do
      expect([false, nil].my_any?).to be(false)
    end
  end

  describe '#my_none?' do
    it 'Returns true if self is empty' do
      expect([].my_none?).to be(true)
    end

    it 'Returns true if none of items have particular string, when only RegExp param given' do
      expect(%w[name man van].my_none?(/z/)).to be(true)
    end

    it 'Returns false if one of items have particular string, when only RegExp param given' do
      expect(%w[name zebra van].my_none?(/z/)).to be(false)
    end

    it 'Returns true none of items is of given Class, when only Class param given' do
      expect([nil, :fake, 'str'].my_none?(Numeric)).to be(true)
    end

    it 'Returns false if one of items is of given Class, when only Class param given' do
      expect([1, :fake, 'str'].my_none?(Numeric)).to be(false)
    end

    it 'Returns true if none of items equal to item given as param' do
      expect(%w[name yeah nile].my_none?('brick')).to be(true)
    end

    it 'Returns false if one of items equal to item given as param' do
      expect(%w[name brick nile].my_none?('brick')).to be(false)
    end

    it 'Returns true if none of items yields true, if only block given' do
      expect((1..3).my_none? { |el| el > 3 }).to be(true)
    end

    it 'Returns false if one of items yields true, if only block given' do
      expect(([3,4]).my_none? { |el| el > 3 }).to be(false)
    end
  end

  describe '#my_count' do
    it 'Returns number' do
      expect((1..3).my_count).to be_a(Integer)
    end

    it 'Returns number of elements in self' do
      expect((1..3).my_count).to eq(3)
    end

    it 'Return number of elements that yield true, when block is given' do
      expect((1..3).my_count { |el| el > 1 }).to eq(2)
    end

    it 'Return the number of elements that are equal to given param' do
      expect([1, 2, 2, 1, 2, 3, 2].my_count(2)).to eq(4)
    end
  end

  describe '#my_map' do
    it 'Returns my_map object if no block given' do
      expect((1..3).my_map).to be_a(Enumerable)
    end

    it 'Returns array' do
      expect((1..3).my_map { |el| el > 0 }).to be_a(Array)
    end

    it 'Returns array of elements with yielded results, when only block given' do
      expect((1..3).my_map { |el| el * 2 }).to eq([2, 4, 6])
      expect((1..3).my_map { 'zil' }).to eq(%w[zil zil zil])
    end
  end

  describe '#my_inject' do
    it 'Raises LocalJumpError if no block nor any params given' do
      expect { (1..3).my_inject }.to raise_error(LocalJumpError)
    end

    it 'Returns the result, when only symbol/string with math symbols is passed as param' do
      expect((1..3).my_inject(:+)).to eq(6)
      expect((1..3).my_inject('+')).to eq(6)
      expect((1..3).my_inject(:*)).to eq(6)
      expect((1..3).my_inject('*')).to eq(6)
      expect((1..3).my_inject(:-)).to eq(-4)
      expect((1..3).my_inject('-')).to eq(-4)
      expect((1..3).my_inject(:/)).to eq(0)
      expect((1..3).my_inject('/')).to eq(0)
      expect((2..4).my_inject(:**)).to eq(4096)
      expect((2..4).my_inject('**')).to eq(4096)
    end

    it 'Returns the result, when param 1 is default memo value and param2 is a symbol/string with math symbol' do
      expect((1..3).my_inject(2, :+)).to eq(8)
      expect((1..3).my_inject(2, '+')).to eq(8)
      expect((1..3).my_inject(2, :*)).to eq(12)
      expect((1..3).my_inject(2, '*')).to eq(12)
      expect((1..3).my_inject(2, :-)).to eq(-4)
      expect((1..3).my_inject(2, '-')).to eq(-4)
      expect((1..3).my_inject(2, :/)).to eq(0)
      expect((1..3).my_inject(2, '/')).to eq(0)
      expect((2..4).my_inject(2, :**)).to eq(16_777_216)
      expect((2..4).my_inject(2, '**')).to eq(16_777_216)
    end

    it 'Returns the result, when param1 and block is given' do
      expect((1..3).my_inject(2) { |acc, val| acc + val }).to eq(8)
    end

    it 'Returns the result when only block given' do
      expect((1..3).my_inject { |acc, val| acc + val }).to eq(6)
    end

    it 'Returns result from multiply_els method' do
      expect(multiply_els(1..3)).to eq(6)
    end

  end
end
