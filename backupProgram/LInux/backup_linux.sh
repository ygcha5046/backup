#!/bin/bash

echo "========================================"
echo "      ★ Linux 전체 디스크 백업 프로그램 ★"
echo "========================================"
echo ""

# 루트 권한 확인
if [[ $EUID -ne 0 ]]; then
    echo "이 프로그램은 루트 권한으로 실행해야 합니다."
    exit 1
fi

# 백업 진행 여부 확인
read -p "정말로 전체 디스크 백업을 진행하시겠습니까? (Y/N): " confirm

if [[ "$confirm" != "Y" && "$confirm" != "y" ]]; then
    echo "백업을 취소했습니다. 프로그램을 종료합니다."
    sleep 3
    exit 0
fi

# 현재 연결된 디스크 목록 출력
echo ""
echo "[ 현재 연결된 디스크 목록 ]"
lsblk
echo ""

# 백업할 디스크 선택
read -p "백업할 디스크 이름을 입력하세요 (예: sda): " sourceDisk

if [[ -z "$sourceDisk" ]]; then
    echo "오류: 백업할 디스크를 입력하지 않았습니다."
    sleep 3
    exit 1
fi

# 백업 저장할 디스크(또는 폴더) 선택
read -p "백업 이미지를 저장할 경로를 입력하세요 (예: /mnt/backup/): " backupPath

if [[ -z "$backupPath" ]]; then
    echo "오류: 백업 저장 경로를 입력하지 않았습니다."
    sleep 3
    exit 1
fi

# 백업 파일 이름 입력
backupFile="$backupPath/backup_$(date +%Y%m%d_%H%M%S).img"

# 경고 출력
echo ""
echo "주의: 이 작업은 디스크 전체를 복제하므로 시간이 오래 걸릴 수 있습니다."
echo "백업 대상: /dev/$sourceDisk → 저장 위치: $backupFile"
read -p "진행하시겠습니까? (Y/N): " secondConfirm

if [[ "$secondConfirm" != "Y" && "$secondConfirm" != "y" ]]; then
    echo "백업을 취소했습니다. 프로그램을 종료합니다."
    sleep 3
    exit 0
fi

# dd 백업 시작
echo ""
echo "[백업을 시작합니다...]"
dd if=/dev/"$sourceDisk" of="$backupFile" bs=4M status=progress conv=noerror,sync

# 완료 메시지
echo ""
echo "[백업이 완료되었습니다. 프로그램을 종료합니다.]"
sleep 3
exit 0
