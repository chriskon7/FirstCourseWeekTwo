#OBJECT ORIENTED PROGRAMMING BLACKJACK GAME

# 1. Abstraction- think about it from object standpoint and the interaction
     # of objects
  # 2. Encapsulation- allows us to think of program in a way that is much
  #    more flexible

# 1. Have detailed requirements or specifications in written form
  # -First a player will give his/her name to use throughout the program.  
  # -Dealer welcomes the player and deals two cards to player and then two cards to him/herself.
  # -Cards are added up and a total is given based on value of cards each player is holding
  # -Player now has the option to hit or stay
  # -If the player hits, they are dealt another card and a new total is given and then option to hit or stay unless they bust
  # -Player goes until they decide to stay or they bust
  # -The dealer now goes and follows the same steps as above, but stays if at 17 or higher
  # -Once both players decide to stay, totals are compared and someone is the winner based on who has higher score or who didn't bust
  # -Player gets the option to play again or not
# 2. Extract major nouns --> classes
  # -Card
  #   -has a value and suit
  #   -cards added together give you a total

  # -Deck
  #   -made up of all of the cards
  #   -must shuffle deck to give it a random order
  #   -cards are dealt from deck which means values are removed when dealt

  # -Player
  #   -Decides if they want to hit or stay
  #   -Decides if they want to play again
  # -Dealer
  #   -Figure out if dealer wants to hit or stay

    # -Hand

# 3. Extract major verbs --> instance methods
# 4. Group instance methods into classes




class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def output
    "#{value} of #{find_suit}"
  end

  def find_suit
    ret_val = case suit
      when "H" then "Hearts"
      when "D" then "Diamonds"
      when "C" then "Clubs"
      when "S" then "Spades"
    end
    ret_val
  end

  def to_s
    output
  end

end




class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ["H", "D", "S", "C"].each do |suit|
      ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    shuffle!
  end

  def shuffle!
    cards.shuffle!
  end

  def deal_one
    cards.pop 
  end

end


module Hand

  def show_hand
    puts "--- #{name}'s Hand ---"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    value = cards.map { |x| x.value}

    total = 0

    value.each do |value|
      if value == "Ace"
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end
  

    #Figure out if Ace is worth 11 or 1
    value.select { |x| x == "Ace"}.count.times do
      total -= 10 if total > Blackjack::BLACKJACK_AMOUNT
    end
  
    total
  end
  
  def add_card(new_card)
      cards << new_card
  end

  def is_busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end
end


class Player
  attr_accessor :name, :cards
  include Hand

  def initialize(name)
    @name = name
    @cards = []
  end
end




class Dealer
  attr_accessor :name, :cards
  include Hand

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_hand
    puts "--- Dealer's Hand ---"
    puts "=> First card is hidden"
    puts "=> Second card is: #{@cards[1]}"
  end
end

class Blackjack

  attr_accessor :deck, :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new
    @player = Player.new("Player1")
    @dealer = Dealer.new
  end

  def set_player_name
    puts "Hello and welcome to Chris Koning's Tealeaf OOP Blackjack Game!"
    puts ""
    puts "What is your name?"
    player.name = gets.chomp
    puts ""
    puts "Welcome to the game, #{player.name}!"
    puts "If you are ready to play some Blackjack, please hit ENTER"
    enter = gets.chomp
    puts ""
  end

  def deal_cards
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end

  def show_flop
    player.show_hand
    dealer.show_hand
  end

  def blackjack_or_bust?(either)
    if either.total == BLACKJACK_AMOUNT
      if either.is_a?(Dealer)
        puts "Sorry, the dealer has hit blackjack.  Better luck next time, #{player.name}"
      else
        puts "Congratulations #{player.name}, you hit BLACKJACK!!!!"
      end
      play_again?
    elsif either.is_busted?
      if either.is_a?(Dealer)
        puts "Congratulations #{player.name}! The dealer busted and you win!"
      else 
        puts "Sorry #{player.name}, you busted."
      end
      play_again?
    end
  end


  def players_turn
    puts "#{player.name}, it is your turn!"
    puts ""
    blackjack_or_bust?(player)

    while !player.is_busted?
      puts "If you would like to hit type in 'Hit' and if you would like to stay type in 'Stay': "
      response = gets.chomp.capitalize
      puts ""

      if response == "Stay"
        break
      elsif response == "Hit"
        new_card = deck.deal_one
        puts "#{player.name} chose to hit and got a #{new_card}"
        player.add_card(new_card)
        puts "#{player.name}, your new total is: #{player.total}"
        blackjack_or_bust?(player)
      else
        "You must type in Hit or Stay!"
      end
    end
  end

  def dealers_turn
    puts ""
    puts "It is now the dealers turn: "
    puts ""
    blackjack_or_bust?(dealer)

    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal_one
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      puts "Dealer total is now: #{dealer.total}"

      blackjack_or_bust?(dealer)
    end
    puts "Dealer stays with a total of #{dealer.total}"
  end

  def who_won?
    if player.total > dealer.total
      puts "Congratulations #{player.name}!  You win!!!"
      puts "Final score: #{player.name}: #{player.total}         Dealer: #{dealer.total}"
    elsif player.total < dealer.total
      puts "Sorry #{player.name}, you lost this game."
      puts "Final score: Dealer: #{dealer.total}        #{player.name}: #{player.total}"
    else
      puts "It's a tie!"
    end
  end

  def play_again?

    puts "Would you like to play again?  Yes or No"
    answer = gets.chomp.capitalize

    if answer == "Yes"
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start
    elsif answer == "No"
      "Thanks for playing!"
      exit
    else
      puts "Please type in Yes or No"
      play_again?
    end
  end
  

  def start
    set_player_name
    deal_cards
    show_flop
    players_turn
    dealers_turn
    who_won? 
    play_again?
  end
