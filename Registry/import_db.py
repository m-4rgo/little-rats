import mysql.connector
import os

# Connect to DB
conn = mysql.connector.connect(
    host=os.environ['DB_HOST'],
    user=os.environ['DB_USER'],
    password=os.environ['DB_PASSWORD'],
    database=os.environ['DB_NAME'],
    port=int(os.environ['DB_PORT'])
)
cursor = conn.cursor()

# Open dump.sql and execute commands
with open("Registry/dump.sql", "r") as f:
    sql_commands = f.read().split(';')  # split on semicolons
    for command in sql_commands:
        command = command.strip()
        if command:
            cursor.execute(command)

conn.commit()
cursor.close()
conn.close()

print("Database import complete.")
