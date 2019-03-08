# Presenting with the Raspberry Pi Dramble

When I use the Pi Dramble for certain presentations, I operate it 'wire-gapped'—that is, completely disconnected from the Internet. I do this for a few reasons:

  - I can't always rely on a solid Internet connection at a venue.
  - I can't know ahead of time what private subnets are free so my static IP allocations could result in a variety of failure modes.
  - I need to be able to control the Pis from my presentation laptop, and _that_ computer should also not be connected to the Internet.

Because of these constraints, I have to perform a few additional modifications to the cluster to make sure it's ready for what I call 'presentation mode':

  1. Ensure each node has all the required Docker images on it prior to taking the cluster on the road.
  1. Test all nodes booting from scratch completely disconnected, and verify no Pods get stuck in modes like `ImagePullBackOff`.
  1. Configure my presentation laptop to use a manual wired network configuration.
  1. Triple-check everything one last time from my home or hotel room when I still have time to reconfigure things with an Internet connection if needed!

Even with all the preparation in the world, I can still flub things, especially owing to the complexity of running a Kubernetes cluster in a wire-gapped environment. Kubernetes is a cloud-first system... and when you disconnect it from the 'public cloud', it can fail in interesting ways.

## Prepping the Cluster for Presentation Mode

One of the most important things when operating without an active Internet connection is to make sure that all the nodes have all the potential Kubernetes Deployments' docker images pulled locally.

That way, when you boot the cluster one time and Drupal goes to `kube4`, and another time and it goes to `kube2`, it doesn't matter—the Docker image will be on any node.

Run the playbook in this directory to guarantee the images are all on every Pi:

    ansible-playbook -i ../../inventory main.yml

## Prepping the presentation laptop for Presentation Mode

(This guide assumes the presenter is running macOS.)

  1. Open System Preferences > Network.
  1. Create a new 'Location' named 'Pi Dramble'.
  1. Click on all the devices which are not the wired LAN device (e.g. USB network dongle), and click the '-' to remove them.
  1. Select the wired LAN device, and set 'Configure IPv4' to 'Manually'.
  1. Enter the following values:
    - IP Address: `10.0.100.2`
    - Subnet Mask: `255.0.0.0`
    - Router: `10.0.100.1`
  1. Click 'Apply' to apply the network settings.

In the future, you just need to switch back to the Pi Dramble location and click Apply to go back into 'presentation mode'.

> **NOTE**: You will not be able to access the Internet or any other network while in presentation mode. And don't try doing any hairbrained 'Internet Sharing' or anything like that without testing it before the presentation!