end

new_game = Blackjack.new
new_game.start



=begin
  
Path of the code:  I did this to help myself to better understand.  Typing it out really helped me-

1.  A new object of the Blackjack class is created called new_game
2.  The method "start" from the Blackjack class is used on new_game
3.  The "start" method now has a list of methods that begin from top down 
4.  The first is "set_player_name" from the Blackjack class.  It creates a new object of the player class with in the Blackjack class and uses the name
    setter to store the players name.  The name setter method is created by using attr_accessor :name in the Player class.
5.  Next method from the start method is- "deal_cards" from the Blackjack class.  This has methods on the player and dealer objects from the player
    and dealer classes.  These classes both mix in the Hand module.  The method is "add_card" from the Hand module.  Since both Player and Dealer
    classes include the Hand module, they can call this method.  The "add_card" method has one parameter to pass in.  The parameter that is passed in
    "add_card" is going to be pushed into the cards array for the player and the dealer.  An explanation of the parameter that is passed in-
    When the Blackjack class is initialized it sets the instance variable @deck equal to a new object of the Deck class.  The Deck class upon 
    initializing builds the deck of cards and puts them into an array called cards and shuffles them with the help of a method called "shuffle!". The
    Deck class has a method called "deal_one" that is called on deck.  The method "deal_one" removes one card value from cards with the "pop" mehtod
    and that value is returned.  This value is then inserted as the parameter for "add_card".  Two cards are added to the player and two to the dealer
    with the "deal_cards" method.
6.  The next method called from the "start" method is the "show_flop" method.  The "show_flop" method is going to call the "show_hand" method on 
    both the dealer and the player.  The Hand module has a "show_hand" method that will be called for the player.  The "show_hand" method is a little 
    different between player and dealer so we override the Hand module method by creating a method with the same name "show_hand" in the Dealer
    class.  For the player we iterate through the array cards which has two index values now and we display each indexed value seperately.  We then
    calculate and show the total by calling the "total" method which is also created in the Hand module.  The "total" method iterates through the cards
    array and adds the values together.  It also determines if there are any Aces and if so determines if the value is over 21 to subtract 10.  With
    this method we not display the players hand and total.  The "show_hand" hand method for the dealer is pretty much the same, only we don't show
    the value of cards in the index position 0 for the dealers cards.
7.  The next method in the "start" method is the "players_turn" method of the Blackjack class.  We start by letting the player know it is his or her
    turn by using the name getter method on the player object which was set earlier.  Next we call the "blackjack_or_bust?(either)" method which
    has one parameter.  Since this is the players turn, we use player as the parameter.  "blackjack_or_bust?(player)" is going to check and see if
    the players total is equal to 21.  If it is at this point the player will be congratulated and asked to play again with the "play_again?" method,
    which will be explained more below.  The "blackjack_or_bust?(player)" method will also check if the player is busted(over 21) and if so let the
    player know they lost and ask if they want to play again.  Next in the "players_turn" method we have a while loop that will continue to loop while
    the players total is not greater than 21.  This is done with an "is_busted" method created in the Hand module.  As long as the player is not
    above 21, the loop will continue to loop initially.  The player has the option to Hit or Stay.  If the response is Stay, the loop will break and
    it will be the dealers turn.  If the response is Hit, we will use the "deal_one" method again and store that popped array value into a variable
    we created called new_card.  We can now display the value of new_card and also use this new_card value to push it into player with the
    "add_card" method.  Again we will call "blackjack_or_bust?(player)" to find if the player hit 21 or went over.  We will continue to let this
    loop run until either the player chooses to stay, hits 21 or busts.  I also added an option to let the user know that they must enter Hit or Stay
    as options. 
8.  The next method in the "start" method is the "dealers_turn" method.  This method is a lot like the "players_turn" method.  The dealer doesn't
    need any outside input to run though.  The dealer will hit as long as it is under 17.  This is accomplished with a while loop.  We use the 
    "blackjack_or_bust?(dealer)" to find out if the dealer hit 21 or went over 21.  The other option is that the dealer is between 17 and 20 and if
    this is the case the dealer will stay.
9.  We now want to show how won.  The next method from the "start" method list will do this and is called "who_won?", which is from the Blackjack
    class.  As long as neither player nor dealer has busted or hit blackjack we will get to this method.  The "who_won?" method is going to compare
    the totals for player and dealer.  It will display the appropriate message depending on who's score is higher.  It will also display the 
    appropriate message if we have a tie.  
10. The last method we have called from the "start" method is the "play_again?" method.  This method from the Blackjack class asks the player if 
    they would like to play again.  If they type in Yes the program sets a new deck so that we have all the cards in the array again since using
    pop actually returns and deletes the cards from the array.  We also set the cards array for both player and dealer to an empty array since
    it is still holding cards in the array from the previous game.  Last, we call the start method and start all over again!  if the player
    types in No, we thank them for playing and exit the program.  If the player does not type in yes or no, we call the "play_again?" method and give
    them another chance to answer yes or no.    
  
=end



