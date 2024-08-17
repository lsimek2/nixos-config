{ config, lib, pkgs, inputs, ... }:
{
  imports = [
  ];

  users.users.carjin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "libvirtd" ]; # 'input' for kmonad
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhjgro/JnCCqYuHT/eiTv0EYqW8kN/MYL/nBmOJ+5l9 karlo.puselj@gmail.com" ];
    packages = with pkgs; [
      firefox
      tree
      discord
      lutris
      signal-desktop
      element-desktop
      nextcloud-client
      gedit
      cargo
      stack
    ];
  };

  # Nextcloud-client autologin
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.carjin.enableGnomeKeyring = true;

  systemd.services.ssh-agent-carjin = {
    enable = true;
    description = "SSH Agent for carjin";
    serviceConfig = {
      ExecStart = pkgs.writeScript "ssh-agent-carjin.nu" ''
        #!${pkgs.nushell}/bin/nu
        let ssh_agent_env = ${pkgs.sudo}/bin/sudo --user=carjin ${pkgs.openssh}/bin/ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record
        load-env $ssh_agent_env
        ${pkgs.openssh}/bin/ssh-add /etc/private/key
        $ssh_agent_env | save -f ( $nu.temp-path | path join "ssh-agent-carjin.nuon" )

        while (ps | where pid == ($env.SSH_AGENT_PID | into int) | length) > 0 {
          sleep 1min
        }
      '';

      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

}
