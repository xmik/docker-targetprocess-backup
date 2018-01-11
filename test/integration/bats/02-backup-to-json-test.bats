load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'
load 'variables'

@test "clean before test" {
  clean_func
}
@test "backup_to_json works" {
  run docker run --name ${cont} -ti \
    --env TEST=true \
    --env TP_DOMAIN="${TP_DOMAIN}" \
    --env TP_USER="${TP_USER}" \
    --env TP_PASSWORD="${TP_PASSWORD}" \
    -v ${volume_data}:/tmp/tp_backup \
    "${this_image_name}:${this_image_tag}" \
    "source /opt/tp_backup/run_functions.sh && mkdir -p \$BACKUP_DIR && verify_credentials && backup_to_json"
  assert_output --partial "Credentials verified"
  assert_output --partial "downloaded features of ids: 2700 to 2800 into /tmp/tp_backup/test/test.json"
  refute_output --partial "not set, please set it"
  assert_output --partial "Errors from the request:  null"
  assert_equal "$status" 0

  run test -f ${volume_data}/test/test.json
  assert_equal "$status" 0

  run cat ${volume_data}/test/test.json
  assert_equal "$status" 0
  assert_output --partial "\"Name\":\"Feature\""
}
@test "clean after test" {
  clean_func
}