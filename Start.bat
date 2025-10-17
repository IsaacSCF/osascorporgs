@echo off
chcp 65001 >nul
color 0A
title 🚀 SISTEMA COMPLETO - Gestão de Orgs

echo.
echo ═══════════════════════════════════════════════════════════════
echo     🚀 SISTEMA DE GESTÃO DE ORGS - INICIALIZAÇÃO COMPLETA
echo ═══════════════════════════════════════════════════════════════
echo.

REM Verificar Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERRO: Python não encontrado!
    echo 📥 Instale em: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo ✅ Python encontrado!
echo.

REM Criar diretório de logs
if not exist "logs" mkdir logs

echo ═══════════════════════════════════════════════════════════════
echo     📋 INICIANDO SERVIÇOS
echo ═══════════════════════════════════════════════════════════════
echo.

REM Iniciar Backend em background
echo ⏳ Iniciando Backend (FastAPI - Porta 8080)...
cd org-manager
start /B python -m uvicorn app.main:app --host 0.0.0.0 --port 8080 > ..\logs\backend.log 2>&1
cd ..
timeout /t 3 /nobreak >nul
echo ✅ Backend iniciado!

REM Iniciar Frontend em background
echo ⏳ Iniciando Frontend (HTTP Server - Porta 3000)...
cd frontend
start /B python -m http.server 3000 > ..\logs\frontend.log 2>&1
cd ..
timeout /t 2 /nobreak >nul
echo ✅ Frontend iniciado!

echo.
echo ═══════════════════════════════════════════════════════════════
echo     ✅ SISTEMA RODANDO LOCALMENTE!
echo ═══════════════════════════════════════════════════════════════
echo.

echo 📱 ACESSO LOCAL:
echo    • Frontend: http://localhost:3000
echo    • Backend:  http://localhost:8080
echo    • API Docs: http://localhost:8080/docs
echo.

echo 📊 LOGS:
echo    • Backend:  logs\backend.log
echo    • Frontend: logs\frontend.log
echo.

echo 🌐 Abrindo navegador...
timeout /t 2 /nobreak >nul
start http://localhost:3000

echo.
echo ═══════════════════════════════════════════════════════════════
echo     💡 INSTRUÇÕES
echo ═══════════════════════════════════════════════════════════════
echo.
echo ⚠️  IMPORTANTE:
echo    • NÃO feche esta janela (mantém os serviços rodando)
echo    • Para parar: Pressione Ctrl+C
echo.
echo 📝 PARA COMPARTILHAR ONLINE:
echo    1. Abra outro CMD
echo    2. Execute: ngrok http 8080 --config %USERPROFILE%\.ngrok2\backend.yml
echo    3. Abra outro CMD
echo    4. Execute: ngrok http 3000 --config %USERPROFILE%\.ngrok2\frontend.yml
echo.
echo ═══════════════════════════════════════════════════════════════
echo.
echo 🎯 Sistema rodando! Pressione Ctrl+C para parar...
echo.

REM Manter CMD aberto e monitorar
:MONITOR
timeout /t 10 /nobreak >nul

REM Verificar se processos estão rodando
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I /N "python.exe">NUL
if "%ERRORLEVEL%"=="1" (
    echo.
    echo ❌ ERRO: Processos Python pararam!
    echo 📋 Verifique os logs em: logs\
    echo.
    pause
    exit /b 1
)

echo [%TIME%] ✅ Sistema rodando normalmente...
goto MONITOR
