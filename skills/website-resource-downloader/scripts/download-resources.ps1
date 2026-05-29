param(
    [Parameter(Mandatory=$true)]
    [string]$WebsiteUrl,
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = "website_resources",
    [Parameter(Mandatory=$false)]
    [switch]$DownloadImagesOnly,
    [Parameter(Mandatory=$false)]
    [switch]$DownloadVideosOnly
)

# 设置编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"
$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  📥 网站资源下载器" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "目标网站：$WebsiteUrl" -ForegroundColor Yellow
Write-Host ""

# 创建输出目录
$imageDir = Join-Path $OutputDir "images"
$videoDir = Join-Path $OutputDir "videos"
$logDir = Join-Path $OutputDir "logs"

New-Item -ItemType Directory -Force -Path $imageDir | Out-Null
New-Item -ItemType Directory -Force -Path $videoDir | Out-Null
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

$imageUrls = @()
$videoUrls = @()
$successCount = 0
$failCount = 0
$failUrls = @()

function Download-File {
    param(
        [string]$Url,
        [string]$OutputPath
    )
    
    $maxRetries = 3
    $retryCount = 0
    
    while ($retryCount -lt $maxRetries) {
        try {
            Write-Host "  正在下载：$(Split-Path $Url -Leaf)" -ForegroundColor Gray
            
            # 使用 WebClient 下载，支持大文件
            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFile($Url, $OutputPath)
            $webClient.Dispose()
            
            Write-Host "  ✅ 下载成功" -ForegroundColor Green
            return $true
        }
        catch {
            $retryCount++
            if ($retryCount -lt $maxRetries) {
                Write-Host "  ⚠️  下载失败，第 $retryCount 次重试..." -ForegroundColor Yellow
                Start-Sleep -Milliseconds 1000
            }
            else {
                Write-Host "  ❌ 下载失败：$($_.Exception.Message)" -ForegroundColor Red
                return $false
            }
        }
    }
    return $false
}

function Get-FileNameFromUrl {
    param([string]$Url)
    
    $uri = New-Object System.Uri($Url)
    $fileName = Split-Path $uri.LocalPath -Leaf
    
    # 如果没有文件名，生成一个
    if ([string]::IsNullOrEmpty($fileName) -or $fileName -eq "/") {
        $hash = [System.Security.Cryptography.MD5]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Url))
        $fileName = [System.BitConverter]::ToString($hash).Replace("-", "").Substring(0, 16)
        # 尝试从URL中获取扩展名
        if ($Url -match "\.(png|jpg|jpeg|gif|webp|svg|bmp|ico|mp4|webm|avi|mov|mkv|flv)$") {
            $ext = $matches[1]
            $fileName = "$fileName.$ext"
        }
    }
    
    return $fileName
}

function Start-Download {
    param(
        [string[]]$Urls,
        [string]$OutputDir
    )
    
    $localSuccess = 0
    $localFail = 0
    
    for ($i = 0; $i -lt $Urls.Count; $i++) {
        $url = $Urls[$i]
        $fileName = Get-FileNameFromUrl $url
        $outputPath = Join-Path $OutputDir $fileName
        
        # 处理文件名冲突
        $counter = 1
        while (Test-Path $outputPath) {
            $name = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
            $ext = [System.IO.Path]::GetExtension($fileName)
            $outputPath = Join-Path $OutputDir "$name`_$counter$ext"
            $counter++
        }
        
        $percent = [math]::Round(($i + 1) / $Urls.Count * 100, 1)
        Write-Host "[$percent%] 处理 $($i + 1)/$($Urls.Count)：" -ForegroundColor Cyan
        
        if (Download-File -Url $url -OutputPath $outputPath) {
            $localSuccess++
            $script:successCount++
        }
        else {
            $localFail++
            $script:failCount++
            $script:failUrls += $url
        }
    }
    
    return @{ Success = $localSuccess; Fail = $localFail }
}

function Generate-Report {
    $reportPath = Join-Path $logDir "download_report.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    $report = @"
========================================
  网站资源下载报告
========================================

下载时间：$timestamp
目标网站：$WebsiteUrl

下载统计
  图片资源：$($imageUrls.Count) 个
  视频资源：$($videoUrls.Count) 个
  成功下载：$successCount 个
  下载失败：$failCount 个

保存位置
  图片目录：$imageDir
  视频目录：$videoDir

"@
    
    if ($failUrls.Count -gt 0) {
        $report += "`n失败的URL：`n"
        foreach ($url in $failUrls) {
            $report += "  - $url`n"
        }
    }
    
    $report += "`n========================================`n"
    
    $report | Out-File -FilePath $reportPath -Encoding UTF8
    Write-Host "报告已保存到：$reportPath" -ForegroundColor Cyan
}

# 主程序开始
Write-Host "请提供资源URL列表（每行一个URL），输入空行结束：" -ForegroundColor Yellow
Write-Host "(此脚本由 skill 自动调用时会自动填充URL)" -ForegroundColor Gray
Write-Host ""

# 在实际使用中，这里会被skill自动填充URL
# 这里是一个示例
if ($imageUrls.Count -eq 0 -and $videoUrls.Count -eq 0) {
    Write-Host "⚠️  未检测到资源URL，请先使用浏览器工具获取资源列表" -ForegroundColor Yellow
    exit 1
}

# 开始下载
Write-Host ""
Write-Host "开始下载..." -ForegroundColor Cyan

if (-not $DownloadVideosOnly -and $imageUrls.Count -gt 0) {
    Write-Host ""
    Write-Host "🖼️  下载图片 ($($imageUrls.Count) 个)：" -ForegroundColor Yellow
    Start-Download -Urls $imageUrls -OutputDir $imageDir
}

if (-not $DownloadImagesOnly -and $videoUrls.Count -gt 0) {
    Write-Host ""
    Write-Host "🎬  下载视频 ($($videoUrls.Count) 个)：" -ForegroundColor Yellow
    Start-Download -Urls $videoUrls -OutputDir $videoDir
}

# 生成报告
Write-Host ""
Write-Host "生成下载报告..." -ForegroundColor Cyan
Generate-Report

# 输出结果
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  下载完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊  统计：" -ForegroundColor White
Write-Host "  成功下载：$successCount 个" -ForegroundColor Green
Write-Host "  下载失败：$failCount 个" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })
Write-Host ""
Write-Host "📂  保存位置：" -ForegroundColor White
Write-Host "  图片：$imageDir" -ForegroundColor Gray
Write-Host "  视频：$videoDir" -ForegroundColor Gray
Write-Host ""