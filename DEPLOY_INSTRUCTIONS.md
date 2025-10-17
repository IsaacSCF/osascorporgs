# 🚀 Guia Completo de Deploy - Railway + Vercel

## 📋 Pré-requisitos Concluídos
- ✅ Conta Railway criada
- ✅ Conta Vercel criada
- ✅ Conta GitHub ativa
- ✅ Arquivos de configuração preparados

---

## 🎯 PARTE 1: PREPARAR O REPOSITÓRIO GITHUB

### Passo 1.1: Criar Novo Repositório no GitHub
1. Acesse https://github.com/new
2. Nome do repositório: `gestao-orgs` (ou outro nome de sua preferência)
3. Descrição: `Sistema de Gestão de Organizações - FastAPI + React`
4. Visibilidade: **Privado** (recomendado) ou Público
5. **NÃO** marque "Add a README file"
6. **NÃO** adicione .gitignore (já temos)
7. Clique em **"Create repository"**

### Passo 1.2: Inicializar Git Local e Fazer Push

Abra o terminal/CMD na pasta do projeto (`c:/Users/streg/Desktop/gestão de grupos`) e execute:

```bash
# Inicializar repositório Git (se ainda não foi feito)
git init

# Adicionar todos os arquivos
git add .

# Fazer commit inicial
git commit -m "feat: initial commit - sistema de gestão de orgs"

# Adicionar repositório remoto (SUBSTITUA 'seu-usuario' pelo seu username do GitHub)
git remote add origin https://github.com/seu-usuario/gestao-orgs.git

# Fazer push para o GitHub
git branch -M main
git push -u origin main
```

**⚠️ IMPORTANTE:** Substitua `seu-usuario` pelo seu username real do GitHub!

---

## 🚂 PARTE 2: DEPLOY DO BACKEND NO RAILWAY

### Passo 2.1: Criar Projeto no Railway

1. Acesse https://railway.app/dashboard
2. Clique em **"New Project"**
3. Selecione **"Deploy from GitHub repo"**
4. Se for a primeira vez, clique em **"Configure GitHub App"**
5. Autorize o Railway a acessar seus repositórios
6. Selecione o repositório **`gestao-orgs`** (ou o nome que você escolheu)
7. Clique em **"Deploy Now"**

### Passo 2.2: Adicionar PostgreSQL

1. No dashboard do projeto Railway, clique em **"+ New"**
2. Selecione **"Database"**
3. Escolha **"Add PostgreSQL"**
4. Aguarde a criação do banco (leva ~30 segundos)
5. O Railway criará automaticamente a variável `DATABASE_URL`

### Passo 2.3: Configurar Variáveis de Ambiente

1. Clique no serviço do **backend** (não no PostgreSQL)
2. Vá para a aba **"Variables"**
3. Clique em **"+ New Variable"** e adicione as seguintes variáveis:

```
ENVIRONMENT=production
JWT_SECRET_KEY=sua-chave-jwt-super-segura-minimo-32-caracteres-aqui
SECRET_KEY=sua-chave-secreta-diferente-minimo-32-caracteres-aqui
FRONTEND_URL=https://seu-frontend.vercel.app
```

**⚠️ IMPORTANTE:** 
- Gere chaves seguras! Use um gerador online ou execute no terminal:
  ```bash
  python -c "import secrets; print(secrets.token_urlsafe(32))"
  ```
- A variável `DATABASE_URL` já foi criada automaticamente pelo PostgreSQL
- Você atualizará `FRONTEND_URL` depois do deploy do frontend

### Passo 2.4: Verificar Deploy

1. Aguarde o build terminar (~2-5 minutos)
2. Vá para a aba **"Deployments"**
3. Quando aparecer **"Success"**, clique em **"View Logs"** para verificar
4. Vá para a aba **"Settings"**
5. Em **"Domains"**, clique em **"Generate Domain"**
6. Copie a URL gerada (exemplo: `https://gestao-orgs-production.up.railway.app`)
7. Teste acessando: `https://sua-url.up.railway.app/` - deve retornar:
   ```json
   {"message": "Sistema de Organização de Orgs - API Online"}
   ```

**🎉 BACKEND ONLINE!** Anote a URL do Railway, você vai precisar dela!

---

## ⚡ PARTE 3: DEPLOY DO FRONTEND NO VERCEL

### Passo 3.1: Atualizar URL da API no Frontend

**ANTES DE FAZER O DEPLOY NO VERCEL**, você precisa atualizar o frontend com a URL real do Railway:

