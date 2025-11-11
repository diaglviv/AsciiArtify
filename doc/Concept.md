# Concept: Локальні Kubernetes-кластери для PoC AsciiArtify

**Мета:** порівняти інструменти для локальної розробки Kubernetes (minikube, kind, k3d), врахувати ризики ліцензування Docker та можливість використання Podman, і запропонувати рекомендації та просте демо для PoC стартапу *AsciiArtify*.

---

## Вступ

AsciiArtify — стартап, який будує ML-сервіс для перетворення зображень у ASCII-art. Команда хоче підготувати PoC і локальне середовище розробки на Kubernetes. Ми розглядаємо три популярні підходи:

- **minikube** — локальний кластер Kubernetes у VM або з підтримкою різних драйверів.
- **kind (Kubernetes IN Docker)** — кластери Kubernetes як Docker-контейнери.
- **k3d** — легка обгортка для `k3s` у Docker від Rancher.

---
## Таблиця порівняння

| Інструмент | Підтримувані ОС | Архітектури | Рантайм | Швидкість | CI | Додаткові можливості |
|-------------|-----------------|--------------|----------|------------|----|----------------------|
| **minikube** | Linux, macOS, Windows | amd64, arm64 | Docker, containerd, cri-o, Podman | Середня | Так | Dashboard, Addons |
| **kind** | Linux, macOS, Windows | amd64, arm64 | Docker | Висока | Так | Multi-node |
| **k3d** | Linux, macOS, Windows | amd64, arm64 | Docker | Дуже висока | Так | Lightweight, registry mirror |

---
## Переваги та недоліки

### ✅ minikube
**Переваги:**
- Підтримка різних драйверів (Docker, Podman, VM).
- Вбудовані addons (dashboard, ingress, metrics-server).  
**Недоліки:**
- Повільніший запуск.
- Більше споживання ресурсів.

### ✅ kind
**Переваги:**
- Ідеально підходить для CI/CD.
- Простий у використанні, швидкий, створює multi-node кластери.
**Недоліки:**
- Потребує Docker API (Podman частково сумісний).

### ✅ k3d
**Переваги:**
- Найлегший з усіх (на базі `k3s`).
- Дуже швидкий запуск.
**Недоліки:**
- Не завжди 100% сумісний з upstream Kubernetes.

---
## Ризики Docker ліцензування і Podman

Docker Desktop має корпоративні обмеження.  
Альтернатива — **Podman**, що сумісний із CLI Docker (`podman-docker`), але **kind** і **k3d** очікують наявність Docker API, тому можуть вимагати додаткових налаштувань.

---
## Демонстрація з kind (рекомендований інструмент)

### 1. Встановлення kind
\`\`\`bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind
\`\`\`
