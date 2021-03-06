# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, 'blog'
set :deploy_user, 'ubuntu'

# setup repo details
set :repo_url, 'https://github.com/simonyangyang/blog.git'

# without this systemd unit file is wrong
set :rbenv_path, "/home/ubuntu/.rbenv"
# setup rbenv.

set :rbenv_type, :user
set :rbenv_ruby, '3.0.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #{fetch(:rbenv_path)}"
puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #{fetch(:rbenv_prefix)}"

# setup certbot for SSL via letsencrypt
set :certbot_enable_ssl, false
set :certbot_redirect_to_https, true
set :certbot_email, ""
set :certbot_use_acme_staging, false

# setup puma to operate in clustered mode, required for zero downtime deploys
set :puma_preload_app, false
set :puma_init_active_record, true
set :puma_workers, 3
set :puma_systemctl_user, fetch(:deploy_user)
set :puma_enable_lingering, true

# set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_bind, -> { "unix://#{shared_path}/tmp/sockets/puma.sock" }
set :puma_state, -> { "#{shared_path}/tmp/pids/puma.state" }
set :puma_pid, -> { "#{shared_path}/tmp/pids/puma.pid" }

set :bundle_flags, '--deployment'

# how many old releases do we want to keep
set :keep_releases, 5

# Directories that should be linked to the shared folder
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/database.yml', 'config/master.key'

# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
end
