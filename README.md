# Requirements:
- git (optional if you download the repo zip instead)
- docker
- docker-compose

# Building the kernel modules
```bash
git clone https://github.com/fr4nk3n5731n/alpine-coral-tpu.git
cd alpine-coral-tpu
make
```
this should create `apex.ko` and `gasket.ko` in the `./output` directory

# Installing the kernel modules
1. copy the kernel modules into /lib/modules/<kernel-version>/
2. `depmod`
3. `modprobe gasket`
3. `modprobe apex`
4. add `gasket` and `apex` to your `/etc/modules` files

## Example
assuming that we compiled the modules locally and want to deploy those modules to a target systen running Alpine 3.20 with Kernel `linux-virt` version `6.6.48-r0`
```bash
# on the machine you used to build the modules, copy the files to the target system
scp "output/*.ko" root@192.168.122.10:/lib/modules/6.6.48-0-virt/

# on the target system
depmod
modprobe gasket
modprobe apex

# adds modules  to modules file if it doesn't exist already
grep gasket /etc/modules || echo "gasket" >> /etc/modules
grep apex /etc/modules || echo "apex" >> /etc/modules
```

# Customisation
keep in mind that just changing the kernel Version might not work due to the version pinning of other installed libraries.
You might need to reference https://pkgs.alpinelinux.org/packages?branch=v3.20&repo=&arch=&maintainer= to update the versions.
## Environment Variables
| Variable         | Default     | Description        |
|------------------|-------------|--------------------|
| `KERNEL_VERSION` | `6.6.48-r0` |                    |
| `KERNEL_VARIANT` | `virt`      | options: lts, virt |

# TODOs:
- add APKBUILD to alpine package
- build CI pipeline to compile the Modules and stuff them into an alpine package
- add support to compile for different CPU architectures