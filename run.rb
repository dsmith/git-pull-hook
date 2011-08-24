require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('git-pull-hook.rb') do
    exec "ruby /usr/lib/ruby/1.8/git-pull-hook.rb"
end
