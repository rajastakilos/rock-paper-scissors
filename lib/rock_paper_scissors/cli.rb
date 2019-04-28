require 'rock_paper_scissors/version'

module RockPaperScissors
  class CLI
    attr_reader :player

    YES_RESPONSES = ['Y', 'yes', 'Yes', 'yeah', 'Yeah', 'Sure']
    NO_RESPONSES  = ['N', 'No', 'no', 'nein', 'naw', 'nyet', 'NO']

    def start
      welcome_player
      get_player_name
      explain_rules
      check_player_readiness
    end

    def welcome_player
      puts 'WELCOME to rOcK pApEr sCiSsOrS'
      puts
    end 

    def get_player_name
      puts "Please enter your name."
      puts
      name = gets.chomp 
      @player = Player.new(name) 
      puts
      puts "Welcome #{name}."
      puts
    end

    def explain_rules
      puts 'We will play the best of 5 rounds of rock paper scissors.'
      puts 'The game can end sooner if someone gets 3 wins before 5 rounds.'
      puts 'Rock beats Scissors.' 
      puts 'Scissors beats Paper.' 
      puts 'Paper beats Rock.'
      puts 'I\'ll count to three, and then say \'Shoot\'.'
      puts 'You have two seconds to respond.'
      puts 'If you don\'t respond, then I win the whole game.' 
      puts
    end

    def check_player_readiness
      puts 'Are you ready?'
      puts
      response = gets.chomp
      puts

      if YES_RESPONSES.include?(response)
        puts 'Let\'s Start!'
        puts
        launch_game
      elsif NO_RESPONSES.include?(response)
        puts 'Okay. I\'ll wait. You have five seconds.'
        puts
       
        5.downto(0) { |seconds| puts "#{seconds}"; sleep 1 }

        puts
        puts 'How about meow?'
        puts

        second_response = gets.chomp
        puts 
        
        if NO_RESPONSES.include?(second_response)
          puts 'Fine. Don\'t play' 
          puts
        elsif YES_RESPONSES.include?(second_response)
          puts 'Finally.'
          launch_game
        else
          puts 'You lose.'
        end
      end
    end

    def launch_game
      Game.new(self, player.name).play
    end

    def end_player_session
      puts "Thanks for playing Rock, Paper, Scissors, #{player.name}!"
      puts
    end    
  end
end
