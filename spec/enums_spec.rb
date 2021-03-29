require_relative '../enums'

describe Enumerable do
    describe "#my_each" do
        it "Returns my_each object if no block given" do
            expect((1..3).my_each).to be_a(Enumerable)
        end

        it "Returns itself" do
            expect((1..3).my_each{ |el| el }).to eq((1..3))
            expect({ key1: 10, key2: 20 }.each{ |el| el }).to eq({ key1: 10, key2: 20 })
        end
    end
end