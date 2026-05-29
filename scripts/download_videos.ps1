# 设置编码以避免中文乱码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"
$env:PYTHONIOENCODING = "utf-8"
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

$videoUrls = @(
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/bgm.mp4",
    "https://squad.lv.game.qq.com/dis_kt_dd04d0e7bfed652c707d1f764a8c9048_1779878801/0b53tma5uaab4aabcsixwnvong6d3knqdwqa.f0.mp4",
    "https://game.gtimg.cn/images/squad/cp/a20260407zsxd/bgm2.mp4",
    "https://squad.lv.game.qq.com/dis_kt_f7b6594017790eebebc01269e3cd4703_1779880851/0b53omaogaaa6yadayywzzvoo46d4nzqbyya.f0.mp4"
)

$outputDir = "website_videos"

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$successCount = 0
$failCount = 0

Write-Host "开始下载 $($videoUrls.Count) 个视频..." -ForegroundColor Green

foreach ($url in $videoUrls) {
    try {
        $uri = New-Object System.Uri($url)
        $fileName = Split-Path $uri.LocalPath -Leaf
        $savePath = Join-Path $outputDir $fileName
        
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
Write-Host "成功: $successCount 个" -ForegroundColor Green
Write-Host "失败: $failCount 个" -ForegroundColor Red
Write-Host "视频保存在: $outputDir" -ForegroundColor Yellow