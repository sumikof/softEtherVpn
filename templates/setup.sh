#!/bin/bash

# 各種設定項目 (値は任意で決める)
export HUBNAME={{ HUBNAME }}
export HUBPASS={{ HUBPASS }}
export USERNAME={{ USERNAME }}
export USERPASS={{ USERPASS }}
export SHAREDKEY={{ SHAREDKEY }}

# 仮想HUB作成
vpncmd localhost /SERVER /CMD HubCreate $HUBNAME \
  /PASSWORD:$HUBPASS && true

# SNAT＆DHCP有効化
vpncmd localhost /SERVER /HUB:$HUBNAME /PASSWORD:$HUBPASS /CMD \
  SecureNatEnable

# ユーザー登録
vpncmd localhost /SERVER /HUB:$HUBNAME /PASSWORD:$HUBPASS /CMD \
  UserCreate $USERNAME \
    /GROUP:none \
      /REALNAME:none \
        /NOTE:none

# ユーザーパスワード設定
vpncmd localhost /SERVER /HUB:$HUBNAME /PASSWORD:$HUBPASS /CMD \
  UserPasswordSet $USERNAME \
    /PASSWORD:$USERPASS

# IPsec VPN有効化
vpncmd localhost /SERVER /CMD \
  IPsecEnable \
    /L2TP:yes \
      /L2TPRAW:no \
        /ETHERIP:yes \
          /PSK:$SHAREDKEY \
            /DEFAULTHUB:$HUBNAME
