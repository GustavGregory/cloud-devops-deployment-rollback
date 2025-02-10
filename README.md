# Cloud DevOps - Deployment e Rollback

## 📌 Sobre o Projeto
Este repositório contém um desafio do Bootcamp **Cloud DevOps Experience - Banco Carrefour**, abordando conceitos de **deployment** e **rollback** em Kubernetes.

O projeto implementa um **Deployment** Kubernetes para o servidor HTTP Apache (`httpd`), garantindo alta disponibilidade e permitindo rollback eficiente em caso de falhas.

---

## 🚀 Tecnologias Utilizadas
- **Minikube** - Orquestração de containers
- **Docker Desktop** - Containerização da aplicação
- **YAML** - Definição do deployment
- **GitHub Actions** *(opcional)* - CI/CD para automação

---

## 📂 Estrutura do Repositório
```
📦 cloud-devops-deployment-rollback
 ├── 📜 README.md        # Documentação do projeto
 ├── 📜 deploy.yml       # Arquivo de deployment Kubernetes
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
- **image: httpd:latest** → Usa a versão mais recente do servidor Apache HTTP.
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
kubectl rollout undo deployment/httpd
```

5️⃣ **Verificar o histórico de revisões do deployment:**
```sh
kubectl rollout history deployment/httpd
```
> Exibe todas as versões anteriores do deployment, permitindo análise e rollback específico, se necessário.

---

## 📌 Próximos Passos
Na próxima parte da videoaula, serão abordados os seguintes tópicos:
✅ **Organizando o histórico de deployment**
✅ **Gerenciamento de Secrets no Kubernetes**

---

## 🛠 Melhorias Futuras
✅ Configuração de um **Service** para exposição externa
✅ Estratégias avançadas de rollback (Blue-Green Deployment, Canary Releases)
✅ Integração com CI/CD usando GitHub Actions
✅ Organização eficiente do histórico de deployments
✅ Implementação de **Secrets** para segurança de credenciais

---

## 📢 Contato
📧 *Email:* gustavogregoriodelima@gmail.com  
🌎 *LinkedIn:* [Gustavo Grigorio de Lima](https://www.linkedin.com/in/gustavo-grigorio-de-lima)
