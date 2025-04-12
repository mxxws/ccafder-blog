@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
title 🛠️ Hugo 部署助手
color 0A

:: 生成标准化的时间戳（YYYY-MM-DD-HH-MM）
for /f "tokens=2 delims==" %%a in ('wmic os get LocalDateTime /value') do set "DateTime=%%a"
set "FormattedDate=!DateTime:~0,4!-!DateTime:~4,2!-!DateTime:~6,2!"
set "FormattedTime=!DateTime:~8,2!-!DateTime:~10,2!"
set "TIMESTAMP=!FormattedDate!-!FormattedTime!"

:: 主流程（隐藏命令执行输出）
echo.
echo ============================================
echo              博客自动化部署工具
echo ============================================
echo 开始时间：!TIMESTAMP!
echo.

:: 步骤 1：暂存文件
echo.
echo [ 正在暂存文件... ]
@git add . >nul 2>&1
if errorlevel 1 (
    echo [❎] 扫描文件变更失败
    goto error_handling
) else (
    echo [✅] 文件已暂存
)

:: 步骤 2：提交更改
echo.
echo [ 正在提交更改... ]
@git commit -m "AutoDeploy: !TIMESTAMP!" >nul 2>&1
if errorlevel 1 (
    echo [❎] 提交记录生成失败
    goto error_handling
) else (
    echo [✅] 提交已完成
)

:: 步骤 3：推送至远程仓库
echo.
echo [ 正在推送至远程仓库... ]
@git push origin main >nul 2>&1
if errorlevel 1 (
    echo [❎] 云端同步失败
    goto error_handling
) else (
    echo [✅] 已推送至 origin/main
)

echo.
echo ============================================
echo              所有操作已完成！
echo ============================================
echo.
echo [ 任务完成，按任意键继续... ]
set /p= <nul  :: 
pause > nul
exit /b 0

:error_handling
echo.
echo ============================================
echo               执行过程遇到错误
echo ============================================
echo 最后操作时间：!TIMESTAMP!
echo 建议排查方向：
echo 1. 检查网络连接状态
echo 2. 验证Git配置有效性
echo 3. 查看详细日志（运行时不加@echo off）
echo.
echo [ 错误发生，按任意键继续... ]
pause
exit /b 1