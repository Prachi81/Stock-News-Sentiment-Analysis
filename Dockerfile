# Use official Python image
FROM python:3.11-slim-bullseye


# Set working directory
WORKDIR /app

# Copy application files
COPY . .
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
RUN pip install spacy

# Install dependencies
RUN pip install nltk

# Download stopwords
RUN python -m nltk.downloader stopwords 
RUN python -c "import nltk; nltk.download('punkt_tab'); nltk.download('averaged_perceptron_tagger')"

# RUN python -m nltk.downloader stopwords punkt averaged_perceptron_tagger
RUN python -m nltk.downloader stopwords punkt averaged_perceptron_tagger_eng

RUN python -m spacy download en_core_web_sm

RUN pip install --no-cache-dir -r requirements.txt


# Expose Streamlit port
EXPOSE 8501

# Run Streamlit
CMD ["streamlit", "run", "main.py"]
