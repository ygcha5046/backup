@echo off
title Windows 전체 디스크 백업 프로그램
color 0A

:: 프로그램 설명
echo ========================================
echo         ★ 윈도우 전체 백업 프로그램 ★
echo ========================================
echo.

:: 시스템 드라이브 존재 여부 확인
if not exist C:\ (
    echo 오류: 시스템 드라이브(C:)를 찾을 수 없습니다.
    timeout /t 3 > nul
    exit /b
)

:: 백업 진행 여부 확인
set /p confirm=정말로 드라이브 백업을 진행하시겠습니까? (Y/N): 

if /i not "%confirm%"=="Y" (
    echo 백업을 취소했습니다. 프로그램을 종료합니다.
    timeout /t 3 > nul
    exit /b
)

echo.
echo [ 현재 연결된 드라이브 목록 ]
wmic logicaldisk get Caption, VolumeName, Description
echo.

:: 백업할 파티션 선택
set /p backup_drive=백업할 파티션을 입력하세요 (예: C:): 

if "%backup_drive%"=="" (
    echo 오류: 백업할 파티션을 입력하지 않았습니다.
    timeout /t 3 > nul
    exit /b
)

:: 외장하드 드라이브 문자 입력
set /p target_drive=백업을 저장할 외장하드 드라이브 문자를 입력하세요 (예: E:): 

if "%target_drive%"=="" (
    echo 오류: 외장하드 드라이브 문자를 입력하지 않았습니다.
    timeout /t 3 > nul
    exit /b
)

:: 백업 시작
echo.
echo [백업을 시작합니다...]
wbadmin start backup -backupTarget:%target_drive% -include:%backup_drive% -allCritical -quiet

:: 백업 완료 메시지
echo.
echo [백업이 완료되었습니다. 프로그램을 종료합니다.]
timeout /t 3 > nul
exit
