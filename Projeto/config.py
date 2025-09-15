import json
import os

# Caminho do config.json no mesmo diretório do projeto
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = os.path.join(BASE_DIR, "config.json")

with open(CONFIG_PATH, "r", encoding="utf-8") as f:
    config = json.load(f)

DB_CONFIG = {
    "host": config["DB_HOST"],
    "port": config["DB_PORT"],
    "dbname": config["DB_NAME"],
    "user": config["DB_USER"],
    "password": config["DB_PASS"]
}
