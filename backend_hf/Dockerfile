FROM python:3.9-slim

WORKDIR /app

# Copy requirements first to leverage cache
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create a non-root user for security (good practice for HF)
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

CMD ["python", "app.py"]
