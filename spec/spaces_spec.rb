require_relative 'spec_helper'

describe Space do

  before 'generate master user' do
    generate_example_master
  end

  it '#add' do
    space = Space.add(name:)
    expect(space.name)
  end

end
