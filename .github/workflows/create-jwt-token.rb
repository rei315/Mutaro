require "jwt"

JWT_ISSUER_ID = ARGV[0]
JWT_KEY_ID = ARGV[1]
JWT_PRIVATE_KEY_CODE = ARGV[2]

private_key = OpenSSL::PKey.read(JWT_PRIVATE_KEY_CODE)

token = JWT.encode(
   {
    iss: JWT_ISSUER_ID,
    exp: Time.now.to_i + 20 * 60,
    aud: "appstoreconnect-v1"
   },
   private_key,
   "ES256",
   header_fields={
     kid: JWT_KEY_ID
   }
)

puts token
