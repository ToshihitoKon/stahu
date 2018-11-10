# 音源管理用スクリプト類いろいろ詰め合わせセット

## 構造

- /cue\_flac/: CD1枚分のflacとcueファイル
    - [アーティスト]/: アーティスト毎のディレクトリ
        - [CDタイトル]/: CD単位のディレクトリ
            - [CDタイトル].flac
            - [CDタイトル].cue
            - [CDタイトル].toc
            - cover.jpg
    - queue/: 取り込み直後でcue編集待ちデータ置き場
        - makeflaccue.sh
        - freedb.sed
        - performer.sed
    - .split.sh
    - .split\_single.sh
    - .download\_cover\_img.sh
    - .find\_no\_cover\_img\_dir.sh
    - .update\_metatag.sh
- flac/: 曲単位に分割されたflac
    - [アーティスト]/
        - [CDタイトル]/

## 使い方

### 取り込み

- `/cue_flac/queue`に移動
- `makeflaccue.sh [アルバム名]`で取り込み
- アルバム名のディレクトリが出来上がるので、中のcueファイルを整える
- アルバムのディレクトリを`/cue_flac/queue`から`/cue_flac/[アーティスト名]`に移動させる

### cue/flacを分割

- `cue_flac`に移動
- `.split.sh [アーティスト名]/[アルバム名]`で分割
- `/flac`以下に出来上がり

### メタデータ

- 楽曲情報
    - `/cue_flac`以下のアルバムのディレクトリ中のcueを編集
- アルバムワーク
    - `/cue_flac`に移動
    - `.find_no_cover_img_dir.sh > noimglist`でアルバムワークのないディレクトリをリストアップする
    - listを編集して、アルバムのpathの後ろにカンマ区切りで画像のURLを指定する
    - `.download_cover_img.sh noimglist`で各ディレクトリに画像を入れる
- 更新
    - `.update_metatag.sh [アルバム]`

## 依存

- cdrdao
- flac
- sox
- convert [imagemagick]
- cueconvert [cuetools]
- cuetag.sh [cuetools]

## 謝罪

頭が悪くてごめんなさい、いつか整えます
