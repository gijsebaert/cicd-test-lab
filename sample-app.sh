#!/bin/bash
set -euo pipefail

mkdir tempdir1
mkdir tempdir1/templates
mkdir tempdir1/static

cp sample_app.py tempdir1/.
cp -r templates/* tempdir1/templates/.
cp -r static/* tempdir1/static/.

cat > tempdir1/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
