# Use Eclipse Temurin Java 21 LTS
FROM eclipse-temurin:21-jre

# Set OTP version
ENV OTP_VERSION=2.5.0
ENV JAVA_OPTS="-Xmx4G"

# Install curl for downloading OTP
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Create directories for OTP
RUN mkdir -p /var/otp/graphs

# Set working directory
WORKDIR /var/otp

# Download OpenTripPlanner
# Note: The -k flag is used for compatibility with CI/development environments
# that may have self-signed certificates. In production environments with proper
# SSL certificates, you can remove the -k flag for secure downloads by editing
# this Dockerfile and rebuilding: curl -L -o otp.jar https://github.com/...
RUN curl -kL -o otp.jar \
    https://github.com/opentripplanner/OpenTripPlanner/releases/download/v${OTP_VERSION}/otp-${OTP_VERSION}-shaded.jar

# Expose OTP API port
EXPOSE 8080

# Create entrypoint script to use JAVA_OPTS environment variable
RUN echo '#!/bin/sh\nexec java $JAVA_OPTS -jar otp.jar "$@"' > /var/otp/entrypoint.sh && \
    chmod +x /var/otp/entrypoint.sh

# Set default command to run OTP
# Users can mount their data at /var/otp/graphs
ENTRYPOINT ["/var/otp/entrypoint.sh"]
CMD ["--load", "/var/otp/graphs", "--serve"]
