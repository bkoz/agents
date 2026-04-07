from openai import OpenAI
from google.auth import default
import google.auth.transport.requests

location = "us-central1"  # your region
project_id = "bkozdemb-sandbox"

credentials, _ = default(scopes=["https://www.googleapis.com/auth/cloud-platform"])
credentials.refresh(google.auth.transport.requests.Request())

client = OpenAI(
    base_url=(
        f"https://{location}-aiplatform.googleapis.com/v1/"
        f"projects/{project_id}/locations/{location}/endpoints/openapi"
    ),
    api_key=credentials.token,  # short-lived OAuth token, not an OpenAI key
)

response = client.chat.completions.create(
    model="google/gemini-2.5-flash",  # example; use a model ID Vertex documents for this API
    messages=[{"role": "user", "content": "What is the capital of France?"}],
)

print(response.choices[0].message.content)