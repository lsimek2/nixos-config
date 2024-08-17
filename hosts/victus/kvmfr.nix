{config, pkgs, ...}:
{
    boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
    boot.kernelModules = [ "kvmfr" ];
    
    services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="user", GROUP="kvm", MODE="0660"
    '';
    
    virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm",
        "/dev/kvmfr0"
    ]
    '';
    
    
}

# https://eastern-dream.github.io/blog/posts/nixos-windows-guest-simple-looking-glass-setup-guide/
