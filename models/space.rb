require_relative './database_start_script'
#TODO: Add a @host_name = host_name where the method 'host_name' attributes @host_name with the result of a query
# that uses the @host_id to find the name of the host.

# Space controls the spaces elements of the application
class Spaces

  attr_reader :name, :price, :description, :availability_start, :availability_end, :bookable, :host_id

  def initialize(id:,name:, price:, description:, availability_start:,
                 availability_end:, bookable:, host_id:, published:)
    @id = id; @name = name; @price = price; @description = description
    @availability_start = Date.parse(availability_start).strftime('%d/%m/%Y'); @availability_end = Date.parse(availability_end).strftime('%d/%m/%Y')
    @host_id = host_id; @published = published
    @bookable = bookable == 't'; # If database ever provides a truth value of anything other than "t", will return false
  end

  def self.add(name:, price:, description:, availability_start:, availability_end:, host_id:)
    space = DatabaseConnection.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('#{name}','#{price}','#{description}','#{Date.parse(availability_start)}','#{Date.parse(availability_end)}', '#{host_id}') RETURNING * ;")
    space_wrapper(space).first
  end

  def self.all
    spaces = database.query("SELECT * FROM spaces")
    space_wrapper(spaces)
  end

  private

  def self.space_wrapper(query_result)
    query_result.map { |record|
      Spaces.new(id: record['id'],
               name: record['name'],
               price: record['price'],
               description: record['description'],
               availability_start: record['availability_start'],
               availability_end: record['availability_end'],
               bookable: record['bookable'],
               host_id: record['host_id'],
               published: record['published'])
     }
  end

end