1. Abra o arquivo `frontend/index.html`
2. Localize a linha (~linha 90):
   ```javascript
   return 'https://your-backend.up.railway.app';
   ```
3. Substitua por sua URL real do Railway:
   ```javascript
   return 'https://gestao-orgs-production.up.railway.app';
   ```
4. Salve o arquivo
5. Faça commit e push:
   ```bash
   git add frontend/index.html
   git commit -m "feat: update API URL for production"
   git push
   ```

### Passo 3.2: Criar Projeto no Vercel

1. Acesse https://vercel.com/dashboard
2. Clique em **"Add New..."** → **"Project"**
3. Clique em **"Import Git Repository"**
4. Se for a primeira vez, clique em **"Add GitHub Account"**
5. Autorize o Vercel a acessar seus repositórios
6. Encontre e selecione o repositório **`gestao-orgs`**
7. Clique em **"Import"**

### Passo 3.3: Configurar Build Settings

Na tela de configuração do projeto:

1. **Framework Preset:** Selecione **"Other"**
2. **Root Directory:** Deixe em branco (ou clique em "Edit" e deixe vazio)
3. **Build Command:** Deixe em branco
4. **Output Directory:** Deixe em branco
5. **Install Command:** Deixe em branco

### Passo 3.4: Adicionar Variáveis de Ambiente (Opcional)

Se quiser, pode adicionar variáveis de ambiente:

1. Clique em **"Environment Variables"**
2. Adicione (opcional):
   ```
   Name: VITE_API_BASE_URL
   Value: https://sua-url.up.railway.app
   ```

### Passo 3.5: Deploy

1. Clique em **"Deploy"**
2. Aguarde o build (~1-2 minutos)
3. Quando aparecer **"Congratulations!"**, clique em **"Visit"**
4. Copie a URL gerada (exemplo: `https://gestao-orgs.vercel.app`)

**🎉 FRONTEND ONLINE!**

---

## 🔗 PARTE 4: CONECTAR FRONTEND E BACKEND

### Passo 4.1: Atualizar CORS no Backend

1. Volte ao Railway Dashboard
2. Clique no serviço do backend
3. Vá para **"Variables"**
4. Edite a variável `FRONTEND_URL`
5. Cole a URL do Vercel (exemplo: `https://gestao-orgs.vercel.app`)
6. Clique em **"Update Variables"**
7. O Railway fará redeploy automático

### Passo 4.2: Testar a Conexão

1. Acesse seu frontend no Vercel
2. Tente fazer login ou registrar um usuário
3. Se funcionar, **SUCESSO!** 🎉
4. Se não funcionar, veja a seção de troubleshooting abaixo

---

## 🗄️ PARTE 5: MIGRAR DADOS (OPCIONAL)

Se você tem dados no SQLite local e quer migrar para o PostgreSQL:

### Opção 1: Exportar/Importar via CSV

1. No sistema local, exporte os dados para CSV
2. No sistema em produção, importe o CSV

### Opção 2: Script de Migração (Avançado)

```python
# migrate_data.py
import sqlite3
import psycopg2
import os

# Conectar ao SQLite local
sqlite_conn = sqlite3.connect('org-manager/orgs.db')
sqlite_cursor = sqlite_conn.cursor()

# Conectar ao PostgreSQL (use a URL do Railway)
pg_conn = psycopg2.connect(os.getenv('DATABASE_URL'))
pg_cursor = pg_conn.cursor()

# Migrar dados (exemplo para tabela orgs)
sqlite_cursor.execute("SELECT * FROM orgs")
rows = sqlite_cursor.fetchall()

for row in rows:
    pg_cursor.execute(
        "INSERT INTO orgs VALUES (%s, %s, %s, ...)",
        row
    )

pg_conn.commit()
print("Migração concluída!")
```

---

## 🔒 PARTE 6: SEGURANÇA E BOAS PRÁTICAS

### 6.1: Verificar Variáveis de Ambiente

✅ **Railway:**
- `ENVIRONMENT=production`
- `JWT_SECRET_KEY` (32+ caracteres únicos)
- `SECRET_KEY` (32+ caracteres únicos, diferente do JWT)
- `DATABASE_URL` (criado automaticamente)
- `FRONTEND_URL` (URL do Vercel)

### 6.2: Proteger Dados Sensíveis

- ✅ `.gitignore` configurado (não sobe .env, logs, banco local)
- ✅ Chaves secretas diferentes em produção
- ✅ CORS configurado apenas para domínios específicos

### 6.3: Monitoramento

**Railway:**
- Dashboard → Metrics: CPU, RAM, Requests
- Dashboard → Logs: Ver logs em tempo real

