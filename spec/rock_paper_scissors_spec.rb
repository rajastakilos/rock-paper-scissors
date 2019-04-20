RSpec.describe RockPaperScissors do
  it "has a version number" do
    expect(RockPaperScissors::VERSION).not_to be nil
  end

  describe 'Game' do
    it 'greets a new user when the gem loads' do
      expect { system %(ruby -Ilib ./bin/game_start) }
	.to output(a_string_including('Welcome to Rock Paper Scissors'))
	.to_stdout_from_any_process
    end
  end

end
