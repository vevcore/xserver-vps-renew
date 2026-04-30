# xserver-vps-renew

通过 GitHub Actions 定时/手动执行 XServer VPS 续期任务。

## 工作流触发方式

工作流文件：`.github/workflows/renew.yml`

- **定时触发**：每天 UTC `02:00`（北京时间 `10:00`）
- **手动触发**：GitHub 仓库 → `Actions` → `XServer VPS Renew` → `Run workflow`

## 必需的 Secrets（GitHub Actions）

在仓库中配置：`Settings` → `Secrets and variables` → `Actions` → `New repository secret`

| Secret 名称 | 必需 | 用途 |
| --- | --- | --- |
| `GHCR_TOKEN` | 是 | 拉取镜像 token |
| `XSERVER_EMAIL` | 是 | 续期登录邮箱 |
| `XSERVER_PASSWORD` | 是 | 续期登录密码 |
| `XSERVER_VPS_ID` | 是 | VPS ID |
| `SING_BOX_CONFIG_JSON` | 否 | sing-box 配置的完整 JSON 内容 |
| `TELEGRAM_BOT_TOKEN` | 否 | Telegram 通知机器人 token |
| `TELEGRAM_CHAT_ID` | 否 | Telegram 通知聊天 ID |
| `LOG_ENC_PASSPHRASE` | 否 | 日志文件的加密口令；未设置则跳过产物生成与上传 |

## 日志产物

当 `LOG_ENC_PASSPHRASE` 已配置时，工作流会把运行日志打包成：

- 文件名：`logs-<ts>.7z`
- `ts` 格式（UTC）：`YYYYMMDDTHHMMSSZ`，例如 `logs-20260429T020000Z.7z`
- 加密方式：7z（隐藏文件名/目录结构）
- 保留策略：`retention-days: 30`（自动过期删除）

### 下载与查看

1) GitHub 仓库 → `Actions` → 进入某次运行 → `Artifacts` 下载 `logs-<ts>`
2) 查看文件列表：

```bash
7z l logs-<ts>.7z -p"$LOG_ENC_PASSPHRASE"
```

3) 解压：

```bash
7z x logs-<ts>.7z -p"$LOG_ENC_PASSPHRASE"
```
