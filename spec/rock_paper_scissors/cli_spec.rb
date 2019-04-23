RSpec.describe RockPaperScissors::CLI do
  describe 'Game' do
    let(:yes_response) { 'Yes' }    
    let(:no_response) { 'No' }
    let(:player_name) { 'Rajas' }

    describe '#welcome_player' do
      let(:welcome_message) { 'WELCOME to rOcK pApEr sCiSsOrS' }

      it 'greets a new player when the game loads' do
        expect { 
          RockPaperScissors::CLI.new.welcome_player
        }.to output(a_string_including(welcome_message)).to_stdout
      end
    end

    describe '#get_player_name' do
      let(:request_for_player_name) { 'Please enter your name' }
      let(:greeting_with_name) { "Welcome #{player_name}" }

      it 'asks the player to enter their name' do
        expect do
          RockPaperScissors::CLI.new.get_player_name
        end.to output(a_string_including(request_for_player_name)).to_stdout end

      it 'greets the player by their name' do
        allow_any_instance_of(RockPaperScissors::CLI).to receive(:gets).and_return(player_name)

        expect do
          RockPaperScissors::CLI.new.get_player_name
        end.to output(a_string_including(greeting_with_name)).to_stdout
      end
    end

    describe '#explain_rules' do 
      it 'displays the rules of the game' do
         expect {  RockPaperScissors::CLI.new.explain_rules }.to output(a_string_including(<<~RULES.gsub('. ', '.'))).to_stdout
           We will play the best of 5 rounds of rock paper scissors. 
           The game can end sooner if someone gets 3 wins before 5 rounds. 
           Rock beats Scissors. 
           Scissors beats Paper. 
           Paper beats Rock.
           I'll count to three, and then say 'Shoot'.
           You have two seconds to respond.
           If you don't respond, then I win the whole game.
           RULES
      end
    end

    describe '#check_player_readiness' do
      let(:lets_start_statement) { 'Let\'s Start!' }

      describe 'general' do
        let(:readiness_statement) { 'Are you ready?' }

        it 'asks for readiness' do
          expect do 
            RockPaperScissors::CLI.new.check_player_readiness
          end.to output(a_string_including(readiness_statement)).to_stdout
        end   
      end

      describe 'yes' do
        before do
          allow_any_instance_of(RockPaperScissors::CLI).to receive(:gets).and_return(yes_response)
          allow_any_instance_of(RockPaperScissors::CLI).to receive(:launch_game)
        end
 
        it 'asks for readiness and calls play' do #TODO: Separate?
          expect_any_instance_of(RockPaperScissors::CLI).to receive(:launch_game)
          expect do 
            RockPaperScissors::CLI.new.check_player_readiness
          end.to output(a_string_including(lets_start_statement)).to_stdout
        end   
      end

      describe 'no' do
        describe 'general' do
          let(:lets_wait_response) { 'Okay. I\'ll wait. You have five seconds.' }
          let(:five) { '5' }
          let(:four) { '4' }
          let(:three) { '3' }
          let(:two) { '2' }
          let(:one) { '1' }
          let(:zero) { '0' }
          let(:meow_response) { 'How about meow?' }

          before do
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:sleep) #TODO: Best way? Or use time?
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:gets).and_return(no_response)
          end

          it 'asks for readiness' do
            expect do 
              RockPaperScissors::CLI.new.check_player_readiness
            end.to output(a_string_including(lets_wait_response)).to_stdout
          end

          it 'counts down from 5 to 0' do
            expect_any_instance_of(RockPaperScissors::CLI).to receive(:sleep).exactly(6).times
            expect do 
              RockPaperScissors::CLI.new.check_player_readiness
            end.to output(a_string_including(five, four, three, two, one, zero)).to_stdout
          end

          it 'asks again after 5 seconds' do
            expect do 
              RockPaperScissors::CLI.new.check_player_readiness
            end.to output(a_string_including(meow_response)).to_stdout
          end
        end

        describe 'player says no the second time' do
          let(:still_no_message) { 'Fine. Don\'t play' }

          before do
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:sleep)
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:gets).and_return(no_response, no_response)
          end

          it 'displays still no message' do
            expect do 
              RockPaperScissors::CLI.new.check_player_readiness
            end.to output(a_string_including(still_no_message)).to_stdout
          end
        end

        describe 'player says yes the second time' do
          let(:finally_message) { 'Finally.' }

          before do
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:sleep)
            allow_any_instance_of(RockPaperScissors::CLI).to receive(:gets).and_return(no_response, yes_response)
          end

          it 'displays lets start message' do
            expect_any_instance_of(RockPaperScissors::CLI).to receive(:launch_game)
            expect do 
              RockPaperScissors::CLI.new.check_player_readiness
            end.to output(a_string_including(finally_message)).to_stdout
          end
        end
      end
    end

    describe '#launch_game' do
      it 'starts a game' do
        expect_any_instance_of(RockPaperScissors::Game).to receive(:play)
        RockPaperScissors::CLI.new.launch_game
      end 
    end
  end
end
