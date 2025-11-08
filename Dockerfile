# Use Python 3.11 slim image for smaller size
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install uv for faster dependency installation
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src/ ./src/
COPY README.md openapi.yaml ./

# Install dependencies using uv
RUN uv pip install --system --no-cache -e .

# Set environment variables (can be overridden at runtime)
ENV OBSIDIAN_HOST=host.docker.internal
ENV OBSIDIAN_API_KEY=""

# Run the MCP server
CMD ["mcp-obsidian"]
