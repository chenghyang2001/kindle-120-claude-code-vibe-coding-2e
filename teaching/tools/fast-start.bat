@echo off
chcp 65001 >nul
setlocal EnableExtensions
REM K120 fast demo launcher. Docs: teaching\FAST-RUN.md, teaching\steps\fast-demo.md
REM Usage: fast-start.bat PRACTICE_FOLDER_NAME [--no-launch]
REM
REM Why this file is ASCII only: cmd misreads UTF-8 batch files after a goto
REM (lines get split mid-character), and findstr cannot match a Chinese
REM literal passed on the command line. All Chinese text therefore lives in
REM fast-start-exception.md (UTF-8) and is copied byte for byte with type.

set "PRACTICE_NAME=%~1"
set "LAUNCH_MODE=%~2"
set "EXCEPTION_FILE=%~dp0fast-start-exception.md"
if "%PRACTICE_NAME%"=="" goto :usage
if /i "%PRACTICE_NAME%"=="--no-launch" goto :usage
if "%PRACTICE_NAME%"=="/?" goto :usage

REM A name with a path would create an unexpected nested folder under workspace
echo %PRACTICE_NAME%| findstr /r "[\\/:]" >nul
if not errorlevel 1 goto :bad_name

where git >nul 2>nul
if errorlevel 1 goto :no_git
where claude >nul 2>nul
if errorlevel 1 goto :no_claude
if not exist "%EXCEPTION_FILE%" goto :no_exception_file

set "PRACTICE_DIR=%USERPROFILE%\workspace\%PRACTICE_NAME%"
set "CLAUDE_MD=%PRACTICE_DIR%\CLAUDE.md"

REM Reuse an existing folder without wiping it: ch05/ch06 git clone the sample first
if exist "%PRACTICE_DIR%\" goto :reuse_dir
mkdir "%PRACTICE_DIR%"
if errorlevel 1 goto :mkdir_failed
git -C "%PRACTICE_DIR%" init
if errorlevel 1 goto :git_init_failed
echo [created] %PRACTICE_DIR%
goto :ensure_exception

:reuse_dir
echo [reused] %PRACTICE_DIR% (kept as is)

:ensure_exception
REM The hook switch alone is not enough: in ch04 the model still dispatched
REM agents after reading the global rule, so CLAUDE.md needs the exception too.
if not exist "%CLAUDE_MD%" goto :append_exception
REM findstr /g reads the pattern as raw bytes, so the UTF-8 heading matches.
REM Only the heading line is used: multiple literal patterns of different
REM lengths make findstr miss matches.
set "PATTERN_FILE=%TEMP%\k120-fast-start-%RANDOM%.txt"
set /p EXCEPTION_HEADING=<"%EXCEPTION_FILE%"
>"%PATTERN_FILE%" echo %EXCEPTION_HEADING%
if errorlevel 1 goto :write_failed
findstr /l /g:"%PATTERN_FILE%" "%CLAUDE_MD%" >nul 2>nul
set "FIND_RESULT=%errorlevel%"
del "%PATTERN_FILE%" >nul 2>nul
if "%FIND_RESULT%"=="0" goto :exception_exists
REM Two line breaks: ends a last line without newline, then leaves a blank line
>>"%CLAUDE_MD%" echo(|| goto :write_failed
>>"%CLAUDE_MD%" echo(|| goto :write_failed

:append_exception
type "%EXCEPTION_FILE%" >>"%CLAUDE_MD%" || goto :write_failed
echo [CLAUDE.md] exception section appended
goto :launch

:exception_exists
echo [CLAUDE.md] exception section already present, not appended again

:launch
REM Lives only inside this script's setlocal, so other projects are unaffected
set "DISABLE_WRITER_QA_HOOK=1"
cd /d "%PRACTICE_DIR%"
if errorlevel 1 goto :cd_failed
if /i "%LAUNCH_MODE%"=="--no-launch" goto :no_launch
echo [launch] DISABLE_WRITER_QA_HOOK=1 - prefix your prompts with the speed-first block
claude
exit /b %errorlevel%

:no_launch
echo [--no-launch] ready, claude not started
exit /b 0

:usage
echo Usage:   fast-start.bat PRACTICE_FOLDER_NAME [--no-launch]
echo Example: fast-start.bat k120-ch02-practice
echo.
echo Practice folders for chapters 1-9 (under %%USERPROFILE%%\workspace):
echo   ch1  k120-ch01-practice
echo   ch2  k120-ch02-practice  (Claude creates worktree k120-ch02-practice-web in 2-3)
echo   ch3  reuse k120-ch02-practice-web
echo   ch4  k120-ch04-practice
echo   ch5  k120-ch05-practice  (git clone the sample first, then run this)
echo   ch6  k120-ch06-practice  (git clone the sample first, then run this)
echo   ch7  k120-ch07-practice  (use --no-launch, then open it in Claude Code Desktop)
echo   ch8  k120-ch08-practice-chat / -prd / -sub / -grill
echo   ch9  k120-ch09-practice
echo Details: teaching\FAST-RUN.md
exit /b 1

:bad_name
echo ERROR: give a folder name only, no path or drive: %PRACTICE_NAME%
exit /b 1

:no_git
echo ERROR: git not found. Run: winget install --id Git.Git -e  then open a new cmd window.
pause
exit /b 1

:no_claude
echo ERROR: claude not found. Install Claude Code (book section 1-2), then open a new cmd window.
pause
exit /b 1

:no_exception_file
echo ERROR: missing %EXCEPTION_FILE%
exit /b 1

:mkdir_failed
echo ERROR: cannot create folder %PRACTICE_DIR%
exit /b 1

:git_init_failed
echo ERROR: git init failed in %PRACTICE_DIR%
exit /b 1

:write_failed
echo ERROR: cannot write %CLAUDE_MD%
exit /b 1

:cd_failed
echo ERROR: cannot change directory to %PRACTICE_DIR%
exit /b 1
