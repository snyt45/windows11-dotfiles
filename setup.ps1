<#
ps1ファイルが動作しない場合は文字コード、改行コードを見直してください。
日本語文字列を含む場合、文字列コードは「SJIS」・改行コードは「CRLF」である必要があります。
ref: https://cyzennt.co.jp/blog/2020/06/27/windows%E3%83%90%E3%83%83%E3%83%81%E3%81%8C%E6%AD%A3%E5%B8%B8%E3%81%AB%E5%8B%95%E4%BD%9C%E3%81%97%E3%81%AA%E3%81%84%E5%A0%B4%E5%90%88%E3%81%AB%E8%A6%8B%E7%9B%B4%E3%81%99%E3%83%9D%E3%82%A4%E3%83%B3/
#>

# 管理者権限で実行されていなければ、スクリプトを管理者権限で実行し直す
# ref: https://www.cats-insteadof-pc.net/wpdb/index.php/2021/12/31/runas/
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')){
  Start-Process -FilePath PowerShell.exe -ArgumentList "-NoLogo -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
  Exit
}

echo "Windowsの設定を開始します..."

echo "Windowsファイアウォール: ON"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

echo "エクスプローラー: ファイル名拡張子: 表示"
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "HideFileExt" -Value 0

echo "エクスプローラー: 隠しファイル: 表示"
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "Hidden" -Value 1

# Pin a folder to quick access
# https://cloud6.net/so/powershell/284167
# https://www.vwnet.jp/Windows/w10/2017020201/Pin2QuickAccess.htm
echo "クイックアクセス: ホームディレクトリをピン留めしました"
$shell = New-Object -ComObject "Shell.Application"
$folder = $shell.Namespace("C:\Users\$env:UserName")
$verb = $folder.self.Verbs() | ? {$_.Name -match "^クイック アクセスに.+ピン留め"}
if ($verb) {$verb.DoIt()}

# echo "エクスプローラーを再起動します"
# Stop-Process -Name Explorer -Force

echo "Windowsの設定が完了しました。"

echo "ソフトウェアのインストールを開始します..."

winget install Google.Chrome
winget install Lexikos.AutoHotkey
winget install Microsoft.PowerToys
winget install Docker.DockerDesktop
winget install Microsoft.VisualStudioCode
winget install TablePlus.TablePlus
winget install Kuro.Mery
winget install flux.flux
winget install snipaste
winget install DeepL.DeepL
winget install Dropbox.Dropbox
winget install SlackTechnologies.Slack
winget install Zoom.Zoom
winget install TheDocumentFoundation.LibreOffice
winget install Microsoft.PCManager

echo "ソフトウェアのインストールが完了しました。"

echo "AutoHotkeyをスタートアップに登録しました。"
New-Item -ItemType SymbolicLink -Path "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" -Name "keysetting.lnk" -Value "C:\Users\$env:UserName\.dotfiles\dotfiles\keysetting.ahk"

echo ".wslconfigをホームディレクトリにコピーしました。"
Copy-Item C:\Users\$env:UserName\.dotfiles\dotfiles\.wslconfig C:\Users\$env:UserName\.wslconfig

echo "セットアップを完了するにはPCを再起動してください。"

# 処理が終わってもプロンプトを閉じないようにpauseする
pause
