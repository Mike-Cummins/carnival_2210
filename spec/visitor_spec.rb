require './lib/visitor'

RSpec.describe Visitor do
  it 'exists and has attributes' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1).to be_a(Visitor)
    expect(visitor1.name).to eq('Bruce')
    expect(visitor1.height).to eq(54)
    expect(visitor1.spending_money).to eq(10)
  end

  it 'has preferences, empty by default' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.preferences).to eq([])
  end

  it 'can add preferences' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.add_preference(:gentle)
    visitor1.add_preference(:water)

    expect(visitor1.preferences).to eq(%i[gentle water])
  end

  it 'can tell if it is tall enough' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    expect(visitor1.tall_enough?(54)).to be(TRUE)
    expect(visitor2.tall_enough?(54)).to be(FALSE)
    expect(visitor3.tall_enough?(54)).to be(TRUE)
    expect(visitor1.tall_enough?(64)).to be(FALSE)
  end
end
