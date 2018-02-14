# v2v for Kubevirt

A job to allow importing a VM from a support virt-v2v source into KubeVirt.

There are some constraints on the VM:

- Single NIC
- Single attached disk

# Design

Pretty straight forward:

1. Run virt-v2v with `-o local` inside a container
2. Create a KubeVirt VM definition from the resulting domxml
3. Convert and write the disk contents to a freshly created PV
