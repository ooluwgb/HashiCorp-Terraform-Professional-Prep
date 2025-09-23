#############################################################################
###### CHECK BLOCK: VALIDATE TERRAFORM.IO IS REACHABLE
#############################################################################

# Check that https://www.terraform.io is reachable and returns HTTP 200
check "health_check" {
  data "http" "terraform_io" {
    url = "https://www.terraform.io"
  }

  assert {
    condition     = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}
