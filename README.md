# 🏢 Sistema de Gestão de Organizações

Sistema completo para gerenciamento de organizações legais e ilegais com autenticação, controle de acesso por roles e sincronização em tempo real.

## 🚀 Deploy em Produção

- **Backend:** Railway (FastAPI + PostgreSQL)
- **Frontend:** Vercel (React)
- **Status:** ✅ Pronto para deploy

### Links Rápidos
- 📖 [Guia Completo de Deploy](DEPLOY_INSTRUCTIONS.md)
- 📋 [Documentação Completa](README_COMPLETO.md)
- 🚀 [Guia de Deploy Produção](DEPLOY_PRODUCAO.md)

## 🛠️ Tecnologias

### Backend
- **FastAPI** - Framework web moderno e rápido
- **SQLAlchemy** - ORM para banco de dados
- **PostgreSQL** - Banco de dados em produção
- **JWT** - Autenticação segura
- **Alembic** - Migrações de banco

### Frontend
- **React** - Interface de usuário
- **Bootstrap 5** - Design responsivo
- **Font Awesome** - Ícones
- **WebSocket** - Atualizações em tempo real

## 📦 Estrutura do Projeto

```
gestão de grupos/
├── frontend/
│   └── index.html              # Interface React (SPA)
├── org-manager/
│   ├── app/
│   │   ├── main.py            # Aplicação FastAPI
│   │   ├── database.py        # Configuração do banco
│   │   ├── models/            # Modelos SQLAlchemy
│   │   ├── routes/            # Rotas da API
│   │   ├── schemas/           # Schemas Pydantic
│   │   └── utils/             # Utilitários
│   ├── alembic/               # Migrações
│   ├── requirements.txt       # Dependências Python
│   └── Dockerfile            # Container Docker
├── railway.json               # Configuração Railway
├── vercel.json               # Configuração Vercel
├── .gitignore                # Arquivos ignorados
├── .env.example              # Template de variáveis
└── DEPLOY_INSTRUCTIONS.md    # Guia de deploy

```

## 🎯 Funcionalidades

### Sistema de Autenticação
- ✅ Registro de usuários
- ✅ Login com JWT
- ✅ Sistema de aprovação de usuários
- ✅ Controle de acesso por roles
- ✅ Bloqueio por tentativas excessivas

### Gestão de Organizações
- ✅ CRUD completo de organizações
- ✅ Filtros por tipo (Legal/Ilegal)
- ✅ Tags de fabricação customizáveis
- ✅ Controle de membros ativos
- ✅ Status de entrega
- ✅ Importação via CSV/Excel
- ✅ Seleção múltipla e ações em lote

### Painel Administrativo
- ✅ Aprovação de novos usuários
- ✅ Gerenciamento de roles
- ✅ Bloqueio/desbloqueio de usuários
- ✅ Alteração de senhas
- ✅ Auditoria de ações

### Auditoria
- ✅ Log de todas as ações
- ✅ Histórico de alterações
- ✅ Rastreamento por usuário

## 🔐 Roles e Permissões

| Role | Permissões |
|------|-----------|
| **Admin** | Acesso total, gerencia usuários e todas as orgs |
| **Moderador Legal** | Gerencia apenas organizações legais |
| **Moderador Ilegal** | Gerencia apenas organizações ilegais |
| **Visualizador** | Apenas visualização, sem edição |

## 🚀 Deploy Rápido

### 1. Preparar Repositório
```bash
git init
git add .
git commit -m "feat: initial commit"
git remote add origin https://github.com/seu-usuario/gestao-orgs.git
git push -u origin main
```

### 2. Deploy Backend (Railway)
1. Acesse https://railway.app
2. New Project → Deploy from GitHub
3. Selecione o repositório
4. Adicione PostgreSQL
5. Configure variáveis de ambiente

### 3. Deploy Frontend (Vercel)
1. Acesse https://vercel.com
2. Import Project → GitHub
3. Selecione o repositório
4. Deploy

### 4. Conectar
1. Copie URL do Railway
2. Atualize `frontend/index.html` com a URL
3. Atualize `FRONTEND_URL` no Railway
4. Commit e push

