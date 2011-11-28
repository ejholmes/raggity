desc "Start the server station"
task :up do
  env = Vagrant::Environment.new
  if (! env.primary_vm.created?) || (! env.primary_vm.vm.running?)
    puts "Starting the VM, please wait..."
    env.cli("up")
  end
  env.primary_vm.ssh.execute do |ssh|
    puts "Starting station, please wait..."
    ssh.exec!("cd /station && bundle exec rails s")
    puts "Station started."
  end
end

task :down do
  env = Vagrant::Environment.new
  if (env.primary_vm.vm.running?)
    puts "Stopping the VM..."
    env.cli("halt")
  end
end
