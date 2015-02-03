class Hangman
	def initialize(word)
		@word = word.downcase
		# puts @word
		@split_word = @word.split("")
		
		@lives = 9

		@guessesdots = word.gsub(/./, '.')
		puts @guessesdots

		@all_attempts = Array.new

		while(@lives > 0)
			guess
		end
	end

	def letter?(attempt)
  		return attempt =~ /[[:alpha:]]/
	end

	def validation?(attempt)
		if(attempt.length != 1)
			puts "Attempt must be a single character. Guess again."
			return false
		end
		if( @all_attempts.include? attempt)
			puts "Already guessed that. Guess again."
			return false
		end
		if( not letter?(attempt) )
			puts "Must be a character. Guess again."
			return false
		end
		return true
	end	

	def guess
		puts "Enter your guess..."
		attempt = gets.chomp.downcase
		# puts attempt.length
		if( validation?(attempt) )
			@all_attempts << attempt
			if( @word.include? attempt)
				correct(attempt)
			else
				wrong(attempt)
			end
		end
	end

	def correct(attempt)
		puts "Correct!"
		@split_word.each_with_index{|item, index|
			if(attempt == item)
				@guessesdots[index] = item
			end
		}
		puts @guessesdots
		if(@guessesdots == @word)
			puts "You've won!"
			exit
		end



	end

	def wrong(attempt)
			@lives = @lives - 1
			puts "Try again - #{@lives} lives left"
			if(@lives <= 0)
				puts "Games Over! It was '#{@word}'!"
				exit
			end
	end

	

end

word_list = Array.new

File.open('words.txt').each do |line|
	word_list << line.chomp
end

rd = rand(word_list.length)
Hangman.new(word_list[rd])