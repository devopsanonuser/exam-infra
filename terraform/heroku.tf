#
# CI Environment
#

# Create Heroku apps for ci
resource "heroku_app" "ci" {
  name   = "${var.app_prefix}-app-ci"
  region = "eu"

  config_vars {}
}

# Create a ci database, and configure the app to use it
resource "heroku_addon" "db_ci" {
  app  = "${heroku_app.ci.name}"
  plan = "heroku-postgresql:hobby-dev"
}

# Create a ci hosted graphite, and configure the app to use it
resource "heroku_addon" "hostedgraphite_ci" {
  app  = "${heroku_app.ci.name}"
  plan = "hostedgraphite"
}

#
# Staging Environment
#

# Create Heroku apps for staging
resource "heroku_app" "staging" {
  name   = "${var.app_prefix}-app-staging"
  region = "eu"
}

# Create a staging database, and configure the app to use it
resource "heroku_addon" "db_stage" {
  app  = "${heroku_app.staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}

# Create a staging hosted graphite, and configure the app to use it
resource "heroku_addon" "hostedgraphite_staging" {
  app  = "${heroku_app.staging.name}"
  plan = "hostedgraphite"
}

#
# Production Environment
#

# Create Heroku apps for production
resource "heroku_app" "production" {
  name   = "${var.app_prefix}-app-production"
  region = "eu"
}

# Create a production database, and configure the app to use it
resource "heroku_addon" "db_prod" {
  app  = "${heroku_app.production.name}"
  plan = "heroku-postgresql:hobby-dev"
}

# Create a hosted graphite, and configure the app to use it
resource "heroku_addon" "hostedgraphite_prod" {
  app  = "${heroku_app.production.name}"
  plan = "hostedgraphite"
}

#
# Heroku Pipeline
#

# Create heroku pipeline
resource "heroku_pipeline" "exam-app" {
  name = "${var.pipeline_name}"
}

# Couple apps to different pipeline ci
resource "heroku_pipeline_coupling" "ci" {
  app      = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.exam-app.id}"
  stage    = "development"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.exam-app.id}"
  stage    = "staging"
}

# Couple apps to different pipeline production
resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.exam-app.id}"
  stage    = "production"
}
