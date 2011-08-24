%w{rubygems sinatra json yaml logger}.each{|x| require x}

log = Logger.new('/var/log/git-pull-hook.log')
log.level = Logger::DEBUG

def get_local_path(remote)
  config =  YAML::load_file("/etc/git-pull-hook/repos.yml")
  config['repo_home'] + config['repos'][remote]
end

post '/' do
  push = JSON.parse(params[:payload])
  begin
    log.debug "Recieved payload: #{params[:payload]}"
    remote_repo = push['repository']['name']
    local_repo = get_local_path(remote_repo)
    `cd #{local_repo} && git pull origin master`
    "ok"
  rescue Exception => e
    log.error e
  end
end

# GET /remote-repo used for debugging
get '/:remote' do
  remote_repo = params[:remote]
  local_repo = get_local_path(remote_repo)
  `cd #{local_repo} && git pull origin master`
end
