param(
    [Parameter(Mandatory=$false)]
    [string]$NetworkLogPath,
    [Parameter(Mandatory=$false)]
    [string]$OutputFile = "resource_urls.json"
)

# 设置编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  📥 资源URL提取器" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$imageExtensions = @(".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg", ".bmp", ".ico")
$videoExtensions = @(".mp4", ".webm", ".avi", ".mov", ".mkv", ".flv")
$imagePatterns = @("/images/", "/assets/", "/static/", "/media/", "/img/", "/pictures/")
$videoPatterns = @("/videos/", "/media/", "/assets/video/")

$imageUrls = @()
$videoUrls = @()

function Test-ImageUrl {
    param([string]$Url)
    
    $lowerUrl = $Url.ToLower()
    
    # 检查扩展名
    foreach ($ext in $imageExtensions) {
        if ($lowerUrl.EndsWith($ext)) {
            return $true
        }
    }
    
    # 检查路径模式
    foreach ($pattern in $imagePatterns) {
        if ($lowerUrl.Contains($pattern)) {
            return $true
        }
    }
    
    return $false
}

function Test-VideoUrl {
    param([string]$Url)
    
    $lowerUrl = $Url.ToLower()
    
    # 检查扩展名
    foreach ($ext in $videoExtensions) {
        if ($lowerUrl.EndsWith($ext)) {
            return $true
        }
    }
    
    # 检查路径模式
    foreach ($pattern in $videoPatterns) {
        if ($lowerUrl.Contains($pattern)) {
            return $true
        }
    }
    
    return $false
}

function Add-Url {
    param(
        [string]$Url,
        [ref]$UrlList
    )
    
    # 处理相对URL
    if ($Url.StartsWith("//")) {
        $Url = "https:" + $Url
    }
    elseif ($Url.StartsWith("/")) {
        # 这里需要基URL，在实际使用时由调用者提供
        Write-Host "  ⚠️  发现相对URL：$Url" -ForegroundColor Yellow
        return
    }
    
    # 去重
    if (-not $UrlList.Value.Contains($Url)) {
        $UrlList.Value += $Url
    }
}

function Process-NetworkRequests {
    param([string]$LogContent)
    
    Write-Host "分析网络请求..." -ForegroundColor Yellow
    
    # 这是一个简化的处理逻辑
    # 在实际使用中，会从 browser_network_requests 的输出中提取URL
    
    $lines = $LogContent -split "`n"
    
    foreach ($line in $lines) {
        if ($line -match "GET (https?://\S+)") {
            $url = $matches[1]
            
            if (Test-ImageUrl $url) {
                Add-Url -Url $url -UrlList ([ref]$imageUrls)
            }
            elseif (Test-VideoUrl $url) {
                Add-Url -Url $url -UrlList ([ref]$videoUrls)
            }
        }
    }
}

function Generate-Output {
    $output = @{
        timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        images = $imageUrls
        videos = $videoUrls
        summary = @{
            imageCount = $imageUrls.Count
            videoCount = $videoUrls.Count
            totalCount = $imageUrls.Count + $videoUrls.Count
        }
    }
    
    $json = $output | ConvertTo-Json -Depth 10
    $json | Out-File -FilePath $OutputFile -Encoding UTF8
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  提取完成！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📊  统计：" -ForegroundColor White
    Write-Host "  🖼️  图片资源：$($imageUrls.Count) 个" -ForegroundColor Green
    Write-Host "  🎬  视频资源：$($videoUrls.Count) 个" -ForegroundColor Green
    Write-Host ""
    Write-Host "📂  输出文件：$OutputFile" -ForegroundColor Gray
    Write-Host ""
}

# 主程序
if ([string]::IsNullOrEmpty($NetworkLogPath)) {
    Write-Host "请提供网络请求日志内容，此脚本通常由skill自动调用" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "使用示例：" -ForegroundColor Gray
    Write-Host "  .\extract-resources.ps1 -NetworkLogPath 'network_log.txt'" -ForegroundColor Gray
    exit 1
}

if (Test-Path $NetworkLogPath) {
    $logContent = Get-Content $NetworkLogPath -Raw -Encoding UTF8
    Process-NetworkRequests -LogContent $logContent
    Generate-Output
}
else {
    Write-Host "❌ 日志文件不存在：$NetworkLogPath" -ForegroundColor Red
    exit 1
}