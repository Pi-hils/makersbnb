require_relative './database_start_script'

# Space controls the spaces elements of the application
class Space

  attr_reader :name, :price, :description, :availability_start, :availability_end, :bookable, :host_id
  
  def initialize(id:,name:, price:, description:, availability_start:,
                 availability_end:, bookable:, host_id:, published:)
    @id = id; @name = name; @price = price; @description = description; @availability_start = availability_start
    @availability_end = availability_end, @bookable = bookable, @host_id = host_id, @published = published
  end

  def self.add(name:, price:, description:, availability_start:, availability_end:, host_id:)
    result = database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('#{name}','#{price}','#{description}','#{availability_start}','#{availability_end}', '#{host_id}') RETURNING * ;")
    result.map do |record|
      return Space.new(id: record['id'],
                       name: record['name'],
                       price: record['price'],
                       description: record['description'],
                       availability_start: record['availability_start'],
                       availability_end: record['availability_end'],
                       bookable: record['bookable'],
                       host_id: record['host_id'],
                       published: record['published'])
    end
  end


end
