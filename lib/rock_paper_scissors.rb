require "rock_paper_scissors/version"

module RockPaperScissors
  class CLI
    def initialize
    end

    def start
      welcome_user
    end

    def welcome_user
      puts 'Welcome to Rock Paper Scissors'
    end 
  end
end
