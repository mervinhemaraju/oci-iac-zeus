
# Create budget alerts for forecasted spend
resource "oci_budget_alert_rule" "forecast_minimum" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 1
  threshold_type = "ABSOLUTE"
  type           = "FORECAST"

  display_name = "forecast-minimum-threshold"
  message      = <<EOF
  Minimum forecast alert for the minimal spend budget has been trigerred. 
  You will soon exceed the budgeted amount of 1 USD in the OCI Zeus Account.
  Please take action ASAP.
  EOF
  recipients   = local.values.alerts.main_email_recipient

  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}

resource "oci_budget_alert_rule" "forecast_critical" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 3
  threshold_type = "ABSOLUTE"
  type           = "FORECAST"

  display_name = "forecast-critical-threshold"
  message      = <<EOF
  Critical forecast alert for the minimal spend budget has been trigerred. 
  You will soon deplete the whole budgeted amount of 3 USD in the OCI Zeus Account.
  Please take action ASAP.
  EOF
  recipients   = local.values.alerts.main_email_recipient

  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}
