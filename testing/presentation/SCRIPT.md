# Presentation Script

This script lists some of the commands and actions I may or may not perform during a live demo of the Pi Dramble.

## Demonstrate Ansible's remote control using the Blinksticks

  1. `ansible -i inventory all -m service -a "name=dramble-node-monitor state=stopped" -b`
  1. `ansible -i inventory all -a "blinkstick blue" -b`
  1. `ansible -i inventory all -a "blinkstick green" -b`

### Ansible Encounters of the Third Kind

  1. `ansible-playbook -i inventory testing/presentation/ansible-encounters/main.yml`
     (This re-enables `dramble-node-monitor` automatically).

## Demonstrate Kubernetes self-healing

  1. `kubectl get pods -o wide --all-namespaces` (maybe even add filter to just show `kube3` pods)
  1. `ssh pi@10.0.100.63` (`kube3`)
  1. `sudo systemctl stop kubelet`
  1. (Observe red LED on 3rd Pi)
  1. `watch kubectl get nodes` (to see how long it takes the Kubernetes master to mark node as `NotReady`)
  1. `watch kubectl get pods --all-namespaces -o wide` (to see when the Pods on `kube3` get shuffled)

> Note: The default toleration timeout for Deployments in the Pi Dramble is set to `300s`. For presentations, this should be overridden so it is `30s`, by deploying with the following variable in `config.yml`: `kubernetes_toleration_not_ready: 30`.

## Demonstrate Kubernetes Horizontal Pod Autoscaling (HPA)

  1. `watch kubectl get hpa -n drupal`
  1. Start hammering Drupal in new window: `wrk -c 5 -d 120 -t 5 http://cluster.pidramble.test/`
  1. (Wait a minute or so)
  1. Once pods start scaling up: `watch kubectl get pods -n drupal -o wide`

> Note: By default, the HPA has a 5-minute cool-down period. I don't think it's as important to demo the scale-down timings... but if I wanted to I would probably want to change that to 30s or 60s max.
