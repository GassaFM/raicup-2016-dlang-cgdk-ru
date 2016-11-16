@echo off

compile-d.bat

if "%LOCAL_RUNNER_HOME%" == "" (
    :: Change the next line to your local runner's working directory
    :: or pass it via an environmental variable
    set LOCAL_RUNNER_HOME=C:\Some\Path\LocalRunnerRu
)

pushd %LOCAL_RUNNER_HOME%
local-runner.bat
popd
:: sleep 2 (http://stackoverflow.com/a/1672349)
ping -n 3 127.0.0.1 >nul
MyStrategy
