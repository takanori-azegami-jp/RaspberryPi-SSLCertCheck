# RaspberryPi-SSLCertCheck
RaspberryPi(64bit)のLet's Encryptの期限が10日前になったらメール通知するスクリプト

## 環境
- kernel：Linux ホスト名 5.15.32-v8+ #1538 SMP PREEMPT Thu Mar 31 19:40:39 BST 2022 aarch64 GNU/Linux
- OS：Debian GNU/Linux 11 (bullseye)
- ClamAV：0.103.6/26603/Sat Jul 16 16:57:28 2022

## 設定方法
- ssl_cert_domain.txt
 [FQDN.example.com]を指定する（複数行の指定可）

- sslcert_check.sh
 [通知先メールアドレス]を設定する

```bash
cronはrootで設定しておく(例：デイリーでAM1:00に実行)
$ sudo crontab -e 
00 01 * * * sslcert_check.sh
```

## 参考サイト
- [SSL証明書の有効期限をメールで通知するスクリプト](https://ex1.m-yabe.com/archives/4796)

