@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Hugo 自动化部署脚本 (无乱码美化版)
:: 功能：带颜色提示的 git add/commit/push 操作
:: 编码：UTF-8 with BOM（完美兼容中文）
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ★ 初始化设置 ★
chcp 65001 > nul
setlocal enabledelayedexpansion
title 🚀 Hugo 一键部署工具
color 07

:: ★ 生成时间戳 ★
set "DATE_NOW=%DATE:/=-%"
set "TIME_NOW=%TIME::=-%"
set "TIMESTAMP=!DATE_NOW:~0,10!_!TIME_NOW:~0,8!"

:: ★ 主流程 ★
echo.
echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo  正在执行 Hugo 自动化部署 - 开始时间：!TIMESTAMP!
echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

echo.
echo ▒ 步骤 1/3  扫描文件变更...
git add . || goto error_handling
echo [√] 已成功暂存 !errorlevel! 个文件变更

echo.
echo ▒ 步骤 2/3  提交到本地仓库...
git commit -m "自动提交：!TIMESTAMP!" || goto error_handling
echo [√] 提交描述：自动提交 !TIMESTAMP!

echo.
echo ▒ 步骤 3/3  推送至 GitHub...
git push origin main || goto error_handling
echo [√] 已成功同步到远程仓库

:: ★ 成功退出 ★
echo.
echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo  操作成功！窗口 5 秒后自动关闭...
echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
timeout /t 5 > nul
exit /b 0

:: ★ 错误处理 ★
:error_handling
echo.
echo ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
echo  [×] 错误代码：!errorlevel!
echo  [!] 可能原因：
echo     1. 没有文件需要提交 (错误代码 1)
echo     2. 网络连接失败 (错误代码 128)
echo     3. 权限不足 (错误代码 403)
echo ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
pause
exit /b 1