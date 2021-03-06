require 'yaml'
# Set your full path to application.
# app_dir = "/home/flo/flo-invoice/current"
# shared_dir = "/home/flo/flo-invoice/shared"

env = "production"
cnf = YAML::load(File.open("#{shared_dir}/config/settings.yml"))

# Set unicorn options
worker_processes cnf["worker_count"]
preload_app true
timeout 30

# Fill path to your app
working_directory app_dir

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", backlog: 64

# Loging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  SemanticLogger.reopen
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
end
