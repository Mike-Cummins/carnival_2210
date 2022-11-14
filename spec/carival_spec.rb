require './lib/ride'
require './lib/visitor'
require './lib/carnival'

RSpec.describe Carnival do
  it 'exists and has attributes' do
    carnival = Carnival.new("State Fair", 3)

    expect(carnival).to be_a(Carnival)
    expect(carnival.name).to eq("State Fair")
    expect(carnival.duration).to eq(3)
  end

  it 'has rides, empty by default' do 
    carnival = Carnival.new("State Fair", 3)

    expect(carnival.rides).to eq([])
  end

  it 'can have rides added' do
    carnival = Carnival.new("State Fair", 3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.rides).to eq([ride1, ride2, ride3])
  end

  it 'shows most popular ride' do
    carnival = Carnival.new("State Fair", 3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(carnival.most_popular_ride).to eq(ride1)
  end
end