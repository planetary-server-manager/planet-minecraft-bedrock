#!/bin/bash
cd /server
if $ALLOW_LIST ; then
    if [[ $ALLOW_LIST_MEMBERS ]] ; then
        echo "Populating allowlist..."
        echo "[" > allowlist.json
        MEMBERS_JSON=()
        IFS=';' read -ra MEMBERS <<< "$ALLOW_LIST_MEMBERS"
        for i in "${MEMBERS[@]}"; do
            MEMBER_NAME=$(echo "$i" | grep -oe "^[^,]*")
            MEMBER_XUID=$(echo "$i" | grep -oP '(?<=,)\d.*')
            MEMBER_JSON=$(jq --null-input --arg name "$MEMBER_NAME" --arg xuid "$MEMBER_XUID" '{"ignoresPlayerLimit": false, "name": $name, "xuid": $xuid}')
            echo "$MEMBER_JSON," >> allowlist.json
        done
        truncate -s-2 allowlist.json && echo -e "\n]" >> allowlist.json
        JSON=$(cat allowlist.json | jq)
        echo "$JSON" > allowlist.json
        echo "Done."
    else
        echo "WARNING: Allowlist is enabled, but no members are specified. Update the ALLOW_LIST_MEMBERS environment variable or populate allowlist.json to allow users to join the server."
    fi
else
    echo "Allowlist disabled."
fi
