$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


module YogoLauncher
  YOGO_LAUNCHER_HOME = File.expand_path(File.join(File.dirname(__FILE__),'..')) unless defined? YOGO_LAUNCHER_HOME
end

begin
  require File.join(YogoLauncher::YOGO_LAUNCHER_HOME,'vendor','gems','environment')
rescue LoadError
  puts "Please run 'gem bundle' to install the required gem libraries."
end