# v2v for Kubevirt

A job to allow importing a VM from a support virt-v2v source into KubeVirt.

There are some constraints on the VM:

- Single NIC
- Single attached disk

# Example

## OpenShift (WIP)

```bash
$ oc adm policy add-scc-to-user privileged system:serviceaccount:default:kubevirt-privileged
$ oc process --local -f manifests/template.yaml \
    -p SOURCE_TYPE=ova \
    -p SOURCE_NAME=http://192.168.42.1/my.ova \
  | oc create -f -
$ oc get jobs
$ oc get pods
```

## Kubernetes

```bash
$ oc process --local -f manifests/template.yaml \
    -p SOURCE_TYPE=ova \
    -p SOURCE_NAME=http://192.168.42.1/my.ova \
  | kubectl create -f -
$ kubectl get jobs
$ kubectl get pods
```

Alternatively the job manifest can be used directly, but you'll need to modify
it in order to adapt it to your environment:

```bash
# Edit manifests/job.yaml
$ kubectl create -f manifests/job.yaml
$ kubectl logs -f v2v-kw443
```

## Storage

When using [ceph-cinder-demo](https://github.com/rmohr/ceph-cinder-demo) we need to run a command to set default flag for storageClass
```bash
$ oc.sh patch storageclass standalone-cinder -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

# Design

Pretty straight forward:

1. Run virt-v2v with `-o local` inside a container
2. Create a KubeVirt VM definition from the resulting domxml
3. Create a PVC and attach it to a pod
4. Send the disk to the pod with PVC to populate the PVC, and the VM in the
   cluster
