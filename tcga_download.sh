if [ $# -lt 2 ]; then
  echo "사용법: $0 시작줄번호 끝줄번호"
  exit 1
fi

first=$1
second=$2
for i in $(cat manifest|grep -v filename|cut -f 1 | sed -n "${first},${second}p")
do echo $i
gdc-client download -t /home/junwoojo/token $i
done
