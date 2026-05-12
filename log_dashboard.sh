#!/bin/bash

LOG_DIR="/var/log/remote"
LOG_FILE="$LOG_DIR/syslog.log"
REFRESH=5

if [ ! -f "$LOG_FILE" ]; then
    echo "VIGA: $LOG_FILE ei eksisteeri!"
    exit 1
fi

while true; do
    clear

    echo "===================================================="
    echo "        LOGISERVERI DASHBOARD - $(date)"
    echo "===================================================="

    TOTAL=$(wc -l < "$LOG_FILE")
    ERRORS=$(grep -ic "error" "$LOG_FILE")
    WARNINGS=$(grep -ic "warn" "$LOG_FILE")

    echo ""
    echo "STATISTIKA"
    echo "Kokku logisid: $TOTAL"
    echo "Vigu: $ERRORS"
    echo "Hoiatusi: $WARNINGS"

    echo ""
    echo "TOP KLIENDID"
    tail -100 "$LOG_FILE" | awk '{print $4}' | sort | uniq -c | sort -rn | head -5

    echo ""
    echo "VIIMASED VEAD"
    grep -i "error" "$LOG_FILE" | tail -3

    echo ""
    echo "Uuendamine iga ${REFRESH}s | Ctrl+C lõpetab"

    sleep $REFRESH
done