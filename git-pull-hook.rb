%w{rubygems sinatra json yaml logger}.each{|x| require x}

log = Logger.new('/home/node/git-pull-hook.log')
log.level = Logger::DEBUG

home = '/home/node'
post '/pull' do
  begin
    repo = JSON.parse(params[:payload])
    name = repo['repository']['name']
    log.warn "updating repo #{home}/#{name}"
    `cd #{home}/#{name} && git pull origin master`
    "ok"
  rescue Exception => e
    log.error e
  end
end

get '/:remote' do
  "running"
end
