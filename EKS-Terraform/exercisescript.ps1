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
start-sleep -seconds 20
kubectl get svc -n health-check
echo "please give the cluster about 1 minute to provision the load balancer/external IP. Then copy paste the external IP with :8000 at the end"
echo "the result should be ......elb.amazonaws.com:8000"
start-sleep -seconds 70
$output = kubectl get svc -n health-check

$elbAddress = $output | Select-String -Pattern '[a-zA-Z0-9\-]+\.us-east-1\.elb\.amazonaws\.com' | ForEach-Object { $_.Matches.Value }

$elbAddress = $elbAddress -replace '\r\n', ''

$hostname = $elbAddress -replace ':\d+', ''

$uri = [System.UriBuilder]::new()
$uri.Scheme = "http"
$uri.Host = $hostname
$uri.Port = 8000

$request = [System.Net.WebRequest]::Create($uri.Uri)
$response = $request.GetResponse()
$responseStream = $response.GetResponseStream()
$reader = [System.IO.StreamReader]::new($responseStream)
$responseContent = $reader.ReadToEnd()

$responseContent