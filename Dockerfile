FROM python:3.9

# build phase
COPY . /app/.

RUN cd org-manager && pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["sh", "-c", "cd org-manager && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"]
