# Cloud DevOps - Deployment e Rollback

## 📌 Sobre o Projeto
Este repositório contém um desafio do Bootcamp **Cloud DevOps Experience - Banco Carrefour**, abordando conceitos de **deployment** e **rollback** em Kubernetes.

O projeto implementa um **Deployment** Kubernetes para o servidor HTTP Apache (`httpd`), garantindo alta disponibilidade e permitindo rollback eficiente em caso de falhas.

---

## 🚀 Tecnologias Utilizadas
- **Minikube** - Orquestração de containers
- **Docker Desktop** - Containerização da aplicação
- **YAML** - Definição do deployment

---

## 📂 Estrutura do Repositório
```
📦 cloud-devops-deployment-rollback
 ├── 📜 README.md        # Documentação do projeto
 ├── 📜 deploy.yml       # Arquivo de deployment Kubernetes
 ├── 📜 rollback.sh      # Script para rollback (se necessário)
 ├── 📜 mysql.yml        # Deployment do MySQL com Secrets
 ├── 📜 secrets.yml      # Arquivo de Secrets
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
- **image: httpd:latest** → Usa a versão mais recente do servidor Apache HTTP.
- **ports: 80** → Expõe a porta 80 para receber requisições HTTP.

---

## 🔄 Rollback
Se for necessário realizar um **rollback** para uma versão anterior, utilize o comando:
```sh
kubectl rollout undo deployment/httpd
```
Isso reverte para a versão anterior do deployment, garantindo disponibilidade e segurança.

Para voltar para uma versão específica, por exemplo, a primeira versão do deployment:
```sh
kubectl rollout undo deployment/httpd --to-revision=1
```

---

## 📌 Melhores Práticas para Deployment
Para manter um histórico organizado e facilitar rollbacks, nomeie os arquivos de deployment seguindo este padrão:
- **Versão específica:** `httpd-deployment-1.0.yml`
- **Última versão:** `httpd-deployment-latest.yml`

Isso facilita a consulta do histórico e a execução de rollbacks ou rollouts.

---

## 📌 Trabalhando com Secrets no Kubernetes
### Arquivo `secrets.yml`
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  ROOT_PASSWORD: U2VuaGExMjMh
  MYSQL_DATABASE: meubanco
```
> **Observação:** Os valores precisam estar em **Base64**.

### Aplicando o Secret
```sh
kubectl apply -f secrets.yml
```

### Listando Secrets
```sh
kubectl get secrets
```

### Excluindo um Secret
```sh
kubectl delete secret my-secret
```

---

## 📄 Deployment do MySQL com Secrets
### Arquivo `mysql.yml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  selector:
    matchLabels:
      app: mysql
  replicas: 1
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: MYSQL_DATABASE
        ports:
        - containerPort: 3306
```

---

## 📌 Como Aplicar o Deployment no Kubernetes
1️⃣ **Criar o deployment:**
```sh
kubectl apply -f deploy.yml --record
```
> O parâmetro `--record` registra o comando no histórico de revisões do deployment, permitindo rastrear mudanças.

2️⃣ **Verificar status dos pods:**
```sh
kubectl get pods
```

3️⃣ **Verificar detalhes do deployment:**
```sh
kubectl describe deployment httpd
```
> Este comando exibe informações detalhadas sobre o deployment, incluindo eventos, estratégia de atualização, imagens utilizadas e status das réplicas.

4️⃣ **Se necessário, fazer rollback:**
```sh
kubectl rollout undo deployment/httpd --to-revision=1
```
> Retorna o deployment para a primeira versão registrada.

5️⃣ **Verificar o histórico de revisões do deployment:**
```sh
kubectl rollout history deployment/httpd
```

---

## 📢 Contato
📧 *Email:* gustavogregoriodelima@gmail.com  
🌎 *LinkedIn:* [Gustavo Grigorio de Lima](https://www.linkedin.com/in/gustavo-grigorio-de-lima)
