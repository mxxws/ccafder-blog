@echo off
chcp 65001 > nul  # 强制使用 UTF-8 编码防止中文乱码
SETLOCAL ENABLEEXTENSIONS

:: ---------- 初始化配置 ----------
title Hugo自动部署脚本
color 0A
echo.
echo 🔄 正在启动 Hugo 自动化部署流程...

:: ---------- 主流程 ----------
:main
git add . || goto error
echo ✅ 文件已暂存

git commit -m "AutoDeploy: %date% %time%" || goto error
echo ✅ 提交已完成

git push origin main || goto error
echo ✅ 推送至 GitHub 完成

:: ---------- 成功退出 ----------
echo.
echo 🎉 所有操作已完成！3秒后自动关闭...
timeout /t 3 > nul
exit /b 0

:: ---------- 错误处理 ----------
:error
echo.
echo ❌ 错误：在步骤 [%errorlevel%] 执行失败
echo 建议操作：
echo 1. 检查网络连接
echo 2. 确认Git配置 (git config --global user.name/user.email)
echo 3. 查看详细错误日志
echo.
pause
exit /b 1

:: ---------- 用户中断处理 ----------
:ctrl_c
echo.
echo ⚠️ 检测到用户中断操作 (Ctrl+C)
echo 正在终止进程...
timeout /t 2 > nul
exit /b 2