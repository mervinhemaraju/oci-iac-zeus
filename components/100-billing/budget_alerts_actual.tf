# Create budget alerts for actual spend
resource "oci_budget_alert_rule" "actual_minimum" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "actual-minimum-threshold"
  message      = <<EOF
  Minimum actual alert for the minimal spend budget has been trigerred. 
  You have already spent 1 USD in the OCI Zeus Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = local.values.alerts.main_email_recipient

  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}

resource "oci_budget_alert_rule" "actual_critical" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 3
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "actual-critical-threshold"
  message      = <<EOF
  Critical actual alert for the minimal spend budget has been trigerred. 
  You have already spent all of the 3 USD in the OCI Zeus Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = local.values.alerts.main_email_recipient
  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}
