
# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def speak
#     "#{name} says Arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{name} weighs #{weight} and is #{height} tall"
#   end

# end

# sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
# puts sparky.info
# sparky.change_info("Spartacus", "24 inches", "45 lbs")
# puts sparky.info
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    #increase the car in MPH
    @current_speed += number
    puts "You push down on gas pedal and increase by #{number} MPH"
  end

  def brake(number)
    #decrease the car in MPH
    @current_speed -= number
    puts "You push the brake and decelerate #{number} MPH"
  end

  def current_speed
    puts "You are now going #{@current_speed} MPH"
  end

  def shut_off
    @current_speed = 0
    puts "Your car has been shut down"
  end

  def get_info
    puts "This is a #{color} #{@model} built in the year #{year} "
  end

  def spray_paint(color)
    self.color = color
    puts "The new color of your car is #{color}!"
  end

  def to_s
    "This is a #{color} #{@model} built in the year #{year} "
  end

  def self.car_count
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end


  def self.gas_mileage(gallons, miles)
    puts "#{miles/gallons} miles per gallon"
  end

  def age
    "Your car is #{years_old} years old!"
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end

end

class MyCar < Vehicle
  
  NUMBER_OF_DOORS = 4

end

class MyTruck < Vehicle

  NUMBER_OF_DOORS = 2

  include Towable

end

breeze = MyCar.new("1997", "red", "Breeze")
breeze.speed_up(45)
breeze.current_speed
breeze.speed_up(15)
breeze.current_speed
breeze.brake(10)
breeze.current_speed
breeze.brake(15)
breeze.current_speed
breeze.shut_off
breeze.current_speed
breeze.get_info
breeze.spray_paint("black")
breeze.get_info
puts ""
MyCar.gas_mileage(17, 500)
puts breeze
bronco = MyTruck.new("1980", "green", "Bronco")
sneeze = MyCar.new("1998", "blue", "Sneeze")
F150 = MyTruck.new("2014", "silver", "F150")

Vehicle.car_count

puts bronco.can_tow?(2001)

puts "---Vehicle Method Lookup---"
puts Vehicle.ancestors
puts "---MyCar---"
puts MyCar.ancestors
puts "---MyTruck---"
puts MyTruck.ancestors

puts ""
bronco.speed_up(45)
bronco.current_speed
bronco.speed_up(15)
bronco.current_speed
bronco.brake(10)
bronco.current_speed
bronco.brake(15)
bronco.current_speed
bronco.shut_off
bronco.current_speed
bronco.get_info
bronco.spray_paint("black")
bronco.get_info
puts ""


puts bronco.age




