def hello-nu [] {
    echo "Welcome to Nu Shell!"
}

# SSH Agent loading
let ssh_agent_file = ( $nu.temp-path | path join $"ssh-agent-($env.USER).nuon" )
if ($ssh_agent_file | path exists) {
    open $ssh_agent_file | load-env
}

def nsh [...pkgs : string] {
    nix-shell --run nu -p ...$pkgs 
}

def cpu_performance [] {
    for i in 0..11 {
       echo performance | sudo tee $"/sys/devices/system/cpu/cpu($i)/cpufreq/scaling_governor"
   }
}

def 'git nixos' [message] {
    git add .
    git commit -m $message
    git push
}

def logout [] {
    qtile cmd-obj -o cmd -f shutdown
}

def ll [] {
  ls -l | reject target num_links inode readonly created accessed
}
