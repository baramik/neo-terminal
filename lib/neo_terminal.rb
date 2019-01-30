require_relative 'terminal/hacking_module'

class NeoTerminal
  include Terminal::HackingModule

  def clear_terminal_data
    FileUtils.rm_rf(Dir['tmp/*'])
    puts 'terminal data cleared'
  end 
end