%w{rubygems sinatra json yaml logger}.each{|x| require x}

log = Logger.new('/home/node/git-pull-hook.log')
log.level = Logger::DEBUG

def pull(repo)
  name = repo['repository']['name']
  `cd ${name} && git pull origin master`
end

post '/pull' do
  begin
    pull(JSON.parse(params[:payload]))
    "ok"
  rescue Exception => e
    log.error e
  end
end

get '/:remote' do
  "running"
end
