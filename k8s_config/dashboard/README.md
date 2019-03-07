#Configuring Dashboard
```bash
kubectl create -f kubernets-dashboard.yml
```
#Creating sample user

```bash
kubectl apply -f dashboard-adminuser.yaml
kubectl apply -f ClusterRoleBinding.yaml
```
# Enable Outside Traffic
```bash
kubectl proxy  --address='10.0.2.15'
```