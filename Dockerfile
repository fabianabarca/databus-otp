# Use Eclipse Temurin Java 21 LTS
FROM eclipse-temurin:21-jre

# Set OTP version
ENV OTP_VERSION=2.5.0

# Install wget and other utilities
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Create directories for OTP
RUN mkdir -p /var/otp/graphs

# Set working directory
WORKDIR /var/otp

# Download OpenTripPlanner
RUN wget --no-check-certificate https://github.com/opentripplanner/OpenTripPlanner/releases/download/v${OTP_VERSION}/otp-${OTP_VERSION}-shaded.jar -O otp.jar

# Expose OTP API port
EXPOSE 8080

# Set default command to run OTP
# Users can mount their data at /var/otp/graphs
CMD ["java", "-Xmx4G", "-jar", "otp.jar", "--load", "/var/otp/graphs", "--serve"]
