@echo off
chcp 65001 >nul
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║     🚀 ASSISTENTE DE DEPLOY - RAILWAY + VERCEL 🚀             ║
echo ╔════════════════════════════════════════════════════════════════╗
echo.

:MENU
echo.
echo ═══════════════════════════════════════════════════════════════
echo  ESCOLHA UMA OPÇÃO:
echo ═══════════════════════════════════════════════════════════════
echo.
echo  [1] 📦 Preparar e fazer Push para GitHub
echo  [2] 🔑 Gerar Chaves Secretas (JWT e SECRET_KEY)
echo  [3] 📋 Ver Checklist de Deploy
echo  [4] 🌐 Abrir Dashboards (Railway e Vercel)
echo  [5] 📖 Abrir Guia Completo de Deploy
echo  [6] ❌ Sair
echo.
echo ═══════════════════════════════════════════════════════════════
echo.

set /p opcao="Digite o número da opção: "

if "%opcao%"=="1" goto PUSH_GITHUB
if "%opcao%"=="2" goto GERAR_CHAVES
if "%opcao%"=="3" goto CHECKLIST
if "%opcao%"=="4" goto ABRIR_DASHBOARDS
if "%opcao%"=="5" goto ABRIR_GUIA
if "%opcao%"=="6" goto SAIR
goto MENU

:PUSH_GITHUB
echo.
echo ═══════════════════════════════════════════════════════════════
echo  📦 PREPARANDO PUSH PARA GITHUB
echo ═══════════════════════════════════════════════════════════════
echo.
echo ⚠️  IMPORTANTE: Você precisa ter criado o repositório no GitHub!
echo.
set /p repo_url="Cole a URL do seu repositório GitHub (ex: https://github.com/usuario/repo.git): "
echo.
echo 🔄 Inicializando Git...
git init
echo.
echo 📝 Adicionando arquivos...
git add .
echo.
echo 💾 Fazendo commit...
git commit -m "feat: initial commit - sistema de gestão de orgs"
echo.
echo 🔗 Adicionando repositório remoto...
git remote remove origin 2>nul
git remote add origin %repo_url%
echo.
echo 🚀 Fazendo push...
git branch -M main
git push -u origin main
echo.
echo ✅ Push concluído!
echo.
echo 📌 PRÓXIMOS PASSOS:
echo    1. Acesse https://railway.app/dashboard
echo    2. Clique em "New Project" → "Deploy from GitHub repo"
echo    3. Selecione seu repositório
echo    4. Adicione PostgreSQL
echo    5. Configure as variáveis de ambiente
echo.
pause
goto MENU

:GERAR_CHAVES
echo.
echo ═══════════════════════════════════════════════════════════════
echo  🔑 GERANDO CHAVES SECRETAS
echo ═══════════════════════════════════════════════════════════════
echo.
echo Verificando Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python não encontrado! Instale Python primeiro.
    pause
    goto MENU
)
echo.
echo 🔐 Gerando JWT_SECRET_KEY...
python -c "import secrets; print('JWT_SECRET_KEY=' + secrets.token_urlsafe(32))"
echo.
echo 🔐 Gerando SECRET_KEY...
python -c "import secrets; print('SECRET_KEY=' + secrets.token_urlsafe(32))"
echo.
echo ✅ Chaves geradas!
echo.
echo 📋 COPIE estas chaves e adicione no Railway:
echo    1. Acesse seu projeto no Railway
echo    2. Clique no serviço do backend
echo    3. Vá para "Variables"
echo    4. Adicione as chaves acima
echo.
pause
goto MENU

:CHECKLIST
echo.
echo ═══════════════════════════════════════════════════════════════
echo  📋 CHECKLIST DE DEPLOY
echo ═══════════════════════════════════════════════════════════════
echo.
echo PREPARAÇÃO:
echo  [ ] Conta GitHub criada
echo  [ ] Conta Railway criada
echo  [ ] Conta Vercel criada
echo  [ ] Repositório GitHub criado
echo.
echo BACKEND (RAILWAY):
echo  [ ] Projeto criado no Railway
echo  [ ] Repositório conectado
echo  [ ] PostgreSQL adicionado
echo  [ ] Variáveis de ambiente configuradas:
echo      - ENVIRONMENT=production
echo      - JWT_SECRET_KEY
echo      - SECRET_KEY
echo      - FRONTEND_URL
echo  [ ] Deploy bem-sucedido
echo  [ ] URL do Railway anotada
echo  [ ] Teste: https://sua-url.up.railway.app/
echo.
echo FRONTEND (VERCEL):
echo  [ ] URL do Railway atualizada em frontend/index.html
echo  [ ] Commit e push feitos
echo  [ ] Projeto criado no Vercel
echo  [ ] Repositório conectado
echo  [ ] Deploy bem-sucedido
echo  [ ] URL do Vercel anotada
echo.
echo CONEXÃO:
echo  [ ] FRONTEND_URL atualizada no Railway
echo  [ ] Teste de login funcionando
echo  [ ] Teste de criação de org funcionando
echo  [ ] Dados persistindo no PostgreSQL
echo.
echo ✅ Se todos os itens estão marcados, seu deploy está completo!
echo.
pause
goto MENU

:ABRIR_DASHBOARDS
echo.
echo ═══════════════════════════════════════════════════════════════
echo  🌐 ABRINDO DASHBOARDS
echo ═══════════════════════════════════════════════════════════════
echo.
echo 🚂 Abrindo Railway Dashboard...
start https://railway.app/dashboard
timeout /t 2 >nul
echo.
echo ⚡ Abrindo Vercel Dashboard...
start https://vercel.com/dashboard
echo.
echo ✅ Dashboards abertos no navegador!
echo.
pause
goto MENU

:ABRIR_GUIA
echo.
echo ═══════════════════════════════════════════════════════════════
echo  📖 ABRINDO GUIA DE DEPLOY
echo ═══════════════════════════════════════════════════════════════
echo.
echo 📄 Abrindo DEPLOY_INSTRUCTIONS.md...
start DEPLOY_INSTRUCTIONS.md
echo.
echo ✅ Guia aberto!
echo.
pause
goto MENU

:SAIR
echo.
echo ═══════════════════════════════════════════════════════════════
echo  👋 ATÉ LOGO!
echo ═══════════════════════════════════════════════════════════════
echo.
echo 📚 Documentação disponível em:
echo    - DEPLOY_INSTRUCTIONS.md (Guia completo)
echo    - README.md (Visão geral)
echo    - README_COMPLETO.md (Documentação local)
echo.
echo 🚀 Boa sorte com seu deploy!
echo.
timeout /t 3
exit

:ERROR
echo.
echo ❌ Opção inválida! Tente novamente.
echo.
pause
goto MENU
