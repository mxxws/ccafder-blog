@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Hugo 自动化部署脚本 (优化版)
:: 功能：带美观提示的 git 操作流程
:: 编码：UTF-8 with BOM（完美兼容中文）
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

chcp 65001 > nul
setlocal enabledelayedexpansion
title 🛠️ Hugo 部署助手
color 0B

:: 生成时间戳
set "DATE_STAMP=%DATE:/=-%"
set "TIME_STAMP=%TIME::=-%"
set "TIMESTAMP=!DATE_STAMP:~0,10!_!TIME_STAMP:~0,8!"

:: 主流程
echo.
echo =========================================================================
echo               HUGO 自动化部署工具
echo =========================================================================
echo 开始时间：!TIMESTAMP!
echo.

:: 步骤1：添加文件
echo 步骤 1/3  扫描文件变更...
git add . || goto error_handling
echo [√] 检测到 !errorlevel! 个文件变更

:: 步骤2：本地提交
echo 步骤 2/3  生成提交记录...
git commit -m "AutoDeploy: !TIMESTAMP!" || goto error_handling
echo [√] 提交描述：!TIMESTAMP!

:: 步骤3：推送到GitHub
echo 步骤 3/3  同步到云端...
git push origin main || goto error_handling
echo [√] 已推送至 origin/main 分支

:: 成功完成提示
echo.
echo =========================================================================
echo                   所有操作已完成！
echo =========================================================================
echo 按任意键关闭窗口...
pause > nul
exit /b 0

:: 错误处理模块
:error_handling
echo.
echo =========================================================================
echo                     执行过程遇到错误
echo =========================================================================
echo 错误代码：!errorlevel!
echo 可能原因：
echo 1. 无文件变更 (代码1)
echo 2. 网络连接失败 (代码128)
echo 3. 身份验证失败 (代码403)
echo =========================================================================
echo 按任意键查看解决方案建议...
pause > nul
exit /b 1