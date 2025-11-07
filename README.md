# databus-otp
OpenTripPlanner container

## Overview

This repository provides a Docker container for [OpenTripPlanner (OTP)](https://www.opentripplanner.org/), an open-source platform for multi-modal trip planning. The container exposes OTP's API for requests from different services.

## Features

- **Java 21 LTS**: Uses Eclipse Temurin Java 21 (Long-Term Support release)
- **Latest OTP**: Pre-configured with OpenTripPlanner v2.5.0
- **Easy Deployment**: Simple Docker and Docker Compose setup
- **API Access**: Exposes OTP API on port 8080
- **Flexible Configuration**: Customizable memory settings and data mounting

## Prerequisites

- Docker (version 20.10 or later)
- Docker Compose (version 1.29 or later)

## Quick Start

### Using Docker Compose (Recommended)

1. Clone this repository:
```bash
git clone https://github.com/fabianabarca/databus-otp.git
cd databus-otp
```

2. Create a `data` directory and add your transit data:
```bash
mkdir -p data
# Add your GTFS and OSM files to the data directory
```

3. Build and run the container:
```bash
docker-compose up -d
```

4. Access the OTP API at `http://localhost:8080`

### Using Docker

1. Build the image:
```bash
docker build -t databus-otp .
```

2. Run the container:
```bash
docker run -d -p 8080:8080 -v $(pwd)/data:/var/otp/graphs --name opentripplanner databus-otp
```

## Configuration

### Memory Settings

By default, the JVM is allocated 4GB of memory. You can adjust this by setting the `JAVA_OPTS` environment variable in `docker-compose.yml`:

```yaml
environment:
  - JAVA_OPTS=-Xmx8G  # Allocate 8GB
```

Or when running with Docker:
```bash
docker run -d -p 8080:8080 -e JAVA_OPTS="-Xmx8G" -v $(pwd)/data:/var/otp/graphs databus-otp
```

The `JAVA_OPTS` environment variable allows you to customize JVM options without rebuilding the image.

### Data Directory

Place your transit data files in the `data` directory:
- **GTFS files**: General Transit Feed Specification files (.zip)
- **OSM files**: OpenStreetMap data (.pbf)

The container will automatically load these files when starting.

## API Usage

Once the container is running, you can access the OTP API:

- **API Documentation**: `http://localhost:8080/otp/`
- **Plan a trip**: `http://localhost:8080/otp/routers/default/plan`

Example API request:
```bash
curl "http://localhost:8080/otp/routers/default/plan?fromPlace=37.7749,-122.4194&toPlace=37.8049,-122.2711&time=10:00am&date=2024-01-15&mode=TRANSIT,WALK"
```

## OTP Version

This container uses OpenTripPlanner version 2.5.0. To use a different version, modify the `OTP_VERSION` environment variable in the Dockerfile:

```dockerfile
ENV OTP_VERSION=2.6.0
```

Then rebuild the container.

## Troubleshooting

### Container fails to start
- Check that you have sufficient memory allocated
- Verify that your data files are in the correct format
- Check logs: `docker-compose logs -f` or `docker logs opentripplanner`

### API not responding
- Ensure the container is fully started (can take several minutes with large datasets)
- Verify port 8080 is not already in use
- Check firewall settings

## License

This project is provided as-is for running OpenTripPlanner. Please refer to the [OpenTripPlanner license](https://github.com/opentripplanner/OpenTripPlanner/blob/dev-2.x/LICENSE.txt) for the OTP software itself.

## Resources

- [OpenTripPlanner Documentation](https://docs.opentripplanner.org/)
- [OpenTripPlanner GitHub](https://github.com/opentripplanner/OpenTripPlanner)
- [Eclipse Temurin Java](https://adoptium.net/)
