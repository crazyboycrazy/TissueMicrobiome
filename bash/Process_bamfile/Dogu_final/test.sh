#!/bin/bash

# 확인할 도구들의 리스트
tools=("prodigal" "samtools" "megahit" "bbduk.sh" "repair.sh" "bowtie2")

# 도구 실행 가능 여부 확인
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "$tool은(는) 설치되어 있습니다."
    else
        echo "$tool은(는) 설치되어 있지 않습니다."
	exit
    fi
done
