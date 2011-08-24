require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('git-pull-hook.rb') do
    exec "ruby #{pwd}/git-pull-hook.rb"
end
