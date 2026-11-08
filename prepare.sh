#!/bin/bash

LOG="$HOME/boot-mint.log"

echo "===== $(date) =====" >> "$LOG"

/usr/bin/sudo -n /usr/local/sbin/preparar-boot-mint-root >> "$LOG" 2>&1

if [ "$?" -eq 0 ]; then
    echo "Preparação do próximo boot concluída." >> "$LOG"
else
    echo "ERRO: não foi possível preparar o próximo boot." >> "$LOG"
fi
