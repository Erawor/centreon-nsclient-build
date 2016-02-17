Echo Off
COLOR 1E
cls
::===============================================::
:: Script de g�n�ration des paquets NSCLIENT++   ::
::                                               ::
::             LPY 19:20 07/10/2009              ::
::===============================================::

:: Activation des fonctionnalit�s DOS evolu�es
VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
IF ERRORLEVEL 1 ( 
	echo Unable to enable extensions
)

:: Se mettre dans le bon r�pertoire
chdir /d %~dp0

:: D�finition des variables
SET LOGFILE=%~n0.log
SET ZIP=..\bin\7zip\7z.exe
SET NSIS=.\bin\nsis\makensis.exe
SET RESSOURCES=.\ressources
SET SETUP32_044=builddef-Win32-044.nsi
SET SETUP64_044=builddef-x64-044.nsi

:: Copie scripts 32
xcopy scripts\win32 build\scripts /E /S /Y

:: G�n�ration 32 bits
Echo. 
Echo -----------------------------------
Echo ^|     32 bits generation        ^|
Echo -----------------------------------
Echo.

del /F /Q Prerequisites\nsclient-resource*
copy resources\nsclient-044.ini build\nsclient.ini /Y
chdir build
%ZIP% a -tzip ..\Prerequisites\nsclient-resource.zip .\ -r
chdir ..

%NSIS% /V2 !SETUP32_044!

:: Copie scripts 32
rmdir /S /Q build\scripts\merethis
xcopy scripts\x64 build\scripts /E /S /Y

:: G�n�ration 64 bits
Echo. 
Echo -----------------------------------
Echo ^|    64 bits generation         ^|
Echo -----------------------------------
Echo.

del /F /Q Prerequisites\nsclient-resource*
copy resources\nsclient-044.ini build\nsclient.ini /Y
chdir build
%ZIP% a -tzip ..\Prerequisites\nsclient-resource.zip .\ -r
chdir ..

%NSIS% /V2 !SETUP64_044!

:: Clean
rmdir /S /Q build\scripts\merethis
del /F /Q Prerequisites\nsclient-resource.zip
del /F /Q build\nsclient.ini

:: Fin de la g�n�ration
Echo. 
Echo ----------------------------------------
Echo ^|      ^End of binaries generation      ^|
Echo ----------------------------------------
Echo.
PAUSE
