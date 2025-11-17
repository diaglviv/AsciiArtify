# AsciiArtify — Kubernetes + ArgoCD PoC

## Мета
Демонстрація GitOps-процесу з використанням Kubernetes (kubeadm) та ArgoCD.

## Передумови
- Kubernetes кластер (kubeadm), доступний через kubectl.
- Репозиторій: https://github.com/<username>/AsciiArtify (ця гілка main).
## Кроки розгортання
1. Встановити ArgoCD у кластер:
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

2. Переконатися, що компоненти запущені:
   kubectl get pods -n argocd
3. Отримати доступ до UI (локально):
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   Відкрити https://localhost:8080

4. Логін:
   username: admin
   password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
5. Застосувати ArgoCD Application (файл argocd/app.yaml у репо).

## Як перевірити
- Увійти в UI ArgoCD
- Переконатися, що Application має статус  і 
- Перейти на сервіс демо-застосунку (NodePort/Ingress/port-forward)

## Примітки
- Для production рекомендується налаштувати інший спосіб автентифікації (OIDC/LDAP) та не використовувати початковий пароль.
- Для доступу із зовні налаштувати Ingress (cert-manager + TLS) або LoadBalancer у cloud.
