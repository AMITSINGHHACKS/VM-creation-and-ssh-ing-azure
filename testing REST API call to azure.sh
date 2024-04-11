#to generate a token 
TOKEN=$(curl -X POST -d "grant_type=client_credentials&client_id=$CLIENTID&client_secret=$CLIENTSECRET&resource=https%3A%2F%2Fmanagement.azure.com%2F" https://login.microsoftonline.com/$TENANTID/oauth2/token | jq -r .access_token)



#to get the list of IP address in ur Azure account through API call
curl -X GET "https://management.azure.com/subscriptions/$SUBID/providers/Microsoft.Network/publicIPAddresses?api-version=2023-09-01" -H "Authorization: Bearer $TOKEN" | jq -r '.value[].properties.ipAddress'