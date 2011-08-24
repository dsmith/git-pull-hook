%w{rubygems sinatra json yaml}.each{|x| require x}


def get_local_path(remote)
  config =  YAML::load_file("/etc/git-pull-hook/repos.yml")
  config['repo_home'] + config['repos'][remote]
end

post '/' do
  push = JSON.parse(params[:payload])
  remote_repo = push['repository']['name']
  local_repo = get_local_path(remote_repo)
  `cd #{local_repo} && git pull origin master`
  "ok"
end

# GET /remote-repo used for debugging
get '/:remote' do
  remote_repo = params[:remote]
  local_repo = get_local_path(remote_repo)
  `cd #{local_repo} && git pull origin master`
end
