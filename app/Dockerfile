FROM python:3.9-slim

COPY pyproject.toml ./
RUN apt-get update \
    && apt-get install 'git' -y \
    && pip install poetry==1.1.11 pip==20.1 \
	&& poetry config virtualenvs.create false \
	&& poetry install

COPY src/* ./

ARG GITSHA
ENV GITSHA $GITSHA

EXPOSE 8000

ENTRYPOINT ["uvicorn", "app:app", "--log-level", "debug", "--host", "0.0.0.0", "--port", "8000"]