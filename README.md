# resource-downloader

网站资源下载工具 - 支持批量下载网站图片和视频

## 功能特性

- 🖼️ **图片批量下载** - 自动从网站提取并下载所有图片
- 🎬 **视频批量下载** - 自动从网站提取并下载所有视频
- 🔧 **编码问题解决** - Windows PowerShell中文乱码完整解决方案
- 📦 **Skill完整实现** - 可直接使用的网站资源下载器skill

## 项目结构

```
resource-downloader/
├── README.md                          # 本文件
├── 编码问题解决方案.md               # Windows编码问题完整指南
├── scripts/                           # 工具脚本
│   ├── download_images.ps1            # 图片下载脚本
│   ├── download_videos.ps1            # 视频下载脚本
│   └── setup_encoding.ps1             # 编码设置脚本
└── skills/
    └── website-resource-downloader/   # 网站资源下载器Skill
        ├── SKILL.md                   # Skill定义文档
        └── scripts/
            ├── download-resources.ps1 # 主下载脚本
            └── extract-resources.ps1  # 资源提取脚本
```

## 快速开始

### 方式一：使用Skill（推荐）

查看 [skills/website-resource-downloader/SKILL.md](skills/website-resource-downloader/SKILL.md) 了解如何使用完整的skill。

### 方式二：使用独立脚本

```powershell
# 下载图片
.\scripts\download_images.ps1

# 下载视频
.\scripts\download_videos.ps1
```

## 示例项目

我们已经使用这些工具下载了：

- **sigua.qq.com** - 77张图片 + 4个视频
- **squadmaps.com** - 29张地图缩略图

## 技术栈

- PowerShell 5+
- MCP Browser 工具
- System.Drawing (.NET)

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！