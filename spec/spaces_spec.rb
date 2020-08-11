require_relative 'spec_helper'

describe Spaces do

  before 'generate master user' do
    generate_example_master
  end

  it '#add' do
    space = Spaces.add(name: 'test',
                      price: 250.00,
                      description: 'elite housing',
                      availability_start: '10/08/2020',
                      availability_end: '17/08/2020', host_id: 1)
    expect(space.name).to eq('test')
    expect(space.availability_start).to eq('10/08/2020')
  end

  it '#all' do
    generate_example_space

    spaces = Spaces.all

    expect(spaces.size).to eq(3)
    expect(spaces[0].name).to eq('test1')
    expect(spaces[1].price).to eq('350.00')
  end
end
