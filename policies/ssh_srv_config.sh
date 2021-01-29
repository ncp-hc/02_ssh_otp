# 대상 서버의 sshd 파일 구성 수정을 위한 script 파일

#!/bin/bash

sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
#systemctl restart sshd --> 구성 확인 후 적용을 위한 주석 처리
