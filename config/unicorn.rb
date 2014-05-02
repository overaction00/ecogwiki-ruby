worker_processes 4

current_dir = File.dirname(File.absolute_path(__FILE__)) + '/..' 

working_directory current_dir # available in 0.94.0+

listen "/var/run/unicorn.sock", :backlog => 64

timeout 30

pid current_dir + "/tmp/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path current_dir + '/log/unicorn.stderr.log'
stdout_path current_dir + '/log/unicorn.stdout.log'

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true


before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
