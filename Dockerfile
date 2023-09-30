FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY . /app/app.py /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip==21.3.1
RUN pip install --no-cache-dir -r requirements.txt
RUN exit 1

## Step 4:
# Expose port 80
EXPOSEEE 80ads

## Step 5:
# Run app.py at container launch
CMD ["python", "app.py"]