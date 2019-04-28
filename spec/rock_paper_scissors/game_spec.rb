RSpec.describe RockPaperScissors::Game do
  describe '#play' do
    let(:name) { 'Rajas' }
    let(:player) { RockPaperScissors::Player.new(name) }
    let(:cli) { RockPaperScissors::CLI.new }
    let(:game) { RockPaperScissors::Game.new(cli, name) }
    let(:computer) { 'Computer' }
    let(:draw) { 'Nobody' }
    let(:player_wins_script) { File.read('spec/fixtures/player_wins_3_straight.txt') }
    let(:computer_wins_script) { File.read('spec/fixtures/computer_wins_3_straight.txt') }
    let(:draw_script) { File.read('spec/fixtures/draw.txt') }
    let(:invalid_input_script) { File.read('spec/fixtures/invalid_input.txt') }

    describe 'player wins 3 straight' do
      before do
        allow(RockPaperScissors::CLI).to receive(:new).and_return(cli)
        cli.instance_variable_set(:@player, player) 
        
        allow_any_instance_of(RockPaperScissors::Game).to receive(:gets).and_return('Rock', 'Paper', 'Scissors')
        allow_any_instance_of(RockPaperScissors::Game).to receive(:computer_roll).and_return('Scissors', 'Rock', 'Paper')
      end

      it 'displays the correct script to the player' do #TODO: This will need to add the show ending text, and titleized values for R, P, S
        expect do        
          game.play
        end.to output(a_string_matching(player_wins_script)).to_stdout
      end

      it 'sets the player as the winner of the game' do
        game.play
        
        expect(game.instance_variable_get('@winner')).to eq(player.name)
      end

      it 'take the player back to the cli' do
        expect(cli).to receive(:end_player_session)

        game.play
      end
    end

    describe 'computer wins 3 straight' do
      before do
        allow(RockPaperScissors::CLI).to receive(:new).and_return(cli)
        cli.instance_variable_set(:@player, player) 

        allow_any_instance_of(RockPaperScissors::Game).to receive(:gets).and_return('Scissors', 'Rock', 'Paper')
        allow_any_instance_of(RockPaperScissors::Game).to receive(:computer_roll).and_return('Rock', 'Paper', 'Scissors')
      end

      it 'displays the correct script to the player' do
        expect do        
          game.play
        end.to output(a_string_including(computer_wins_script)).to_stdout
      end

      it 'sets the computer as the winner of the game' do
        game.play

        expect(game.instance_variable_get('@winner')).to eq(computer)
      end

      it 'takes the player back to the cli' do
        expect(cli).to receive(:end_player_session)

        game.play
      end
    end

    describe 'the game ends in a draw' do
      before do
        allow(RockPaperScissors::CLI).to receive(:new).and_return(cli)
        cli.instance_variable_set(:@player, player) 

        allow_any_instance_of(RockPaperScissors::Game).to receive(:gets).and_return('Rock', 'Rock', 'Rock', 'Rock', 'Rock') 
        allow_any_instance_of(RockPaperScissors::Game).to receive(:computer_roll).and_return('Rock', 'Rock', 'Rock', 'Rock', 'Rock')
      end

      it 'displays the correct script to the player' do
        expect do
          game.play
        end.to output(a_string_including(draw_script)).to_stdout
      end

      it 'sets \'Nobody\' as the winner of the game' do
        game.play

        expect(game.instance_variable_get('@winner')).to eq(draw)
      end

      it 'take the player back to the cli' do
        expect(cli).to receive(:end_player_session)

        game.play
      end
    end

    describe 'the user enters an invalid input at any point' do
      before do
        allow(RockPaperScissors).to receive(:new).and_return(cli)
        cli.instance_variable_set(:@player, player)

        allow_any_instance_of(RockPaperScissors::Game).to receive(:gets).and_return('nonsense') 
        allow_any_instance_of(RockPaperScissors::Game).to receive(:computer_roll).and_return('Paper')
      end

      it 'displays the correct script to the player' do
        expect do
          game.play
        end.to output(a_string_matching(invalid_input_script)).to_stdout
      end

      it 'sets \'Computer\' as the winner of the game' do
        game.play

        expect(game.instance_variable_get('@winner')).to eq(computer)
      end

      it 'take the player back to the cli' do
        expect(cli).to receive(:end_player_session)

        game.play
      end
    end
  end 
end
