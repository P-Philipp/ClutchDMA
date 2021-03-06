@echo off

cd /D %~dp0
::set filename="%~dp0logs\flash\flash%date:~-4%-%date:~-7,2%-%date:~-10,2%--%time:~-11,2%-%time:~-8,2%-%time:~-5,2%.txt"

set x=1
set i=0
for %%a in (..\*.bin) do set /a i+=1

cls

if %i% EQU %x% (
	if exist ".\Ocd\firmware.bin" (
		move ".\Ocd\firmware.bin" ".\Ocd\firmware%date:~-4%-%date:~-7,2%-%date:~-10,2%--%time:~-11,2%-%time:~-8,2%-%time:~-5,2%.bin" >NUL
	)
	xcopy ..\*.bin .\Ocd\firmware.bin* >NUL
) ELSE (
	echo.
	echo Error while looking for firmware file.
	echo Most likely no firmware file or multiple .bin files were found.
	echo Please make sure that there is only one firmware file next to the dma.bat.
	echo It needs to be a .bin file.
	echo.
	pause
	exit
)

if exist ".\Ocd\firmware.bin" (
	goto decision
) ELSE (
	echo Error while copying firmware file. No firmware.bin file found in destination.
	pause
	exit
)


cls
:decision

set /p flash=Are you sure that you want to flash your DMA Device? [Y/N] 
IF NOT DEFINED flash SET "flash=Y"

if /I %flash%==Y goto flash
if /I %flash%==YES goto flash

if /I %flash%==N exit
if /I %flash%==NO exit

echo.
echo.
echo Invlaid entry please enter "YES" or "NO". Your entry was "%flash%"
echo.
goto decision


:flash
cls

set cfgName=pid0x0403_0x6011.cfg

cd .\Ocd\
openocd.exe -f %cfgName%
echo.

pause
exit