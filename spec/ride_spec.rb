require './lib/ride'
require './lib/visitor'

RSpec.describe Ride do
  it 'exists and has attributes' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1).to be_a(Ride)
    expect(ride1.name).to eq("Carousel")
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
  end

  it 'tracks total revenue, starts at 0' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1.total_revenue).to eq(0)
  end

  it 'has a rider log, empty by default' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1.rider_log).to eq({})
  end

  it 'can board riders that meet height and match preferences' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Bob', 20, '$5')
    visitor4 = Visitor.new('Jim', 36, '$5')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:gentle)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)
    ride1.board_rider(visitor4)

    expect(ride1.rider_log).to be_a(Hash)
    expect(ride1.rider_log.keys).to eq([visitor1, visitor2])
  end

  it 'takes admission fee from visitors spending money when they board' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    
    expect(ride1.rider_log.keys).to eq([visitor1, visitor2])
    expect(visitor1.spending_money).to eq(9)
    expect(visitor2.spending_money).to eq(4)
  end

  it 'can calculate total revenue' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)

    expect(ride1.total_revenue).to eq(2)
  end
end