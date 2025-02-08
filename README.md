# Cloud DevOps - Deployment e Rollback

## 📌 Sobre o Projeto
Este repositório contém um desafio do Bootcamp **Cloud DevOps Experience - Banco Carrefour**, abordando conceitos de **deployment** e **rollback** em Kubernetes.

O projeto implementa um **Deployment** Kubernetes para o servidor HTTP Apache (`httpd`), garantindo alta disponibilidade e permitindo rollback eficiente em caso de falhas.

---

## 🚀 Tecnologias Utilizadas
- **Kubernetes** - Orquestração de containers
- **Docker** - Containerização da aplicação
- **YAML** - Definição do deployment
- **GitHub Actions** *(opcional)* - CI/CD para automação

---

## 📂 Estrutura do Repositório
```
📦 cloud-devops-deployment-rollback
 ├── 📜 README.md        # Documentação do projeto
 ├── 📜 deployment.yml   # Arquivo de deployment Kubernetes
 ├── 📜 rollback.sh      # Script para rollback (se necessário)
 ├── 📜 .gitignore       # Arquivos ignorados pelo Git
```

---

## 📄 Deployment - Arquivo YAML
O **Deployment** abaixo cria **6 réplicas** do servidor `httpd` dentro de um cluster Kubernetes:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd
  labels:
    app: httpd
spec:
  replicas: 6
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: httpd
        image: httpd:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 80
```

### Explicação do Código
- **replicas: 6** → Mantém 6 instâncias do servidor rodando.
- **image: httpd:2** → Usa a versão mais recente do servidor Apache HTTP.
- **ports: 80** → Expõe a porta 80 para receber requisições HTTP.

---

## 🔄 Rollback
Se for necessário realizar um **rollback** para uma versão anterior, utilize o comando:
```sh
kubectl rollout undo deployment/httpd
```
Isso reverte para a versão anterior do deployment, garantindo disponibilidade e segurança.

---

## 📌 Como Aplicar o Deployment no Kubernetes
1️⃣ **Criar o deployment:**
```sh
kubectl apply -f deployment.yml
```

2️⃣ **Verificar status dos pods:**
```sh
kubectl get pods
```

3️⃣ **Se necessário, fazer rollback:**
```sh
kubectl rollout undo deployment/httpd
```

---

## 🛠 Melhorias Futuras
✅ Configuração de um **Service** para exposição externa
✅ Estratégias avançadas de rollback (Blue-Green Deployment, Canary Releases)
✅ Integração com CI/CD usando GitHub Actions

---

## 📢 Contato
📧 *Email:* gustavogregoriodelima@gmail.com | 🌎 *LinkedIn:* https://www.linkedin.com/in/gustavo-grigorio-de-lima
