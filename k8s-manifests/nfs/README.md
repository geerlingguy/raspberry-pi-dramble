# NFS Provisioner

The Pi Dramble cluster has NFS installed on all the servers, but uses the `kube1` master instance to host the primary NFS for the rest of the nodes.

This `nfs-client` provisioner is based on (and almost exactly identical to) the `nfs-client` external storage incubator project: https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client

## Example PVC

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
  annotations:
    volume.beta.kubernetes.io/storage-class: pidramble-nfs
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
```

## Example Pod

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: test-pod
spec:
  containers:
  - name: test-pod
    image: gcr.io/google_containers/busybox:1.24
    command:
      - "/bin/sh"
    args:
      - "-c"
      - "touch /mnt/SUCCESS && exit 0 || exit 1"
    volumeMounts:
      - name: nfs-pvc
        mountPath: "/mnt"
  restartPolicy: "Never"
  volumes:
    - name: nfs-pvc
      persistentVolumeClaim:
        claimName: test-claim

```
