#!/bin/bash
set -euo pipefail

JSON="{
    \"properties\": {
        \"deliveryPolicy\": {
            \"description\": \"\",
            \"rules\": [
                {
                    \"name\": \"lxdrule\",
                    \"order\": 1,
                    \"conditions\": [
                        {
                            \"name\": \"UrlFileName\",
                            \"parameters\": {
                                \"@odata.type\": \"#Microsoft.Azure.Cdn.Models.DeliveryRuleHttpVersionConditionParameters\",
                                \"operator\": \"Equal\",
                                \"negateCondition\": false,
                                \"matchValues\": [
                                    \"ubuntu-vm\"
                                ],
                                \"transforms\": []
                            }
                        }
                    ],
                    \"actions\": [
                        {
                            \"name\": \"ModifyResponseHeader\",
                            \"parameters\": {
                                \"@odata.type\": \"#Microsoft.Azure.Cdn.Models.DeliveryRuleHeaderActionParameters\",
                                \"headerAction\": \"Append\",
                                \"headerName\": \"LXD-Image-Hash\",
                                \"value\": \"${LXD_SHA}\"
                            }
                        },
                        {
                            \"name\": \"ModifyResponseHeader\",
                            \"parameters\": {
                                \"@odata.type\": \"#Microsoft.Azure.Cdn.Models.DeliveryRuleHeaderActionParameters\",
                                \"headerAction\": \"Append\",
                                \"headerName\": \"LXD-Image-URL\",
                                \"value\": \"${LXD_URL}\"
                            }
                        }
                    ]
                }
            ]
        }
    }
}
"

URI="${SECRET_CDN_ENDPOINT_RESOURCE_ID}?api-version=2020-04-15"

az rest --method PATCH --uri "${URI}" --body "${JSON}" --debug
