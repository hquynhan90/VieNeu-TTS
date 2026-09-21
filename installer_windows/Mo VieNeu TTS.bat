@echo off
title VieNeu TTS - DONG CUA SO NAY (bam X) DE TAT
cd /d "%~dp0.."
set "PATH=%USERPROFILE%\.local\bin;%PATH%"

rem Da co server chay san thi chi mo trinh duyet, khong bat them server trung.
set HTTP_CODE=
for /f %%c in ('curl -s -o nul -w "%%{http_code}" http://127.0.0.1:7860 2^>nul') do set HTTP_CODE=%%c
if "%HTTP_CODE%"=="200" goto open_only

set HF_HUB_DISABLE_SYMLINKS_WARNING=1

echo ==================================================
echo   VieNeu TTS dang khoi dong ...
echo   Trinh duyet se tu mo khi san sang.
echo   Trong giao dien: bam "Tai Model" roi cho bao thanh cong.
echo   DE TAT HAN: bam X dong cua so den nay.
echo ==================================================

rem Cho den khi server san sang roi moi mo trinh duyet. Chay chung console nay
rem nen dong cua so la vong cho nay cung tat theo.
start "" /b powershell -NoProfile -Command "for($i=0;$i -lt 90;$i++){try{$r=Invoke-WebRequest http://127.0.0.1:7860 -UseBasicParsing -TimeoutSec 2;if($r.StatusCode -eq 200){Start-Process http://127.0.0.1:7860;break}}catch{};Start-Sleep 2}"

uv run vieneu-web

echo.
echo Server da dung. Neu co loi, doc thong bao o tren.
pause
exit /b 0

:open_only
start "" http://127.0.0.1:7860
exit /b 0
