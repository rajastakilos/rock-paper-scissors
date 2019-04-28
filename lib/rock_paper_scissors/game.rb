module RockPaperScissors
  class Game
    attr_reader :winner
    include Comparable 
    #include Utilities #for custom titleize

    RPS = [ 'rock', 'paper', 'scissors' ]

    def initialize(session, name)
      @session = session
      #@name = session.player.name # Design question: Should this class know that session has player and name on it?
      @name = name
      @record = { @name => 0, 'Computer' => 0 }
      @winner = nil
      @rounds = 0
      @computer_choice = nil
      @player_choice = nil
    end

    def play
      display_countdown 
      
      @player_choice, @computer_choice = gets.chomp.downcase, computer_roll.downcase
      puts

      if RPS.include?(@player_choice)
        judge_round

        @winner ? show_ending : play
      else
       @winner = 'Computer' 
       puts "#{@player_choice}????"
       puts
       puts 'That makes no sense. Congratulations on losing Rock Paper Scissors on a technicality.'
       puts

       show_ending
      end
    end

    private

    def display_countdown
      sleep(0.5)
      puts '1'
      puts
      sleep(0.5)
      puts '2' 
      puts
      sleep(0.5)
      puts '3' 
      puts
      puts 'SHOOT!'
      puts
    end

    def computer_roll
      RPS.sample
    end

    def judge_round
      if self > @player_choice
        puts "Computer wins!"
        puts "#{@computer_choice} beats #{@player_choice}"
        puts 
        tally_score('Computer')
      elsif self < @player_choice
        puts "#{@name} wins!"
        puts "#{@player_choice} beats #{@computer_choice}" 
        puts    
        tally_score(@name)
      else
        puts "#{@computer_choice} equals #{@player_choice}"
        puts "The round is a tie"
        puts
        tally_score('Nobody')
      end
    end

    def <=>(player_choice)
      compare_choices(@player_choice)
    end

    def compare_choices(player_choice)
      a, b = @computer_choice, @player_choice

      case
      when a == 'rock'      && b == 'scissors' then  1
      when a == 'paper'     && b == 'rock'     then  1
      when a == 'scissors'  && b == 'paper'    then  1
      when a == 'rock'      && b == 'paper'    then -1
      when a == 'paper'     && b == 'scissors' then -1
      when a == 'scissors'  && b == 'rock'     then -1
      when a == 'rock'      && b == 'rock'     then  0
      when a == 'paper'     && b == 'paper'    then  0
      when a == 'scissors'  && b == 'scissors' then  0
      end
    end

    def tally_score(winner)
      @record[winner] += 1 unless winner == 'Nobody'
      @rounds += 1

      check_for_winner
    end

    def check_for_winner
      neither_player_has_any_wins = (@record[@name] == 0 && @record['Computer'] == 0)

      @winner = 'Computer' if @record['Computer'] == 3  
      @winner = @name      if @record[@name] == 3  
      @winner = 'Nobody'   if (@rounds == 5 && neither_player_has_any_wins)    
    end

    def show_ending
      puts "OMG! #{@winner} WINS!"
      puts
      exit_game
    end

    def exit_game
      @session.end_player_session
    end
  end
end
