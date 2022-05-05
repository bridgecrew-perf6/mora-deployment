## install && configure prometheus operatator
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update
kubectl create ns monitoring
#expose grafana
helm install kps-cloud prometheus-community/kube-prometheus-stack -n monitoring --set grafana.service.type=NodePort
kubectl patch service kps-cloud-grafana -n monitoring --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":30002}]'
