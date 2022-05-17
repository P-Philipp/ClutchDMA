@echo off

cd /D %~dp0
set filename="%~dp0logs\test\test%date:~-4%-%date:~-7,2%-%date:~-10,2%--%time:~-11,2%-%time:~-8,2%-%time:~-5,2%.txt"

net session >NUL
if errorlevel 1 goto runAs
goto startLoop

:runAs
powershell "start dma.bat -v runAs"
exit

:startLoop
cls

echo [1] Test
echo [2] Flash
echo [3] Speedtest
echo [4] Quit
echo.


set /p choice=What do you want to do: 

cd .\dmaStuff\

if %choice%==1 start test.bat -v runAs
if %choice%==2 start flash.bat -v runAs
if %choice%==3 start speedtest.bat -v runAs
if %choice%==4 exit

goto StartLoop