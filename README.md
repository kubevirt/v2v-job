# v2v for Kubevirt

A job to allow importing a VM from a support virt-v2v source into KubeVirt.

There are some constraints on the VM:

- Single NIC
- Single attached disk

# Example

By default an example Fedora image will be converted:

```bash
$ kubectl create -f manifests/v2v-job.yaml
$ kubectl logs -f v2v-kw443
```

# Design

Pretty straight forward:

1. Run virt-v2v with `-o local` inside a container
2. Create a KubeVirt VM definition from the resulting domxml
3. Create a PVC and attach it to a pod
4. Send the disk to the pod with PVC to populate the PVC, and the VM in the
   cluster
