# Sublime Setup to access cluster

Install sublime and its [remotesubl package](https://packagecontrol.io/packages/RemoteSubl).
For manual package installation see [here](https://packagecontrol.io/installation#st3).

To access master node easily, you can copy the config file to the ssh local config file:
```bash
cp k8s_cluster_setup/localhost/config ~/.ssh/
chmod 600 ~/.ssh/config
```
Once logged in to the master node, you can install the rsubl so that it can send the files on the master to your local host node. 
```bash
# wget -O /usr/local/bin/rsub \https://raw.github.com/aurora/rmate/master/rmate
# chmod a+x /usr/local/bin/rsub
```
