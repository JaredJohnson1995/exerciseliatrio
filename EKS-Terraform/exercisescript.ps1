terraform apply -auto-approve
start-sleep -seconds 10
aws eks update-kubeconfig --region us-east-1 --name demo
kubectl create namespace health-check
kubectl create secret docker-registry regcred `
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com `
  --docker-username=AWS `
  --docker-password=$(aws ecr get-login-password) `
  --namespace=health-check
  kubectl apply -f manifest.yaml -n health-check
  kubectl get svc -n health-check
  echo please give the cluster about 1 minute 30 seconds to provision the load balancer/external IP. Then copy paste the external IP with :8000 at the end
  echo the result should be ......elb.amazonaws.com:8000