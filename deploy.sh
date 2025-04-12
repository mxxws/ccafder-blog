#!/bin/bash

# 添加所有更改
git add .

# 提交更改（自动生成时间戳）
commit_message="Auto Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_message"

# 推送到远程仓库的 main 分支
git push origin main

echo "✅ 自动部署完成！"