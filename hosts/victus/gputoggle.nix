{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "unbind" ''
      set -x

      # Unload NVIDIA kernel modules
      sudo modprobe -r nvidia_drm 
      sudo modprobe -r nvidia_modeset
      sudo modprobe -r nvidia_uvm 
      sudo modprobe -r nvidia

      # Detach GPU devices from host
      # Use your GPU and HDMI Audio PCI host device
      sudo virsh nodedev-detach pci_0000_01_00_0
      sudo virsh nodedev-detach pci_0000_01_00_1

      # Load vfio module
      sudo modprobe vfio-pci
    '')

    (pkgs.writeShellScriptBin "bind" ''
      #!/usr/bin/env bash
      set -x

      # Attach GPU devices to host
      # Use your GPU and HDMI Audio PCI host device
      sudo virsh nodedev-reattach pci_0000_01_00_0
      sudo virsh nodedev-reattach pci_0000_01_00_1

      # Unload vfio module
      modprobe -r vfio-pci

      #stop race condition
      sleep 2

      # Load NVIDIA kernel modules
      sudo modprobe nvidia
      sudo modprobe nvidia_modeset
      sudo modprobe nvidia_uvm
      sudo modprobe nvidia_drm
    '')
  ];
}
