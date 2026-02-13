FROM python:3.11-slim AS base

LABEL maintainer="Crafty Server Starter"
LABEL description="Auto-hibernate and wake Minecraft servers via Crafty API v2"

# Prevent Python from writing .pyc files and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install PyYAML (only external dependency)
RUN pip install --no-cache-dir pyyaml

# Copy application code
COPY crafty_server_starter/ /app/crafty_server_starter/

# Default config path inside the container
ENV CRAFTY_SERVER_STARTER_CONFIG=/config/config.yaml

# Expose common Minecraft ports (override in docker-compose)
# Users will map their specific ports via -p or docker-compose
EXPOSE 25565

ENTRYPOINT ["python", "-m", "crafty_server_starter"]
CMD ["--config", "/config/config.yaml"]