**Vercel:**
- Dashboard → Analytics: Page views, performance
- Dashboard → Logs: Ver logs de build e runtime

---

## 🔄 PARTE 7: ATUALIZAÇÕES FUTURAS

### Como Atualizar o Sistema

1. Faça alterações no código local
2. Teste localmente
3. Commit e push:
   ```bash
   git add .
   git commit -m "feat: sua descrição da mudança"
   git push
   ```
4. **Railway e Vercel farão redeploy automático!**

### Rollback (Voltar Versão Anterior)

**Railway:**
1. Dashboard → Deployments
2. Clique nos "..." do deployment anterior
3. Clique em "Redeploy"

**Vercel:**
1. Dashboard → Deployments
2. Clique no deployment anterior
3. Clique em "Promote to Production"

---

## 🚨 TROUBLESHOOTING

### Problema: Backend não inicia no Railway

**Solução:**
1. Verifique os logs: Dashboard → Logs
2. Confirme que `railway.json` está correto
3. Verifique se todas as variáveis de ambiente estão configuradas
4. Confirme que `requirements.txt` tem todas as dependências

### Problema: Frontend não conecta ao Backend

**Solução:**
1. Abra o Console do navegador (F12)
2. Verifique se a URL da API está correta
3. Confirme que `FRONTEND_URL` no Railway está correto
4. Teste a API diretamente: `https://sua-url.up.railway.app/`
5. Verifique CORS no backend

### Problema: Erro de CORS

**Solução:**
1. Verifique `FRONTEND_URL` no Railway
2. Confirme que a URL do Vercel está correta (sem barra no final)
3. Limpe cache do navegador (Ctrl+Shift+Delete)

### Problema: Banco de dados não conecta

**Solução:**
1. Verifique se o PostgreSQL está rodando no Railway
2. Confirme que `DATABASE_URL` existe nas variáveis
3. Veja os logs para erros de conexão

### Problema: Build falha no Railway

**Solução:**
1. Verifique se `org-manager/requirements.txt` existe
2. Confirme que `railway.json` tem o buildCommand correto
3. Veja os logs de build para erros específicos

---

## 📊 CUSTOS E LIMITES

### Railway (Plano Gratuito)
- ✅ $5 de crédito grátis por mês
- ✅ 512MB RAM
- ✅ 1GB disco
- ✅ 100GB bandwidth
- ⚠️ Após esgotar créditos, serviço pausa até próximo mês

### Vercel (Plano Hobby - Gratuito)
- ✅ Bandwidth ilimitado
- ✅ 100GB bandwidth por mês
- ✅ Builds ilimitados
- ✅ Domínios customizados

### PostgreSQL Railway (Gratuito)
- ✅ 512MB storage
- ✅ Backups automáticos
- ⚠️ Conta no limite de $5/mês do Railway

---

## ✅ CHECKLIST FINAL

Antes de considerar o deploy completo:

- [ ] Repositório no GitHub criado e atualizado
- [ ] Backend no Railway funcionando
- [ ] PostgreSQL criado e conectado
- [ ] Variáveis de ambiente configuradas no Railway
- [ ] URL do Railway anotada
- [ ] Frontend no Vercel funcionando
- [ ] URL da API atualizada no frontend
- [ ] FRONTEND_URL atualizada no Railway
- [ ] Teste de login/registro funcionando
- [ ] Teste de criação de org funcionando
- [ ] Dados persistindo no PostgreSQL
- [ ] HTTPS funcionando em ambos

---

## 🎯 URLs FINAIS

Após completar todos os passos:

- **Frontend:** https://seu-projeto.vercel.app
- **Backend:** https://seu-projeto.up.railway.app
- **API Docs:** Desabilitada em produção (segurança)
- **Database:** PostgreSQL no Railway (interno)

---

## 📞 SUPORTE

Se encontrar problemas:

1. **Logs Railway:** Dashboard → Logs
2. **Logs Vercel:** Dashboard → Deployments → View Function Logs
3. **Console do Navegador:** F12 → Console
4. **Documentação:**
   - Railway: https://docs.railway.app
   - Vercel: https://vercel.com/docs

---

## 🎉 PARABÉNS!

Seu sistema está rodando em produção com:
- ✅ Backend profissional no Railway
- ✅ Frontend rápido no Vercel
- ✅ Banco PostgreSQL robusto
- ✅ HTTPS automático
- ✅ Deploy automático via Git
- ✅ Gratuito (dentro dos limites)

**Sistema profissional rodando online! 🚀**