📖 **[Ver guia completo passo a passo](DEPLOY_INSTRUCTIONS.md)**

## 💻 Desenvolvimento Local

### Pré-requisitos
- Python 3.8+
- Node.js (opcional, para ferramentas)

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/gestao-orgs.git
cd gestao-orgs
```

2. **Configure o backend**
```bash
cd org-manager
pip install -r requirements.txt
```

3. **Configure variáveis de ambiente**
```bash
cp .env.example .env
# Edite .env com suas configurações
```

4. **Inicie o backend**
```bash
uvicorn app.main:app --reload --port 8000
```

5. **Inicie o frontend**
```bash
# Em outro terminal
cd frontend
python -m http.server 3000
```

6. **Acesse**
- Frontend: http://localhost:3000
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

### Ou use o script automático
```bash
Start.bat  # Windows
```

## 🔧 Configuração

### Variáveis de Ambiente

```env
ENVIRONMENT=production
JWT_SECRET_KEY=sua-chave-jwt-segura
SECRET_KEY=sua-chave-secreta
DATABASE_URL=postgresql://user:pass@host:5432/db
FRONTEND_URL=https://seu-frontend.vercel.app
```

### Banco de Dados

**Desenvolvimento:** SQLite (automático)
```
DATABASE_URL=sqlite:///./orgs.db
```

**Produção:** PostgreSQL (Railway)
```
DATABASE_URL=postgresql://... (automático)
```

## 📊 API Endpoints

### Autenticação
- `POST /auth/register` - Registrar usuário
- `POST /auth/login` - Login
- `GET /auth/me` - Dados do usuário atual
- `GET /auth/pending` - Usuários pendentes (admin)
- `POST /auth/{id}/approve` - Aprovar usuário (admin)

### Organizações
- `GET /orgs/` - Listar organizações
- `POST /orgs/` - Criar organização
- `GET /orgs/{id}` - Buscar organização
- `PUT /orgs/{id}` - Atualizar organização
- `DELETE /orgs/{id}` - Excluir organização
- `POST /orgs/import` - Importar CSV/Excel

### Auditoria
- `GET /orgs/audit/` - Logs de auditoria

## 🧪 Testes

```bash
# Instalar dependências de teste
pip install pytest pytest-cov

# Rodar testes
pytest

# Com cobertura
pytest --cov=app tests/
```

## 📝 Migrações

```bash
# Criar migração
alembic revision --autogenerate -m "descrição"

# Aplicar migrações
alembic upgrade head

# Reverter migração
alembic downgrade -1
```

## 🐳 Docker

```bash
# Build
docker build -t gestao-orgs .

# Run
docker run -p 8000:8000 gestao-orgs

# Com Docker Compose
docker-compose up
```

## 📈 Monitoramento

### Railway
- Dashboard → Metrics: CPU, RAM, Requests
- Dashboard → Logs: Logs em tempo real

### Vercel
- Dashboard → Analytics: Page views, performance
- Dashboard → Logs: Build e runtime logs

## 🔒 Segurança

- ✅ Autenticação JWT
- ✅ Senhas criptografadas (bcrypt)
- ✅ CORS configurado
- ✅ HTTPS obrigatório em produção
- ✅ Rate limiting (Railway)
- ✅ Validação de entrada (Pydantic)
- ✅ SQL Injection protection (SQLAlchemy)

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é privado e proprietário.

## 👥 Autores

- **Desenvolvedor Principal** - Sistema de Gestão de Orgs

## 🙏 Agradecimentos

- FastAPI pela excelente documentação
- Railway e Vercel pelos planos gratuitos
- Comunidade open source

## 📞 Suporte

- 📧 Email: seu-email@exemplo.com
- 💬 Discord: Seu Discord
- 🐛 Issues: [GitHub Issues](https://github.com/seu-usuario/gestao-orgs/issues)

---

**⭐ Se este projeto foi útil, considere dar uma estrela!**

**🚀 Deploy em produção em minutos com Railway + Vercel!**
