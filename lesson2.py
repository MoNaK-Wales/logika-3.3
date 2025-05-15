import sqlite3

sqlite_connection = sqlite3.connect(r'C:\Users\User\Desktop\пайтон\sqlite 3 module\lesson2\lesson2.db')
cursor = sqlite_connection.cursor()


sum_sellings = "SELECT SUM(orders.quantity * products.price) FROM orders JOIN products ON orders.product_id = products.product_id"
orders_count = """
    SELECT customers.first_name, customers.last_name, COUNT(orders.order_id) AS order_count
    FROM customers JOIN orders ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_id
"""
average = "SELECT AVG(orders.quantity * products.price) FROM orders JOIN products ON orders.product_id = products.product_id"
categories_count = """
    SELECT products.category, COUNT(orders.order_id)
    FROM orders JOIN products ON orders.product_id = products.product_id
    GROUP BY products.category
"""
products_count = "SELECT category, COUNT(category) FROM products GROUP BY category"
update_price = 'UPDATE products SET price = price * 1.1 WHERE category = "Phones"'


def print_rows(rows):
    text = ""
    for row in rows:
        for i in range(len(row)):
            text += f"{row[i]:<20} "
        print(text)
        text = ""


while True:
    print("\n\nВведіть номер функції, яку ви хочете виконати:")
    print("1. Сумарний обсяг продажів")
    print("2. Кількість замовлень на кожного клієнта")
    print("3. Середній чек замовлення")
    print("4. Кількість замовлень по категоріях")
    print("5. Кількість товарів у кожній категорії")
    print("6. Збільшити ціни на смартфони на 10%")
    print("9. Вийти")
    choice = input("Ваш вибір: ")
    print("\n\n")

    match choice:
        case "1":
            cursor.execute(sum_sellings)
            print(cursor.fetchone()[0])
        case "2":
            cursor.execute(orders_count)
            print_rows(cursor.fetchall())
        case "3":
            cursor.execute(average)
            print(cursor.fetchone()[0])
        case "4":
            cursor.execute(categories_count)
            print_rows(cursor.fetchall())
        case "5":
            cursor.execute(products_count)
            print_rows(cursor.fetchall())
        case "6":
            cursor.execute(update_price)
            print("Ціни на смартфони оновлено")
        case "9":
            break
        case _:
            print("Невірний вибір, спробуйте ще раз")

if input("Зберегти зміни? (y/n): ") == "y":
    sqlite_connection.commit()
else:
    sqlite_connection.rollback()
sqlite_connection.close()
