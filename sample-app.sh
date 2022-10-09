#!/bin/bash
set -euo pipefail

rmdir tempdirFinal

mkdir tempdirFinal
mkdir tempdirFinal/templates
mkdir tempdirFinal/static

cp sample_app.py tempdirFinal/.
cp -r templates/* tempdirFinal/templates/.
cp -r static/* tempdirFinal/static/.

cat > tempdirFinal/Dockerfile << _EOF_
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
