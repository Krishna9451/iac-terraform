from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello! Flask application is running on AWS EC2 using Terraform."

@app.route("/health")
def health():
    return "Application is healthy!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)