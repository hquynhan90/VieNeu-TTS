@echo off
setlocal
title Cai dat VieNeu TTS
rem ------------------------------------------------------------------
rem File nay chi lam 3 viec (ban mo bang Notepad de doc):
rem   1. Neu may chua co "uv" (cong cu quan ly Python) -> cai tu astral.sh (trang chinh thuc cua uv)
rem   2. Chay "uv sync" trong thu muc nay de cai cac thu vien cua VieNeu-TTS tu internet
rem   3. Tao icon "Mo VieNeu TTS" tren Desktop
rem Khong chinh sua gi khac tren may cua ban.
rem ------------------------------------------------------------------
cd /d "%~dp0.."

echo ==================================================
echo   CAI DAT VieNeu TTS  -  can internet, vai phut
echo   Can trong khoang 4 GB o dia.
echo ==================================================
echo.

where uv >nul 2>nul
if not errorlevel 1 goto have_uv

echo [1/3] May chua co uv. Dang cai uv tu astral.sh ...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://astral.sh/uv/install.ps1 | iex"
set "PATH=%USERPROFILE%\.local\bin;%PATH%"
where uv >nul 2>nul
if errorlevel 1 goto uv_failed
goto sync

:have_uv
echo [1/3] May da co uv.

:sync
echo.
echo [2/3] Dang cai thu vien VieNeu TTS. Co the mat vai phut, dung dong cua so nay ...
uv sync
if errorlevel 1 goto sync_failed

echo.
echo [3/3] Tao icon tren Desktop ...
powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('Desktop')+'\Mo VieNeu TTS.lnk');$s.TargetPath='%~dp0Mo VieNeu TTS.bat';$s.WorkingDirectory='%~dp0';$s.Save()"

echo.
echo ==================================================
echo   XONG! Tren Desktop da co icon "Mo VieNeu TTS".
echo   Bam dup icon do de mo. Xem HUONG DAN.txt de biet cach dung.
echo ==================================================
pause
exit /b 0

:uv_failed
echo.
echo LOI: khong cai duoc uv. Ban hay xem muc "Cai thu cong" trong HUONG DAN.txt
pause
exit /b 1

:sync_failed
echo.
echo LOI: cai thu vien that bai. Kiem tra ket noi internet roi chay lai file nay.
pause
exit /b 1
