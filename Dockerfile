# Use a lightweight base image for production
FROM python:3.12.4-slim

# Set environment variables to prevent interactive installation prompts
ENV PYTHONUNBUFFERED 1
# Uncomment the command below for production
# ENV DJANGO_SETTINGS_MODULE "your_project_name.settings.production"

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files for installing dependencies
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the Django project files into the container
COPY . /app/

# Expose port 8000 for Gunicorn
EXPOSE 8000

# Start Gunicorn to serve the Django app
# Uncomment the command below for production
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project_name.wsgi:application"]
