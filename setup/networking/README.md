# Raspberry Pi Networking Setup

When you plug a fresh new Raspberry Pi into your network, the default configuration tells the Pi to use DHCP to dynamically request an IP address from your network's router. Typically this is a pretty random address, and it can make configuration annoying.

To keep things simpler, I elected to jot down the MAC addresses of each of the Pis' onboard LAN ports (this stays the same over time), and map those to a set of contiguous static IP addresses so I can deploy, for example, the balancer to 10.0.1.60, the webservers to 10.0.1.61-62, and so on.

The playbook and configuration in this directory will automatically perform all the required networking configuration to make this so.

To run the playbook:

  1. Copy `example.inventory` to `inventory`, and list all your Raspberry Pi's _current_ IP addresses under `[pis]`
  2. Copy `example.vars.yml` to `vars.yml`, and make sure each Pi's MAC address is mapped to the desired final IP addresses and hostnames.
  3. Run `ansible-playbook -i inventory main.yml`.

> _Note_: If you don't have your SSH key installed on all the Pis yet, you will also need to pass `-k` to the above command and enter your SSH password (the default for Raspbian is `raspberry`).

Reboot the Raspberry Pis after this playbook runs (once you're ready to start accessing them via their new IP addresses):

    $ ansible pis -i inventory -a "shutdown -r now" -s

Now you should be able to run the main Dramble playbooks on your Pi cluster!

## Updating hostnames or IPs

If you ever need to change active Dramble networking info, it's easy! Just change the IP addresses inside the `inventory` file to the active IP addresses of your Pis and run the playbook again, then reboot all your Pis again.

## Manual Networking Setup

_If you don't want to use the automated playbook, you can do the following on each Raspberry Pi individually_:

  1. Set a unique hostname (e.g. `www1.pidramble.com` for the first webserver, and `db1.pidramble.com` for the database server):
    1. Edit `/etc/hostname` and replace the existing hostname with the new hostname.
    2. Enter `hostname [new-hostname]` to update the hostname immediately.
    3. Edit `/etc/hosts` and replace the existing hostname with the new hostname.
  2. Set up the network settings for our Pi network:
    1. Edit `/etc/network/interfaces` and change the `iface eth0 inet dhcp` block to (IP address specific to the server):
        ```
        iface eth0 inet static
          address 10.0.1.60/24
          gateway 10.0.1.1
        ```
    2. Restart the Pi: `sudo reboot`
    3. You'll need to reconnect to the Pi on its new static IP address.

The networking configuration may need to be a little different depending on the environment in which you're using your own Dramble (whether it's on an isolated private network, connected to another network/router, using bridged WiFi interfaces, etc.).
