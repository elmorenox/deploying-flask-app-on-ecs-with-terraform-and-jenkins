FROM python:3.7

EXPOSE 8000

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

RUN pip install mysqlclient

RUN pip install gunicorn

CMD ["gunicorn", "--bind", "0.0.0.0", "app:app"]