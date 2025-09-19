@echo off
setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set year=!datetime:~0,4!
set month=!datetime:~4,2!
set day=!datetime:~6,2!
set date=!year!-!month!-!day!

for /f %%i in ('git log --since="00:00" --until="23:59" --oneline ^| find /c /v ""') do set commitcount=%%i

set commitmessage=!date!_!commitcount!
echo Current date: !commitmessage!

git add .
git commit -m "!commitmessage!"
if errorlevel 1 (
    echo Git commit failed.
    pause
    exit /b 1
)

git push
if errorlevel 1 (
    echo Git push failed.
    pause
    exit /b 1
)

echo Commit and push completed successfully.
pause

endlocal