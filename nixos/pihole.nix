{ lib, config, pkgs, inputs, vars, ... }:

{
  # pihole docker container (DNS server with ad and tracker blocking)
  # Ref: https://github.com/NixOS/nixpkgs/issues/61617#issuecomment-500793160

  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:latest";
    # pull = "always"; # Ensures the image is always pulled - needs 25.05??
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "3080:80"
      "30443:443"
    ];
    volumes = [
      "/var/lib/pihole/:/etc/pihole/"
      "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
    ];
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--dns=127.0.0.1"
      "--dns=1.1.1.1"
    ];
  };
}
