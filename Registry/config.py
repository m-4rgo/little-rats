import os

class BaseConfig:
    DB_CONFIG = {
        "host": os.environ.get("DB_HOST", "localhost"),
        "user": os.environ.get("DB_USER", "root"),
        "password": os.environ.get("DB_PASSWORD", ""),
        "db": os.environ.get("DB_NAME", "little_rats"),
        "port": int(os.environ.get("DB_PORT", 3306)),
    }

class DevConfig(BaseConfig):
    DEBUG = True

class ProdConfig(BaseConfig):
    DEBUG = False
    TESTING = False




# old config for development (MySQL connection)
# DB_CONFIG = {
#     "host": "localhost",
#     "user": "root",             # local user
#     "password": "",             # blank since no password
#     "db": "little_rats",        # your database name
#     "cursorclass": pymysql.cursors.DictCursor
# }

# def get_db():
#     return pymysql.connect(**DB_CONFIG)


# if __name__ == '__main__':
#     app.run(debug=True)