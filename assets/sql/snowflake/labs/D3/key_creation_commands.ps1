# Verify in home directory
pwd

# Create a keys directory to store our key pair and navigate into it
mkdir keys; cd keys

# Generate a 2048-bit RSA private key and convert it to PKCS8 format — the format Snowflake expects
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8 -nocrypt

# Derive the corresponding public key from the private key
openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub

# Verify both key files have been created
ls

# Create the project folder & move the private key into the project folder
mkdir "../Snowpipe Streaming Python SDK Demo"; mv rsa_key.p8 "../Snowpipe Streaming Python SDK Demo"; cd "../Snowpipe Streaming Python SDK Demo"

# Output the public key content to the terminal — copy this to register against your Snowflake user
cat ../keys/rsa_key.pub