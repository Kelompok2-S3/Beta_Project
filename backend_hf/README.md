---
title: GearGauge API
emoji: 🚗
colorFrom: red
colorTo: gray
sdk: docker
app_port: 7860
---

# GearGauge API

This is the backend API for the GearGauge application, serving car data from a CSV file.

## Endpoints

- `GET /`: Health check.
- `GET /api/cars`: Get a list of cars. Supports pagination (`page`, `limit`) and filtering by brand (`brand`).
- `GET /api/brands`: Get a list of all available car brands.

## Deployment

This space is configured to run with Docker.
