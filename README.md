my-microservice-project

Фінальний проєкт з розгортання мікросервісної інфраструктури на AWS за допомогою Terraform.

Технічні вимоги

Інфраструктура: AWS

Інструменти: Terraform

Компоненти:

VPC

EKS

RDS

ECR

Jenkins

Argo CD

Prometheus

Grafana

Етапи виконання
1️⃣ Підготовка середовища

Ініціалізувати Terraform:

terraform init


Перевірити всі необхідні змінні та параметри.

2️⃣ Розгортання інфраструктури

Виконати команду для розгортання:

terraform apply


Перевірити стан ресурсів:

# Jenkins
kubectl get all -n jenkins

# Argo CD
kubectl get all -n argocd

# Monitoring (Prometheus + Grafana)
kubectl get all -n monitoring

3️⃣ Перевірка доступності сервісів

Jenkins

kubectl port-forward svc/jenkins 8080:8080 -n jenkins


Відкрити у браузері: http://localhost:8080

Argo CD

kubectl port-forward svc/argocd-server 8081:443 -n argocd


Відкрити у браузері: https://localhost:8081

4️⃣ Моніторинг та перевірка метрик

Grafana

kubectl port-forward svc/grafana 3000:80 -n monitoring


Відкрити у браузері: http://localhost:3000

Перевірити стан метрик у Grafana Dashboard.
