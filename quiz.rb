Some exercises from lesson 2 materials:

# 1. Name what each of the below is:


#   a = 1 
#   # => ex. a is a local variable, and is a Fixnum object with
#   value 1 
#   @a = 2
    @a is an instance variable with the value 2
#   user = User.new
    user is a new object created from the User class
#   user.name
    user is an object and name is the method being called on it
#   user.name = "Joe"
    user is an object and the name setter method is being called on it and set to "Joe"
# 2. How does a class mixin a module?

    A class mixes in a module by using include

# 3. What's the difference between class variables and instance variables?

    Instance variables are an instance of the object and begin with @. Class variables are shared among the class and begin with @@.

# 4. What does attr_accessor do?

    You can use instance variables to create setter and getter methods.  Most of the time you will want to create these methods.  attr_accessor makes
    it easier by automatically creating these methods for whichever variable you add to attr_accessor.   Ex. attr_accessor :name

# 5. How would you describe this expression: Dog.some_method
    
      Dog would be a class in this example and some_method is a class method.

# 6. In Ruby, what's the difference between subclassing and mixing in modules?
  
      Subclassing uses the is-a relationship.  A Dog is an Animal and so is a Cat.  So you could subclass Dog and Cat and have them inherit from 
      the Class Animal.  Classes can only inherit directly from one Class.  
      Mixing in modules is a has-a relationship.  You can reuse this module on multiple classes and the classes will inherit the characteristics of
      that module.  You can also inherit from multiple modules in one class.  One big difference though is that you can not create objects from modules.

# 7. Given that I can instantiate a user like this: User.new('Bob'), what would the initialize method look like for the User class?

      def initialize(name)
        @name = name
      end


# 8. Can you call instance methods of the same class from other instance methods in that class?

      yes

# 9. When you get stuck, what's the process you use to try to trap the error?

      at the top of your program call-  require 'pry'

      and at the point where you want the program to stop you add in- binding.pry


