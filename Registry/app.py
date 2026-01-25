from flask import Flask, render_template
import pymysql

app = Flask(__name__)

# MySQL connection
DB_CONFIG = {
    "host": "localhost",
    "user": "root",             # local user
    "password": "",             # blank since no password
    "db": "little_rats",        # your database name
    "cursorclass": pymysql.cursors.DictCursor
}

def get_db():
    return pymysql.connect(**DB_CONFIG)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/circus')
def circus():
    return render_template('rat_circus_2026.html')

@app.route('/items')
def all_items():
    db = get_db()
    try:
        with db.cursor() as cursor:
            # Get all items (INCLUDING image_path)
            cursor.execute("""
                SELECT itemID, item_name, image_path, item_description
                FROM items
            """)
            items = cursor.fetchall()

            # Fetch all ownerships in one query
            cursor.execute("""
                SELECT inv.item_id, u.userID, u.user_name
                FROM inventory inv
                JOIN users u ON inv.user_id = u.userID
            """)
            ownerships = cursor.fetchall()

            # Group owners by itemID
            owners_by_item = {}
            for o in ownerships:
                owners_by_item.setdefault(
                    o['item_id'], []
                ).append({
                    'id': o['userID'],
                    'name': o['user_name']
                })

            # Attach owners to each item
            for item in items:
                item['owners'] = owners_by_item.get(item['itemID'], [])

    finally:
        db.close()

    return render_template('items.html', items=items)


@app.route('/users')
def all_users():
    db = get_db()
    try:
        with db.cursor() as cursor:
            cursor.execute("SELECT userID AS id, user_name AS name FROM users")
            users = cursor.fetchall()
    finally:
        db.close()
    return render_template('users.html', users=users)

@app.route('/user/<int:user_id>')
def user_inventory(user_id):
    db = get_db()
    try:
        with db.cursor() as cursor:
            # Get user info
            cursor.execute("SELECT userID AS id, user_name AS name FROM users WHERE userID = %s", (user_id,))
            user = cursor.fetchone()

            # Get inventory for that user
            cursor.execute("""
    SELECT i.item_name AS name, i.image_path, inv.quantity
    FROM inventory inv
    JOIN items i ON inv.item_id = i.itemID
    WHERE inv.user_id = %s
""", (user_id,))

            inventory = cursor.fetchall()
    finally:
        db.close()
    return render_template('user.html', user=user, inventory=inventory)


if __name__ == '__main__':
    app.run(debug=True)
