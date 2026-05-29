# 设置编码以避免中文乱码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"
$env:PYTHONIOENCODING = "utf-8"
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

$imageUrls = @(
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btit7.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/honour-item-bg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/honour-icon1.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/honour-icon2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/bg1.jpg",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/attestation-tab-bg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/attestation-tab-on.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btit1-1.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/attestation-step.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btn-click-attestation.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/icon-que.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/play-award-line.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia/order-abg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btn-get.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/swiper-button-prev.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/teame-float-bg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/fontlinear1.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/team-subti1.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/team-subti2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btit2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/lottery-item-bg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btn-lottery.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/lbtn-icon1.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/lbtn-icon4.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/lbtn-icon2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/lbtn-icon3.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/task-item-bg.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/btn-task-go.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/bg4-51.jpg",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img51.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img52.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-title-line.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-m-img.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-m-border-on.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-m-border.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/bg4-11.jpg",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img11.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img14.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img13.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img12.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/bg4-21.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img21.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img22.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img211.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img27.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img26.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img24.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img23.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img25.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img29.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img210.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img28.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-tag-icon.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/bg4-43.jpg",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img43.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img44.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img41.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img42.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img45.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/bg4-33.jpg",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img33.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img34.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img31.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img32.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/feature-img/feature-m-img35.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo3.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo3_2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo4.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo5.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo6.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo7.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo8.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo9.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo9_2.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo10.png",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/dia-team-logo11.png"
)

$outputDir = "website_images"
$featureDir = Join-Path $outputDir "feature-img"
$diaDir = Join-Path $outputDir "dia"

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
New-Item -ItemType Directory -Force -Path $featureDir | Out-Null
New-Item -ItemType Directory -Force -Path $diaDir | Out-Null

$successCount = 0
$failCount = 0

Write-Host "开始下载 $($imageUrls.Count) 张图片..." -ForegroundColor Green

foreach ($url in $imageUrls) {
    try {
        $uri = New-Object System.Uri($url)
        $fileName = Split-Path $uri.LocalPath -Leaf
        
        if ($url -match "/feature-img/") {
            $savePath = Join-Path $featureDir $fileName
        }
        elseif ($url -match "/dia/") {
            $savePath = Join-Path $diaDir $fileName
        }
        else {
            $savePath = Join-Path $outputDir $fileName
        }
        
        Write-Host "正在下载: $fileName" -ForegroundColor Cyan
        
        Invoke-WebRequest -Uri $url -OutFile $savePath -UseBasicParsing
        
        Write-Host "下载成功: $fileName" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host "下载失败: $url - $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
}

Write-Host "`n下载完成!" -ForegroundColor Green
Write-Host "成功: $successCount 张" -ForegroundColor Green
Write-Host "失败: $failCount 张" -ForegroundColor Red
Write-Host "图片保存在: $outputDir" -ForegroundColor Yellow