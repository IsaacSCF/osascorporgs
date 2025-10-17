# 🚀 Sistema de Gestão de Orgs - Guia Completo

## 📋 Índice
- [Início Rápido](#início-rápido)
- [Configuração Inicial](#configuração-inicial)
- [Scripts Disponíveis](#scripts-disponíveis)
- [Tokens e Configuração Ngrok](#tokens-e-configuração-ngrok)
- [Solução de Problemas](#solução-de-problemas)

---

## 🎯 Início Rápido

### Para usar LOCALMENTE (sem internet):
```cmd
Start.bat
```

Isso vai:
- ✅ Iniciar Backend (porta 8080)
- ✅ Iniciar Frontend (porta 3000)
- ✅ Abrir navegador automaticamente
- ✅ Tudo em um único CMD

**Acesso:**
- Frontend: http://localhost:3000
- Backend: http://localhost:8080
- API Docs: http://localhost:8080/docs

---

## 🔧 Configuração Inicial

### 1. Pré-requisitos
- ✅ Python 3.8+ instalado
- ✅ ngrok.exe na pasta do projeto
- ✅ Tokens do ngrok configurados

### 2. Tokens Ngrok Configurados

**Backend:**
- Token: `ep_34ArOidemdj6VkWGnziPeUr6Tfw`
- Config: `C:\Users\streg\.ngrok2\backend.yml`

**Frontend:**
- Token: `ep_34ArGrmIFpTq90XuTzm6y7OnNTH`
- Config: `C:\Users\streg\.ngrok2\frontend.yml`

### 3. Arquivos de Configuração

**`C:\Users\streg\.ngrok2\backend.yml`:**
```yaml
version: "2"
authtoken: ep_34ArOidemdj6VkWGnziPeUr6Tfw
```

**`C:\Users\streg\.ngrok2\frontend.yml`:**
```yaml
version: "2"
authtoken: ep_34ArGrmIFpTq90XuTzm6y7OnNTH
```

**`traffic-policy.yml`:**
```yaml
on_http_request:
  - actions:
      - type: custom-response
        config:
          status_code: 401
          content: "Authentication required"
          headers:
            content-type: text/plain
            www-authenticate: 'Basic realm="Ngrok"'
    expressions:
      - "!('Authorization' in req.headers && req.headers['authorization'].startsWith('Basic '))"
  - actions:
      - type: custom-response
        config:
          status_code: 401
          content: "Invalid credentials"
    expressions:
      - "req.headers['authorization'] != 'Basic YWRtaW46YWRtaW4xMjM=' && req.headers['authorization'] != 'Basic dXNlcjp1c2VyMTIz'"
```

**Credenciais de Acesso:**
- Usuário 1: `admin` / `admin123`
- Usuário 2: `user` / `user123`

---

## 📜 Scripts Disponíveis

### 🌟 Script Principal

#### `Start.bat` ⭐ **RECOMENDADO**
Inicia tudo localmente em um único CMD.
```cmd
Start.bat
```

**O que faz:**
- Inicia Backend (porta 8080)
- Inicia Frontend (porta 3000)
- Abre navegador automaticamente
- Monitora processos
- Salva logs em `logs\`

**Para parar:** Pressione `Ctrl+C`

---

### 🔗 Scripts Ngrok (Para Compartilhar Online)

#### Passo 1: Inicie o sistema localmente
```cmd
Start.bat
```

#### Passo 2: Em outro CMD, inicie os túneis ngrok

**Para Backend:**
```cmd
ngrok http 8080 --config %USERPROFILE%\.ngrok2\backend.yml --traffic-policy-file traffic-policy.yml
```

**Para Frontend:**
```cmd
ngrok http 3000 --config %USERPROFILE%\.ngrok2\frontend.yml --traffic-policy-file traffic-policy.yml
```

---

## 🔐 Segurança

### Autenticação Basic Auth
Todos os acessos via ngrok requerem autenticação:

**Credenciais válidas:**
- `admin:admin123`
- `user:user123`

### Tokens Separados
- Backend e Frontend usam tokens diferentes
- Evita conflitos de endpoint
- Maior segurança e controle

---

## 📊 Monitoramento

### Logs Locais
- Backend: `logs\backend.log`
- Frontend: `logs\frontend.log`

### Painéis Ngrok (quando túneis ativos)
- Backend: http://localhost:4040
- Frontend: http://localhost:4041

---

## 🛠️ Solução de Problemas

### Problema: "Python não encontrado"
**Solução:**
1. Instale Python: https://www.python.org/downloads/
2. Marque "Add Python to PATH" durante instalação
3. Reinicie o CMD

### Problema: "Porta já em uso"
**Solução:**
```cmd
REM Parar processos Python
taskkill /f /im python.exe

REM Parar processos Ngrok
taskkill /f /im ngrok.exe
```

### Problema: "ERR_NGROK_334 - endpoint already online"
**Solução:**
1. Você está tentando usar o mesmo endpoint em dois túneis
2. Use tokens diferentes para backend e frontend (já configurado)
3. Ou pare o túnel existente primeiro

### Problema: "version property is required"
**Solução:**
Os arquivos de configuração já foram corrigidos com `version: "2"`.

Verifique se os arquivos existem:
- `C:\Users\streg\.ngrok2\backend.yml`
- `C:\Users\streg\.ngrok2\frontend.yml`

---

## 📱 Fluxo de Uso Completo

### Uso Local (Desenvolvimento)
```
1. Execute: Start.bat
2. Acesse: http://localhost:3000
3. Desenvolva e teste
4. Ctrl+C para parar
```

### Uso Online (Compartilhar)
```
1. Execute: Start.bat (mantém rodando)
2. Novo CMD: ngrok http 8080 --config %USERPROFILE%\.ngrok2\backend.yml --traffic-policy-file traffic-policy.yml
3. Novo CMD: ngrok http 3000 --config %USERPROFILE%\.ngrok2\frontend.yml --traffic-policy-file traffic-policy.yml
4. Copie o link do Frontend (porta 3000)
5. Compartilhe com amigos
6. Eles acessam com: admin/admin123
```

---

## 🎯 Estrutura do Projeto

```
gestão de grupos/
├── Start.bat                    ⭐ Script principal
├── ngrok.exe                    Executável do ngrok
├── traffic-policy.yml           Configuração de autenticação
├── README_COMPLETO.md           Este arquivo
├── frontend/
│   └── index.html              Interface do usuário
├── org-manager/
│   ├── app/                    Código do backend
│   └── orgs.db                 Banco de dados
├── logs/
│   ├── backend.log             Logs do backend
│   └── frontend.log            Logs do frontend
└── C:\Users\streg\.ngrok2/
    ├── backend.yml             Config ngrok backend
    └── frontend.yml            Config ngrok frontend
```

---

## 💡 Dicas

1. **Sempre use `Start.bat` primeiro** - É o mais simples e confiável
2. **Mantenha a janela aberta** - Fechar = parar os serviços
3. **Logs são seus amigos** - Verifique `logs\` se algo der errado
4. **Tokens separados** - Backend e Frontend usam contas diferentes
5. **Autenticação ativa** - Todos acessos remotos precisam de login

---

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs em `logs\`
2. Confirme que Python está instalado
3. Verifique se as portas 8080 e 3000 estão livres
4. Confirme que os arquivos de configuração existem

---

## ✅ Checklist de Funcionamento

- [ ] Python instalado e no PATH
- [ ] `Start.bat` executa sem erros
- [ ] http://localhost:3000 abre no navegador
- [ ] http://localhost:8080/docs mostra a documentação da API
- [ ] Arquivos de configuração ngrok existem
- [ ] Tokens configurados corretamente
- [ ] Autenticação funcionando

---

**Tudo configurado e sincronizado! 🎉**
