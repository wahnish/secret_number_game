class Game
	attr_reader :guesses_allowed, :current_guess_count, :secret_number, :player_name
	def initialize(guesses = 3, set_of_numbers = 0..10)
		@guesses_allowed = guesses
		@current_guess_count = 0 
		@player = Player.new(player_name)
		@secret_number = SecretNumber.new(set_of_numbers)
		@set_of_numbers = set_of_numbers
		@current_guess = nil
		@messages = Hash.new 
			@messages[:win] = [ "Congratulations! You have won the game! This should make up for the rest of your failures in life!", 
					"Congratulations! You won! You're like the Bon Jovi of guess-the-number games. Livin' on a prayer baby!", 
					"Woah, you got it! As your prize, feel free to go into any retail outlet and take anything you want for free. It's cool, tell them I said so...", 
					"Great job, you guessed correctly! You get a gold star and a scratch & sniff sticker that smells like pickles.", 
					"You won!  Are you Miss Cleo the psychic?" ]

			@messages[:lose] = [ "You lose. The Secret Number was #{@secret_number.secret_number}. Go home...baby.",
					"Loser. The answer is #{@secret_number.secret_number}.",
					"Soooo close! Too bad you lost. The answer is #{@secret_number.secret_number}.", 
					"You lose. The Secret Number was #{@secret_number.secret_number}." ]
			 
			@messages[:too_high] =  [ "Oh, no way - totally not the number. Guess lower.", 
					"You got it! HAHAHAHA, no...just kidding. Guess lower next time.", 
					"You're not very good at this, are you? Guess a lower number.", 
					"Hamsters and sheep like fuzzy mangos. While you try and figure out what the heck that means, guess a lower number."]

			@messages[:too_low] = [ "Outlook not so good, guess higher next time.", 
					"Nope, guess higher next time.", "Oohhh, you might be close! Try a higher number.", 
					"You're not very good at this...try higher." ]
		#don't use @@ if you don't have to,Matthew says 
	end

	

	def guesses_left(tries)                                         
    	@guesses_allowed - tries
  	end 


	def guess_correct?(guess)                                                                                                                                           
    	if guess == @secret_number.secret_number                                       
      		true                                                                  
    	else 
      		false 
    	end
  	end      

	def show_message(msg)
      puts @messages[msg].sample
    end

  	def show_hint
    	if @current_guess > @secret_number.secret_number 
        	show_message :too_high
        else 
        	show_message :too_low
        end	
    end     
  
	def print_created_by
		puts "The Number Guessing Game"
		puts "Created by Todd Wahnish"
		puts "\nShall We Play a Game?"
	end

	def start_game
		print_created_by
		puts "\nHi there, what's your name?"
		@player = gets.chomp

		begin
			raise Exception if @player.empty?	
			rescue Exception => error
				puts "Oops, no name.  Try program again."
				exit
			end 

		puts "Hi, #{@player}! You have #{@guesses_allowed} guesses to guess the Secret Number between 1 and 10."

		@guesses_allowed.times do |attempts|                                                                                                                 
      		puts "\nYou have #{ guesses_left(attempts) } guesses left!"       
      		print "What is your guess? "                                                 
      		@current_guess = gets.to_i  

      		begin
			raise Exception if @current_guess == 0
			rescue Exception => error
				puts "Silly, put a number."
				puts "\nYou have #{ guesses_left(attempts) } guesses left!"       
      			print "What is your guess? "                                                 
      			@current_guess = gets.to_i
			end                   

      		if guess_correct?(@current_guess)
        		show_message :win
        		puts "You guessed in #{attempts + 1} turns!"
        		exit                                                                    
      		else
        	show_hint unless guesses_left(attempts + 1).zero?
      		end      
      	end

    	puts @messages[:lose].sample
	end
end	
	
	