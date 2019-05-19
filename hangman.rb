class Hangman
    def initialize()
        start_game()
    end

    def start_game()
        @secret_word = select_secret_word()
        @wrong_guesses = 0
        @total_lives = 6
        while @wrong_guesses < @total_lives do
            letter_guess = prompt_player_guess()
            check_letter(letter_guess)
            check_if_won()
        end
        puts "Ending game"
    end

    def check_if_won()
        if @wrong_guesses == @total_lives
            puts "Sorry, you lost :/ "
            return false
        end
        @revealed_letters.each.with_index do |status, i|
            # if any letter is not revealed, have not yet won the game
            if !status
                return false 
            end
        end
        puts "Nice job, you won!"
        @wrong_guesses = @total_lives # to end game loop
    end

    def check_letter(letter)
        letter = letter.downcase # convert to lowercase for consistency
        # checks for all occurences of the letter in the secret word, stores as an array
        results = (0 ... @secret_word.length).find_all { |i| @secret_word[i, 1] == letter }
        if results.length == 0
            puts "Sorry, that word isn't in the secret word"
            add_one_penalty()
        else
            results.each do |index_of_letter|
                puts "Nice job!"
                # set the index of that letter to be true in the revealed_letters array
                @revealed_letters[index_of_letter] = true
                print_secret_word()
            end  
        end
    end

    def print_secret_word()
        # prints the word in "secret fashion"
        # examples:
            # if the word is "doggos" and no letters have been revealed, would print:
            # _ _ _ _ _ _
            # if the word is "doggos" and the 'o' has been revealed, would print:
            # _ o _ _ o _
        puts "Here is your secret word:"
        letters =  @secret_word.split('')
        letters.each.with_index do |letter, i|
            if letter_revealed(i)
                print letters[i]
            else    
                print " _ "
            end
        end
        puts ""
    end

    def letter_revealed(i)
        return @revealed_letters[i]
    end

    def add_one_penalty()
        # called when player guessed wrong
        # deducts one 'life', so to speak
        # extra credit: draw the hangman!
        @wrong_guesses = @wrong_guesses + 1
        puts "You have #{@total_lives-@wrong_guesses} wrong guesses left"
    end

    def prompt_player_guess()
        print_secret_word()
        guess = nil
        while !is_valid(guess)
            puts "What letter would you like to guess?"
            # get user input. Use `chomp` to get rid of newline character that is added
            guess = gets.chomp  
        end
        return guess
    end 

    def is_valid(letter_guess)
        if (letter_guess && letter_guess.length == 1)
            return true
        end
        return false
    end

    def select_secret_word()
        # Selects the word the player will have to guess, by using a random number
        # TODO: add more words to the list!
        word_list = ["bagpipes", "awkward", "haiku", "pink", "today", "zombie"]

        random_index = rand(word_list.length)
        secret_word = word_list[random_index]
        # this revealed_letters array will hold the status of each letter
        # when the letter has been revealed, it will be true
        @revealed_letters = [false]*secret_word.length
        print @revealed_letters
        return secret_word
    end

end

 game= Hangman.new()