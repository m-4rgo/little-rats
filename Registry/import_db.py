import os
import subprocess

# Build the MySQL command
cmd = [
    "mysql",
    f"-h{os.environ['DB_HOST']}",
    f"-P{os.environ['DB_PORT']}",
    f"-u{os.environ['DB_USER']}",
    f"-p{os.environ['DB_PASSWORD']}",
    os.environ['DB_NAME']
]

# Run the import
subprocess.run(cmd + ["<", "dump.sql"], shell=True, check=True)
print("Database import complete.")
