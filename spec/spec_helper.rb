require "bundler/setup"
require "rock_paper_scissors"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

 # PURPOSE: Added to suppress logging from stdout.  
 # WARNING: This will prevent you from using binding.pry

  original_stderr = $stderr
  original_stdout = $stdout

  config.before(:all) do 
    $stderr = File.new(File.join(File.dirname(__FILE__), 'dev', 'null.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'dev', 'null.txt'), 'w')
  end

  config.after(:all) do 
    $stderr = original_stderr
    $stdout = original_stdout
  end
end

