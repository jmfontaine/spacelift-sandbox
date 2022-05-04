resource "random_uuid" "test1" {
}

resource "random_uuid" "test2" {
}

resource "random_uuid" "test3" {
}

resource "random_uuid" "test4" {
}

resource "random_uuid" "test5" {
}

resource "random_uuid" "test6" {
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "30s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_30_seconds]
}
