from flask import Flask, render_template, request
import calendar
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

@app.route('/registry')
def registry():
    return render_template('registry.html')

@app.route('/adoptions')
def adoptions():
    return render_template('adoptions.html')

@app.route('/info')
def info():
    return render_template('info_centre.html')

@app.route('/rats')
def all_rats():
    page = request.args.get("page", 1, type=int)
    per_page = 25
    offset = (page - 1) * per_page

    db = get_db()
    try:
        with db.cursor() as cursor:
            # total count
            cursor.execute("SELECT COUNT(*) AS total FROM rats")
            total = cursor.fetchone()["total"]

            # paginated rats
            cursor.execute("""SELECT
    r.ratID,
    r.rat_name,
    r.image_path,
    u.userID AS owner_id,
    u.user_name AS owner_name
FROM rats r
LEFT JOIN users u ON r.owner_id = u.userID
ORDER BY r.ratID
LIMIT %s OFFSET %s
""", (per_page, offset))
            rats = cursor.fetchall()
    finally:
        db.close()

    total_pages = (total + per_page - 1) // per_page

    return render_template(
        "rats.html",
        rats=rats,
        page=page,
        total_pages=total_pages
    )

@app.route('/items')
def all_items():
    db = get_db()
    try:
        with db.cursor() as cursor:
            # Fetch items including created_on
            cursor.execute("""
                SELECT itemID, item_name, image_path, item_description, created_on
                FROM items
            """)
            items = cursor.fetchall()

            # Fetch ownerships
            cursor.execute("""
                SELECT inv.item_id, u.userID, u.user_name
                FROM inventory inv
                JOIN users u ON inv.user_id = u.userID
            """)
            ownerships = cursor.fetchall()

            # Attach owners
            owners_by_item = {}
            for o in ownerships:
                owners_by_item.setdefault(o['item_id'], []).append({
                    'id': o['userID'],
                    'name': o['user_name']
                })

            for item in items:
                item['owners'] = owners_by_item.get(item['itemID'], [])

            # -----------------------------
            # Group items by year and month
            # -----------------------------
            import calendar
            from collections import defaultdict

            grouped_items = defaultdict(lambda: defaultdict(list))

            for item in items:
                created = item['created_on']
                year = created.year
                month_name = calendar.month_name[created.month]  # 1 → "January", etc.
                grouped_items[year][month_name].append(item)

    finally:
        db.close()

    # Pass grouped_items to template
    return render_template('items.html', grouped_items=grouped_items)


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
            cursor.execute(
                "SELECT userID AS id, user_name AS name FROM users WHERE userID = %s",
                (user_id,)
            )
            user = cursor.fetchone()

            # Get inventory for that user
            cursor.execute("""
                SELECT i.item_name AS name, i.image_path, inv.quantity
                FROM inventory inv
                JOIN items i ON inv.item_id = i.itemID
                WHERE inv.user_id = %s
            """, (user_id,))
            inventory = cursor.fetchall()

            # Get rats owned by this user
            cursor.execute("""
                SELECT ratID, rat_name AS name, image_path
                FROM rats
                WHERE owner_id = %s
                ORDER BY ratID
            """, (user_id,))
            rats = cursor.fetchall()
    finally:
        db.close()

    return render_template(
        'user.html',
        user=user,
        inventory=inventory,
        rats=rats
    )


if __name__ == '__main__':
    app.run(debug=True)
