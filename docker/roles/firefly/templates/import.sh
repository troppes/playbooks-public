#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

docker run \
--rm \
-v ${SCRIPT_DIR}/nordigen.json:/import/nordigen.json \
-e FIREFLY_III_ACCESS_TOKEN="{{ ff_ac_token | string }}" \
-e IMPORT_DIR_WHITELIST=/import \
-e FIREFLY_III_URL="{{ ff_interal_url | string }}" \
-e NORDIGEN_ID="{{ ff_nordigen_id | string }}" \
-e NORDIGEN_KEY="{{ ff_nordigen_key | string }}" \
-e WEB_SERVER=false \
--network="traefik" \
fireflyiii/data-importer:latest