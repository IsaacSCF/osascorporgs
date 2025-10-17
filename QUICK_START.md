# ⚡ Quick Start - Deploy em 10 Minutos

## 🎯 Resumo Ultra-Rápido

### 1️⃣ GitHub (2 min)
```bash
git init
git add .
git commit -m "feat: initial commit"
git remote add origin https://github.com/SEU-USUARIO/gestao-orgs.git
git push -u origin main
```

### 2️⃣ Railway - Backend (3 min)
1. https://railway.app/dashboard → **New Project**
2. **Deploy from GitHub repo** → Selecione seu repositório
3. **+ New** → **Database** → **PostgreSQL**
4. Clique no backend → **Variables** → Adicione:
   ```
   ENVIRONMENT=production
   JWT_SECRET_KEY=cole-chave-gerada-aqui
   SECRET_KEY=cole-outra-chave-aqui
   FRONTEND_URL=https://seu-app.vercel.app
   ```
5. **Settings** → **Generate Domain** → Copie a URL

### 3️⃣ Atualizar Frontend (1 min)
Edite `frontend/index.html` linha ~90:
```javascript
return 'https://SUA-URL-DO-RAILWAY.up.railway.app';
```

Commit:
```bash
git add frontend/index.html
git commit -m "feat: update API URL"
git push
```

### 4️⃣ Vercel - Frontend (2 min)
1. https://vercel.com/dashboard → **Add New** → **Project**
2. **Import** seu repositório
3. **Deploy** (deixe tudo padrão)
4. Copie a URL gerada

### 5️⃣ Conectar (2 min)
1. Volte ao Railway
2. Backend → **Variables** → Edite `FRONTEND_URL`
3. Cole a URL do Vercel
4. Aguarde redeploy automático

### ✅ PRONTO!
Acesse seu app no Vercel e teste! 🎉

---

## 🔑 Gerar Chaves Secretas

Execute no terminal:
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

Ou use o script:
```bash
deploy-helper.bat
```

---

## 📋 Checklist Mínimo

- [ ] Repositório no GitHub
- [ ] Backend no Railway com PostgreSQL
- [ ] 4 variáveis configuradas no Railway
- [ ] URL do Railway no frontend
- [ ] Frontend no Vercel
- [ ] URL do Vercel no Railway
- [ ] Teste de login funcionando

---

## 🆘 Problemas Comuns

### Backend não inicia
→ Verifique logs no Railway Dashboard

### Frontend não conecta
→ Abra Console (F12) e veja a URL da API

### Erro de CORS
→ Confirme `FRONTEND_URL` no Railway

---

## 📚 Documentação Completa

- **Guia Detalhado:** [DEPLOY_INSTRUCTIONS.md](DEPLOY_INSTRUCTIONS.md)
- **README:** [README.md](README.md)
- **Uso Local:** [README_COMPLETO.md](README_COMPLETO.md)

---

## 🚀 URLs Importantes

- **Railway:** https://railway.app/dashboard
- **Vercel:** https://vercel.com/dashboard
- **GitHub:** https://github.com/new

---

**⏱️ Tempo total: ~10 minutos**
**💰 Custo: R$ 0,00 (planos gratuitos)**
**🎉 Resultado: Sistema profissional online!**
