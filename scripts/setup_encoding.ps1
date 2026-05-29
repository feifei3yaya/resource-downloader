$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Windows PowerShell 编码设置脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

try {
    Write-Host "1. 设置控制台输出编码为 UTF-8..." -ForegroundColor Yellow
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    Write-Host "   完成！" -ForegroundColor Green
    
    Write-Host "2. 设置环境变量..." -ForegroundColor Yellow
    $env:LANG = "zh_CN.UTF-8"
    $env:LC_ALL = "zh_CN.UTF-8"
    $env:PYTHONIOENCODING = "utf-8"
    Write-Host "   完成！" -ForegroundColor Green
    
    Write-Host "3. 设置 PowerShell 输出编码..." -ForegroundColor Yellow
    $PSDefaultParameterValues['*:Encoding'] = 'utf8'
    Write-Host "   完成！" -ForegroundColor Green
    
    Write-Host "4. 创建配置文件..." -ForegroundColor Yellow
    $profilePath = $PROFILE
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath -Force | Out-Null
        Write-Host "   创建了新的配置文件: $profilePath" -ForegroundColor Green
    }
    
    $encodingConfig = @"
# PowerShell 编码配置
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
`$env:LANG = "zh_CN.UTF-8"
`$env:LC_ALL = "zh_CN.UTF-8"
`$env:PYTHONIOENCODING = "utf-8"
`$PSDefaultParameterValues['*:Encoding'] = 'utf8'
"@
    
    Add-Content -Path $profilePath -Value $encodingConfig -Encoding UTF8
    Write-Host "   配置已写入: $profilePath" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "编码设置完成！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "提示：重新打开 PowerShell 窗口以应用所有设置" -ForegroundColor Cyan
    
} catch {
    Write-Host "设置过程中出错: $_" -ForegroundColor Red
}