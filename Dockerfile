FROM apache/airflow:latest

RUN pip3 install kaggle          


USER root
RUN apt-get update && apt-get install -y mdbtools

USER airflow