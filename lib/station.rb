class Station
  attr_reader :name, :zone

  def initialize(name: , zone: )
    @name = name.downcase.capitalize
    @zone = zone
  end
end
