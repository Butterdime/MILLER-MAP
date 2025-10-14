#!/usr/bin/env bash
# Usage: ./set_github_secrets.sh
# Requires: GitHub CLI (gh) v2+, authenticated with repo scope

REPO="Butterdime/MILLER-MAP"

# List of secrets to set: SECRET_NAME=VALUE or read from local .env
declare -A SECRETS=(
  [GH_PAT]="$GH_PAT"
  [DOCKERHUB_USERNAME]="$DOCKERHUB_USERNAME"
  [DOCKERHUB_TOKEN]="$DOCKERHUB_TOKEN"
  [FIREBASE_TOKEN]="$FIREBASE_TOKEN"
  [SSH_PRIVATE_KEY]="$SSH_PRIVATE_KEY"
  [GOOGLE_CLOUD_KEY]="$GOOGLE_CLOUD_KEY"
)

echo "Provisioning secrets into $REPO…"
for NAME in "\${!SECRETS[@]}"; do
  VALUE="\${SECRETS[\$NAME]}"
  if [[ -z "\$VALUE" ]]; then
    echo "Error: \$NAME is not set in the environment" >&2
    exit 1
  fi
  echo -n "Setting \$NAME… "
  gh secret set "\$NAME" --repo "\$REPO" --body "\$VALUE" && echo "OK"
done

echo "All secrets provisioned successfully."
