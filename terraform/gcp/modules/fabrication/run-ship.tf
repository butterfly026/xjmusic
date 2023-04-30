# Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

# Serverless operations (Spring Boot Refactoring)
# https://www.pivotaltracker.com/story/show/184580235

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_policy
data "google_iam_policy" "noauth-ship" {
  binding {
    role    = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_policy
resource "google_cloud_run_service_iam_policy" "noauth-ship" {
  location = google_cloud_run_v2_service.ship.location
  project  = google_cloud_run_v2_service.ship.project
  service  = google_cloud_run_v2_service.ship.name

  policy_data = data.google_iam_policy.noauth-ship.policy_data
  depends_on  = [google_project_service.run_api]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service
resource "google_cloud_run_v2_service" "ship" {
  name     = "yard-${local.service_key}-ship"
  location = var.region
  project  = var.project_id
  provider = google-beta

  template {
    scaling {
      min_instance_count = 1
      max_instance_count = 1
    }
    service_account = var.service_account_email
    containers {
      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }
      env {
        name  = "AUDIO_BASE_URL"
        value = var.audio_base_url
      }
      env {
        name  = "AUDIO_FILE_BUCKET"
        value = var.audio_file_bucket
      }
      env {
        name  = "AUDIO_UPLOAD_URL"
        value = var.audio_upload_url
      }
      env {
        name  = "AWS_DEFAULT_REGION"
        value = var.aws_default_region
      }
      env {
        name  = "GCP_REGION"
        value = var.region
      }
      env {
        name  = "GCP_PROJECT_ID"
        value = var.project_id
      }
      env {
        name  = "GCP_SERVICE_ACCOUNT_EMAIL"
        value = var.service_account_email
      }
      env {
        name  = "SHIP_BASE_URL"
        value = var.ship_base_url
      }
      env {
        name  = "SHIP_BUCKET"
        value = var.ship_bucket
      }
      env {
        name  = "STREAM_BASE_URL"
        value = var.stream_base_url
      }
      env {
        name  = "STREAM_BUCKET"
        value = var.stream_bucket
      }
      env {
        name  = "SHIP_KEY"
        value = var.ship_key
      }
      env {
        name = "AWS_ACCESS_KEY_ID"
        value_source {
          secret_key_ref {
            version = "latest"
            secret  = var.secret_id__aws_access_key_id
          }
        }
      }
      env {
        name = "AWS_SECRET_KEY"
        value_source {
          secret_key_ref {
            version = "latest"
            secret  = var.secret_id__aws_secret_key
          }
        }
      }
      image = var.ship_image

      //noinspection HCLUnknownBlockType
      startup_probe {
        initial_delay_seconds = 120
        timeout_seconds       = 2
        period_seconds        = 5
        failure_threshold     = 2
        //noinspection HCLUnknownBlockType
        http_get {
          path = "/healthz"
        }
      }
      //noinspection HCLUnknownBlockType
      liveness_probe {
        timeout_seconds = 2
        //noinspection HCLUnknownBlockType
        http_get {
          path = "/healthz"
        }
      }
      resources {
        cpu_idle = false
        limits   = {
          cpu    = var.ship_resources_limits_cpu
          memory = var.ship_resources_limits_memory
        }
      }
    }
  }

  lifecycle {
    //noinspection HILUnresolvedReference
    ignore_changes = [
      client,
      client_version,
      annotations,
      template[0].annotations,
      template[0].containers[0].image,
    ]
  }

  depends_on = [google_project_service.run_api]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy
resource "google_monitoring_alert_policy" "ship_hls_playlist_ahead_seconds" {
  depends_on   = [google_cloud_run_v2_service.ship]
  enabled      = true
  combiner     = "OR"
  display_name = "[${var.display_name}] HLS Playlist Ahead Seconds"
  conditions {
    display_name = "Not Ahead"
    condition_threshold {
      comparison      = "COMPARISON_LT"
      duration        = "60s"
      filter          = "resource.type = \"cloud_run_revision\" AND metric.type = \"custom.googleapis.com/opencensus/${var.ship_key}_ship_hls_playlist_ahead_seconds\""
      threshold_value = 0.005
      trigger { count = 1 }
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  alert_strategy { auto_close = "1800s" }
  notification_channels = var.notification_channels
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy
resource "google_monitoring_alert_policy" "ship_hls_playlist_shipping" {
  depends_on   = [google_cloud_run_v2_service.ship]
  enabled      = true
  combiner     = "OR"
  display_name = "[${var.display_name}] HLS Playlist Shipping"
  conditions {
    display_name = "No Data"
    condition_absent {
      duration = "300s"
      filter   = "resource.type = \"cloud_run_revision\" AND metric.type = \"custom.googleapis.com/opencensus/${var.ship_key}_ship_hls_playlist_size\""
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }
      trigger { percent = 100 }
    }
  }
  alert_strategy { auto_close = "1800s" }
  notification_channels = var.notification_channels
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy
resource "google_monitoring_alert_policy" "ship_loaded_audio_ahead" {
  depends_on   = [google_cloud_run_v2_service.ship]
  enabled      = true
  combiner     = "OR"
  display_name = "[${var.display_name}] Ship Loaded Audio Ahead"
  conditions {
    display_name = "No Data"
    condition_threshold {
      comparison      = "COMPARISON_LT"
      duration        = "300s"
      filter          = "resource.type = \"cloud_run_revision\" AND metric.type = \"custom.googleapis.com/opencensus/${var.ship_key}_ship_segment_audio_loaded_ahead_seconds\""
      threshold_value = 40
      trigger { count = 1 }
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  alert_strategy { auto_close = "1800s" }
  notification_channels = var.notification_channels
}

