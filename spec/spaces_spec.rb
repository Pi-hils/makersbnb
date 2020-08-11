require_relative 'spec_helper'

describe Space do

  before 'generate master user' do
    generate_example_master
  end

  it '#add' do
    space = Space.add(name: 'test',
                      price: 250.00,
                      description: 'elite housing',
                      availability_start: '10/08/2020',
                      availability_end: '17/08/2020', host_id: 1)
    expect(space.name).to eq('test')
    expect(space.availability_start).to eq('10/08/2020')
  end

end
