<#
ps1�t�@�C�������삵�Ȃ��ꍇ�͕����R�[�h�A���s�R�[�h���������Ă��������B
���{�ꕶ������܂ޏꍇ�A������R�[�h�́uSJIS�v�E���s�R�[�h�́uCRLF�v�ł���K�v������܂��B
ref: https://cyzennt.co.jp/blog/2020/06/27/windows%E3%83%90%E3%83%83%E3%83%81%E3%81%8C%E6%AD%A3%E5%B8%B8%E3%81%AB%E5%8B%95%E4%BD%9C%E3%81%97%E3%81%AA%E3%81%84%E5%A0%B4%E5%90%88%E3%81%AB%E8%A6%8B%E7%9B%B4%E3%81%99%E3%83%9D%E3%82%A4%E3%83%B3/
#>

# �Ǘ��Ҍ����Ŏ��s����Ă��Ȃ���΁A�X�N���v�g���Ǘ��Ҍ����Ŏ��s������
# ref: https://www.cats-insteadof-pc.net/wpdb/index.php/2021/12/31/runas/
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')){
  Start-Process -FilePath PowerShell.exe -ArgumentList "-NoLogo -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
  Exit
}

echo "Windows�̐ݒ���J�n���܂�..."

echo "Windows�t�@�C�A�E�H�[��: ON"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

echo "�G�N�X�v���[���[: �t�@�C�����g���q: �\��"
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "HideFileExt" -Value 0

echo "�G�N�X�v���[���[: �B���t�@�C��: �\��"
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "Hidden" -Value 1

# Pin a folder to quick access
# https://cloud6.net/so/powershell/284167
# https://www.vwnet.jp/Windows/w10/2017020201/Pin2QuickAccess.htm
echo "�N�C�b�N�A�N�Z�X: �z�[���f�B���N�g�����s�����߂��܂���"
$shell = New-Object -ComObject "Shell.Application"
$folder = $shell.Namespace("C:\Users\$env:UserName")
$verb = $folder.self.Verbs() | ? {$_.Name -match "^�N�C�b�N �A�N�Z�X��.+�s������"}
if ($verb) {$verb.DoIt()}

# echo "�G�N�X�v���[���[���ċN�����܂�"
# Stop-Process -Name Explorer -Force

echo "Windows�̐ݒ肪�������܂����B"

echo "�\�t�g�E�F�A�̃C���X�g�[�����J�n���܂�..."

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

echo "�\�t�g�E�F�A�̃C���X�g�[�����������܂����B"

echo "AutoHotkey���X�^�[�g�A�b�v�ɓo�^���܂����B"
New-Item -ItemType SymbolicLink -Path "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" -Name "keysetting.lnk" -Value "C:\Users\$env:UserName\.dotfiles\dotfiles\keysetting.ahk"

echo ".wslconfig���z�[���f�B���N�g���ɃR�s�[���܂����B"
Copy-Item C:\Users\$env:UserName\.dotfiles\dotfiles\.wslconfig C:\Users\$env:UserName\.wslconfig

echo "�Z�b�g�A�b�v����������ɂ�PC���ċN�����Ă��������B"

# �������I����Ă��v�����v�g����Ȃ��悤��pause����
pause
