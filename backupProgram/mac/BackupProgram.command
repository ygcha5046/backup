#!/bin/bash

echo "========================================"
echo "      ★ Mac 전체 디스크 백업 프로그램 ★"
echo "========================================"
echo ""

# 백업 진행 여부 확인
read -p "정말로 드라이브 백업을 진행하시겠습니까? (Y/N): " confirm

if [[ "$confirm" != "Y" && "$confirm" != "y" ]]; then
    echo "백업을 취소했습니다. 프로그램을 종료합니다."
    sleep 3
    exit 0
fi

# 연결된 디스크 목록 보기
echo ""
echo "[ 현재 연결된 디스크 목록 ]"
diskutil list
echo ""

# 백업 저장할 외장하드 입력 받기
read -p "백업을 저장할 외장하드 디스크 식별자를 입력하세요 (예: disk2s2): " targetDisk

if [[ -z "$targetDisk" ]]; then
    echo "오류: 외장하드 디스크 식별자를 입력하지 않았습니다."
    sleep 3
    exit 1
fi

# Time Machine 백업 시작
echo ""
echo "[백업을 시작합니다...]"
sudo tmutil setdestination /Volumes/"$targetDisk"

echo ""
echo "[Time Machine 백업을 시작합니다...]"
sudo tmutil startbackup --block --auto

# 백업 완료 메시지
echo ""
echo "[백업이 완료되었습니다. 프로그램을 종료합니다.]"
sleep 3
exit 0
