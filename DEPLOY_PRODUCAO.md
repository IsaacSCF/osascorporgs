# 🚀 Deploy em Produção - Guia Completo

## 🎯 Visão Geral
Este guia mostra como fazer deploy profissional e gratuito do Sistema de Gestão de Orgs usando **Railway** (backend) + **Vercel** (frontend).

---

## 📋 Pré-requisitos
- ✅ Conta GitHub
- ✅ Conta Railway (https://railway.app)
- ✅ Conta Vercel (https://vercel.com)
- ✅ Projeto no GitHub

---

## 🔧 Passo 1: Preparar o Repositório

### 1.1 Fazer Push do Código
```bash
git add .
git commit -m "feat: add production deployment configs"
git push origin main
```

### 1.2 Verificar Arquivos Criados
- ✅ `railway.json` - Configuração Railway
- ✅ `vercel.json` - Configuração Vercel
- ✅ `.env.example` - Exemplo de variáveis
- ✅ `org-manager/app/main.py` - Atualizado para produção
- ✅ `org-manager/app/database.py` - Suporte multi-banco

---

## 🚂 Passo 2: Deploy Backend (Railway)

### 2.1 Criar Projeto no Railway
1. Acesse https://railway.app
2. Clique "Start a new project"
3. Selecione "Deploy from GitHub"
4. Conecte sua conta GitHub
5. Selecione o repositório do projeto

### 2.2 Configurar Variáveis de Ambiente
No painel Railway, vá para "Variables" e adicione:

```
ENVIRONMENT=production
JWT_SECRET_KEY=sua-chave-jwt-super-segura-aqui
SECRET_KEY=sua-chave-secreta-aqui
DATABASE_URL=sqlite:///./orgs.db
FRONTEND_URL=https://orgs-frontend.vercel.app
```

### 2.3 Deploy Automático
- Railway fará build e deploy automático
- URL gerada: `https://orgs-backend.up.railway.app`

### 2.4 Verificar Deploy
- Acesse a URL gerada
- Deve retornar: `{"message": "Sistema de Organização de Orgs - API Online"}`

---

## ⚡ Passo 3: Deploy Frontend (Vercel)

### 3.1 Criar Projeto no Vercel
1. Acesse https://vercel.com
2. Clique "Import Project"
3. Conecte GitHub
4. Selecione o mesmo repositório

### 3.2 Configurar Build Settings
- **Framework Preset:** Other
- **Root Directory:** (vazio)
- **Build Command:** (vazio - é estático)
- **Output Directory:** (vazio)

### 3.3 Adicionar Variável de Ambiente
```
VITE_API_BASE_URL=https://orgs-backend.up.railway.app
```

### 3.4 Deploy
- Vercel fará deploy automático
- URL gerada: `https://orgs-frontend.vercel.app`

---

## 🔗 Passo 4: Conectar Frontend ao Backend

### 4.1 Atualizar API URL no Frontend
O frontend detecta automaticamente a API, mas para garantir:

```javascript
// No frontend/index.html, linha ~150
const API_BASE = window.location.hostname.includes('ngrok') || window.location.hostname !== 'localhost' && window.location.hostname !== '127.0.0.1'
    ? `${window.location.protocol}//${window.location.hostname}:8000`
    : 'http://127.0.0.1:8000';
```

**Para produção, adicione:**
```javascript
// Detect production URLs
if (window.location.hostname.includes('vercel.app') || window.location.hostname.includes('netlify.app')) {
    API_BASE = 'https://orgs-backend.up.railway.app';
}
```

---

## 🗄️ Passo 5: Configurar Banco PostgreSQL (Opcional)

### 5.1 Adicionar PostgreSQL no Railway
1. No painel Railway, clique "Add Plugin"
2. Selecione "PostgreSQL"
3. Configure (gratuito até certos limites)

### 5.2 Atualizar Variável DATABASE_URL
```
DATABASE_URL=postgresql://postgres:password@containers-us-west-1.railway.app:1234/railway
```
*(URL real será fornecida pelo Railway)*

---

## 🔒 Passo 6: Configurações de Segurança

### 6.1 Atualizar CORS
No Railway, adicione a variável:
```
FRONTEND_URL=https://orgs-frontend.vercel.app
```

### 6.2 Verificar HTTPS
- ✅ Railway: HTTPS automático
- ✅ Vercel: HTTPS automático

### 6.3 Secrets Seguros
- ✅ JWT_SECRET_KEY: Mínimo 32 caracteres
- ✅ SECRET_KEY: Diferente do JWT

---

## 📊 Monitoramento

### Railway Dashboard
- **Logs:** Ver builds e runtime logs
- **Metrics:** CPU, RAM, requests
- **Database:** Queries, connections

### Vercel Dashboard
- **Analytics:** Page views, performance
- **Functions:** (se usar serverless)
- **Domains:** Gerenciar domínios

---

## 🔄 Atualizações

### Deploy Automático
- Push para `main` → Deploy automático
- Railway rebuild backend
- Vercel rebuild frontend

### Rollback
- Railway: Histórico de deploys
- Vercel: Deploy history

---

## 💰 Custos e Limites

| Serviço | Gratuito | Upgrade se necessário |
|---------|----------|----------------------|
| **Railway** | 512MB RAM, 1GB disco, 100h/mês | $5/mês por GB RAM extra |
| **Vercel** | Ilimitado estático | $20/mês por 1TB bandwidth |
| **PostgreSQL** | 512MB (Railway) | $5/mês por GB extra |

---

## 🚨 Troubleshooting

### Problema: Build falha no Railway
**Solução:**
- Verificar logs no Railway dashboard
- Confirmar `requirements.txt` está correto
- Verificar `railway.json`

### Problema: Frontend não conecta à API
**Solução:**
- Verificar variável `FRONTEND_URL` no Railway
- Confirmar CORS no `main.py`
- Verificar se API está respondendo

### Problema: Banco não conecta
**Solução:**
- Para SQLite: Arquivo é criado automaticamente
- Para PostgreSQL: Verificar URL no Railway

---

## 🎯 URLs Finais

Após deploy:
- **Frontend:** https://orgs-frontend.vercel.app
- **Backend:** https://orgs-backend.up.railway.app
- **API Docs:** Desabilitada em produção (segurança)

---

## ✅ Checklist Final

- [ ] Repositório no GitHub
- [ ] Backend no Railway funcionando
- [ ] Frontend no Vercel funcionando
- [ ] Conexão frontend ↔ backend OK
- [ ] HTTPS habilitado
- [ ] Variáveis de ambiente configuradas
- [ ] Teste de login/registro funcionando
- [ ] Banco de dados persistindo dados

---

**🎉 Deploy concluído! Sistema profissional rodando gratuitamente online!**
