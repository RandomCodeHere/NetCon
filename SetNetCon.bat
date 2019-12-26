
:: Hello friend !
ECHO.
ECHO off

:: set global variables
chcp 65001

:: NETWORK_ID is set (THIS IS FOR WIRED CONNECTIONS ONLY)
:: -------------------------------------
for /F "skip=3 tokens=1,2,3* delims= " %%G in ('netsh interface show interface') DO (SET NETWORK_ID=%%J)
echo %NETWORK_ID%
cls
:: -------------------------------------


:: If you care, do not edit !
SET LINE_BREAK=──────────────────────────────────────────────────────────────
SET NET_STATUS=ERROR 
SET NETCON_VERSION=0.2
SET AUTHOR=RandomCodeHere
SET SCRIPT_NAME=NetCon
SET SCRIPT_TITLE=%SCRIPT_NAME% v%NETCON_VERSION% by %AUTHOR%
SET GITHUB_URL=https://github.com/RandomCodeHere/NetCon
cls


:: set window ui
mode con: cols=55 lines=10 
color CF
title %SCRIPT_TITLE%
:: ------------------------------ ADMIN TEST ----------------------
OPENFILES >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
	cls
	ECHO.
    ECHO      You need admin rights to use this script !
    ECHO     ────────────────────────────────────────────
    ECHO.
    ECHO     Press any key to exit.
    ECHO.
    ECHO.
    pause > NUL

    exit  
)


:: -- Boot lines
GOTO testNet
:: ----------------------------- MENU CODE ------------------------
:: set window ui
:Menu
mode con: cols=62 lines=29 
color 0B
cls
ECHO.
ECHO.
ECHO.
echo     ███╗   ██╗███████╗████████╗ ██████╗ ██████╗ ███╗   ██╗
echo     ████╗  ██║██╔════╝╚══██╔══╝██╔════╝██╔═══██╗████╗  ██║
echo     ██╔██╗ ██║█████╗     ██║   ██║     ██║   ██║██╔██╗ ██║
echo     ██║╚██╗██║██╔══╝     ██║   ██║     ██║   ██║██║╚██╗██║
echo     ██║ ╚████║███████╗   ██║   ╚██████╗╚██████╔╝██║ ╚████║
echo     ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝
echo     v%NETCON_VERSION%
echo.
echo                                         by %AUTHOR%
echo.
ECHO %LINE_BREAK%
ECHO   ▒ Connection ID :  %NETWORK_ID%
ECHO   ▒ Status        :  ► %NET_STATUS% ◄

ECHO %LINE_BREAK%
ECHO.
:: echo   ╓─────────╖
ECHO   Options 
ECHO   ────────
ECHO   [1]   Disconnect from internet
ECHO          *Disable network interface    
ECHO. 
ECHO   [2]   Enables internet
ECHO           *Restore connection  
ECHO. 
ECHO   [i]   About
ECHO   [Q]   Quit script
ECHO.
CHOICE /C 12iQ /M "Select option: "
IF ERRORLEVEL 4 GOTO quit
IF ERRORLEVEL 3 GOTO about
IF ERRORLEVEL 2 GOTO EnableNET
IF ERRORLEVEL 1 GOTO DisableNET
GOTO Menu

:: --------------------------- NIC CODE ---------------------
:DisableNET
COLOR E0
cls
ECHO.
echo  ╔════════════════════╗
ECHO  ║ Disabling internet ║
ECHO  ╚════════════════════╝
rem ECHO netsh interface set interface \"%NETWORK_ID%\" admin=disable
netsh interface set interface \"%NETWORK_ID%\" admin=disable > NUL
echo.
ECHO  Command sent [ok]
ECHO  Testing. Just a second...
timeout /t 3 /nobreak > NUL
GOTO testNet
ECHO.
pause
GOTO END

:EnableNET
color E0
cls
ECHO.
ECHO  ╔═══════════════════════════════╗
ECHO  ║ Restoring internet connection ║
ECHO  ╚═══════════════════════════════╝
ECHO. 
ECHO  Restoring NICs
netsh interface set interface \"%NETWORK_ID%\" admin=enable > NUL
timeout /t 5 /nobreak > NUL
GOTO testNet
ECHO.
GOTO Menu

:testNet
COLOR E0
ping -n 1 www.google.com > NUL
IF %ERRORLEVEL% NEQ 0 (
    ECHO  Internet disabled.
    ECHO.
    timeout /t 2 /nobreak > NUL
       	SET NET_STATUS=Disconnected
       	GOTO Menu

) ELSE (
	echo  Testing connection...
	ECHO  Please wait ~2 seconds	
    ECHO.
	timeout /t 2 /nobreak > NUL
    SET NET_STATUS=Connected
    GOTO Menu
    
)

:: About the script
:about
COLOR 09
cls
ECHO.
ECHO.
echo            █████╗ ██████╗  ██████╗ ██╗   ██╗████████╗
echo           ██╔══██╗██╔══██╗██╔═══██╗██║   ██║╚══██╔══╝
echo           ███████║██████╔╝██║   ██║██║   ██║   ██║   
echo           ██╔══██║██╔══██╗██║   ██║██║   ██║   ██║   
echo           ██║  ██║██████╔╝╚██████╔╝╚██████╔╝   ██║   
echo           ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   
echo.
echo                           %SCRIPT_NAME%
ECHO %LINE_BREAK%
echo.
echo    version....: %NETCON_VERSION%
echo    github.....: %GITHUB_URL%
echo.
echo    Made by %AUTHOR%
echo.
echo.
echo.
ECHO  Press any key to return to the menu
pause > NUL
GOTO Menu

:: End script
:END
chcp 437
ENDLOCAL
EXIT /B 0

::
::
::
:: Made by Desypher
::
::
::