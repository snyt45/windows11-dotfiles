# リストア（初期化）手順

**※初期化時、念のため外付けSDD等は外しておく。**

1. `Win + I`で設定を開く > システム > 回復 > このPCをリセット
2. すべて削除する
3. ローカル再インストール
4. 次へ
5. リセット

# セットアップ手順

## 1. Git

Download
```
winget install Git.Git
```

Setting
```
git config --global user.name "global"
git config --global user.email "global@example.com"
```

## 2. Clone

```
git clone https://github.com/snyt45/windows11-dotfiles.git
```

## 3. Setup
`setup.ps1`を右クリックして「PowerShellで実行」

実行後はセットアップを完了させるために必ず**PCを再起動**してください。

## 4. Windowsの設定を行う

<details>
<summary>基本設定の詳細はこちら</summary>

### 壁紙
- `Win + I`で設定を開く > 個人用設定 > テーマ > ダークテーマ

### Google 日本語入力
- サイトからダウンロードすること ※winget経由だとデフォルト設定ができない
- 右下のIMEアイコンを右クリック > プロパティ > 一般
  - スペースの入力
    - 半角

</details>

<details>
<summary>ゲーム設定の詳細はこちら</summary>

### ゲームキャプチャ
- `Win + I`で設定を開く > ゲーム > キャプチャ
  - 発生したことを記録 `ON`
    - 最後を記録する `10分`

</details>

## 5. ソフトウェアの設定を行う

<details>
<summary>通常系のソフトウェアの詳細はこちら</summary>

### Google Chrome
- 規定のアプリに設定
- 各アカウントでサインイン
- ノートPCのみ
  - アプリとしてインストール
    - Roam Research
  - ショートカットとして追加（ウィンドウとして開くにチェック）
    - TaskChute Cloud

### PowerToys
- FancyZones
  - 各ディスプレイごとに`Win + Shift + @`で設定

### Dropbox
- ファイルの同期方法を選択する > ファイルを`ローカル`に設定する
- PCをバックアップしないで続ける

### Zoom
- 設定 > ビデオ
  - ミーティングに参加する際、ビデオをオフにする
- 設定 > オーディオ
  - ミーティングの参加時にマイクをミュートに設定
- 設定 > 背景とエフェクト
  - ぼかしに設定

### Snipaste
- 環境設定 > コントロール > グローバルショートカット
  - 「カスタム切り取り」のショートカットを削除
  - 「切り取り」のショートカットを`Shift + F1`に設定

### Slack
- 各アカウントでサインイン

</details>

<details>
<summary>開発系のソフトウェアの詳細はこちら</summary>

### Visual Studio Code
- 「Get Started with VS Code」 > 「Sync to and from other devices」を選択すると出てくる「Enable Setting Sync」 > 「Sign in & Turn on」 > 「Sign in with GitHub」 > Continue > Visual Studio Codeを開く > Open
  - 設定が同期できたらRestart

</details>

<details>
<summary>ゲーム系のソフトウェアの詳細はこちら</summary>

### Razer BlackShark V2
- Razer BlackShark V2をUSB接続（セットアップが始まる）
- インストールするソフトウェアを選択
  - RAZER SYNAPSE
  - THX SPATIAL AUDIO
- RAZER SYNAPSEを起動
- Googleアカウントでログイン
- 設定が同期される。

</details>

## 6. WSL2の準備、Windows Terminalの設定を行う

<details>
<summary>WSL2のセットアップの詳細はこちら</summary>

- Windows PowerShellを管理者権限で開く。
- `wsl --update`を実行する
- `wsl --install -d Ubuntu-20.04`を実行する。 `wsl --unregister Ubuntu-20.04` & Ubuntu-20.04をアンインストール
- Ubuntu-22.04をMicrosoft Storeからインストール
- Docker Desktopの設定を行う。
  - 設定 > Resources > WSL INTEGRATION > Ubuntuをオン > Apply & Restart
  - WSLで`docker -v`が使えることを確認
- Nerd Fontのインストールを行う。
  ```
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
  cd .\nerd-fonts\
  ./install.ps1 SourceCodePro
  ```
- Windows Terminalの設定を行う。
  - 設定 > 操作(カーソル)
    - 「選択範囲をクリップボードに自動でコピーする」をONにする
  - 設定 > 操作(キーボード)
    - 貼り付けの`Ctrl + V`を削除する ※Vimのキーバインドと被るため
  - プロファイル：規定値
    - 外観
      - テキスト
        - フォントフェイス
          - SauceCodePro Nerd Font
        - フォントサイズ
          - 11
      - 透明度
        - 背景の不透明度を「85%」に設定
  - プロファイル： Ubuntu-22.04
    - 全般
      - 名前
        - 「snyt45」に設定
      - 開始ディレクトリ
        - `\\wsl.localhost\Ubuntu-22.04\home\snyt45`に設定
      - タブタイトル名
        - 「snyt45」に設定
      - 外観
        - カーソルの形を「バー」に設定
    - 詳細設定
      - ベル通知スタイル
        - 音によるチャイム オフ
      - タイトルの変更を表示しない オン
        - タブタイトルを反映させるための設定
  - スタートアップ
    - 既定のプロファイル
      - Windows PowerShell から 「snyt45」にする
  - カラーテーマ設定
    - gruvbox
      - https://windowsterminalthemes.dev/?theme=Gruvbox%20Dark
    - 手順
      1. Gruvbox Darkを選択して「Get theme」してコピー
      2. Windows Terminal > 設定 > JSONファイルを開く > shemesに追加する
        - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fyuta_sano%2FSjYZvSjZLB.png?alt=media&token=107c48b8-f3e6-402c-9281-869a81882e6d)
      3. プロファイル > 規定値 > 外観 > 配色を「Gruvbox Dark」に変更する

</details>

## 7. WSL2のセットアップ

以降のセットアップは https://github.com/snyt45/dockerfiles に従って進行する。
