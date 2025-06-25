# grocery_system.py

import tkinter as tk
from tkinter import messagebox, ttk
import mysql.connector
from datetime import datetime

# Database connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="WWQr23117$$",
    database="grocerystore"
)
cursor = conn.cursor()

# Helper Functions

def fetch_units():
    cursor.execute("SELECT unit_id, unit_name FROM Units")
    return dict(cursor.fetchall())

def get_employee(username, password):
    cursor.execute("SELECT * FROM Employees WHERE username=%s AND password=%s", (username, password))
    return cursor.fetchone()

def get_products():
    cursor.execute("SELECT p.product_id, p.name, p.category, p.price, p.stock, u.unit_name FROM Products p JOIN Units u ON p.unit_id = u.unit_id")
    return cursor.fetchall()

def update_stock(product_id, quantity):
    cursor.execute("UPDATE Products SET stock = stock - %s WHERE product_id = %s", (quantity, product_id))
    conn.commit()

def insert_order(customer_id, employee_id, total_amount, order_items):
    cursor.execute("INSERT INTO Orders (customer_id, employee_id, order_date, total_amount) VALUES (%s, %s, %s, %s)",
                   (customer_id, employee_id, datetime.now(), total_amount))
    order_id = cursor.lastrowid
    for item in order_items:
        cursor.execute("INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES (%s, %s, %s, %s)",
                       (order_id, item["product_id"], item["quantity"], item["price"]))
        update_stock(item["product_id"], item["quantity"])
    conn.commit()

# GUI Functions

def login_screen():
    def login():
        user = username_entry.get()
        pwd = password_entry.get()
        employee = get_employee(user, pwd)
        if employee:
            role = employee[2]
            root.destroy()
            if role == 'Administrator':
                admin_dashboard(employee)
            elif role == 'Cashier':
                cashier_dashboard(employee)
            elif role == 'Inventory Manager':
                inventory_dashboard(employee)
        else:
            messagebox.showerror("Error", "Invalid credentials")

    root = tk.Tk()
    root.title("Grocery Store Login")

    tk.Label(root, text="Username:").pack()
    username_entry = tk.Entry(root)
    username_entry.pack()

    tk.Label(root, text="Password:").pack()
    password_entry = tk.Entry(root, show="*")
    password_entry.pack()

    tk.Button(root, text="Login", command=login).pack()
    root.mainloop()

def admin_dashboard(employee):
    dash = tk.Tk()
    dash.title("Admin Dashboard")

    def view_reports():
        cursor.execute("SELECT p.name, SUM(od.quantity) AS total_sold FROM OrderDetails od JOIN Products p ON od.product_id = p.product_id GROUP BY od.product_id ORDER BY total_sold DESC LIMIT 5")
        result = cursor.fetchall()
        report_window = tk.Toplevel(dash)
        report_window.title("Best Selling Products")
        for item in result:
            tk.Label(report_window, text=f"{item[0]} - {item[1]} sold").pack()

    def manage_suppliers():
        supplier_window = tk.Toplevel(dash)
        supplier_window.title("Manage Suppliers")
        tk.Label(supplier_window, text="Supplier Name").pack()
        name_entry = tk.Entry(supplier_window)
        name_entry.pack()
        tk.Label(supplier_window, text="Phone").pack()
        phone_entry = tk.Entry(supplier_window)
        phone_entry.pack()
        tk.Label(supplier_window, text="Email").pack()
        email_entry = tk.Entry(supplier_window)
        email_entry.pack()
        def add_supplier():
            cursor.execute("INSERT INTO Suppliers (name, phone, email) VALUES (%s, %s, %s)",
                           (name_entry.get(), phone_entry.get(), email_entry.get()))
            conn.commit()
            messagebox.showinfo("Success", "Supplier added")
        tk.Button(supplier_window, text="Add Supplier", command=add_supplier).pack()

    tk.Button(dash, text="View Reports", command=view_reports).pack()
    tk.Button(dash, text="Manage Suppliers", command=manage_suppliers).pack()
    dash.mainloop()

def cashier_dashboard(employee):
    dash = tk.Tk()
    dash.title("Cashier Dashboard")
    order_items = []

    tk.Label(dash, text="Customer Name").pack()
    customer_name = tk.Entry(dash)
    customer_name.pack()
    tk.Label(dash, text="Phone").pack()
    customer_phone = tk.Entry(dash)
    customer_phone.pack()

    product_box = ttk.Combobox(dash, state="readonly")
    product_data = get_products()
    product_box['values'] = [f"{p[1]} ({p[5]})" for p in product_data]
    product_box.pack()
    tk.Label(dash, text="Quantity").pack()
    quantity_entry = tk.Entry(dash)
    quantity_entry.pack()

    def add_to_cart():
        i = product_box.current()
        if i == -1:
            return
        product = product_data[i]
        qty = int(quantity_entry.get())
        if qty <= product[4]:
            item = {
                "product_id": product[0],
                "name": product[1],
                "price": float(product[3]),
                "quantity": qty
            }
            order_items.append(item)
            cart.insert('', 'end', values=(item["name"], item["quantity"], item["price"]))
        else:
            messagebox.showerror("Stock Error", "Not enough stock")

    tk.Button(dash, text="Add to Cart", command=add_to_cart).pack()

    cart = ttk.Treeview(dash, columns=("Name", "Qty", "Price"), show='headings')
    cart.heading("Name", text="Product")
    cart.heading("Qty", text="Quantity")
    cart.heading("Price", text="Price")
    cart.pack()

    def checkout():
        total = sum(item["price"] * item["quantity"] for item in order_items)
        cursor.execute("INSERT INTO Customers (name, phone, email) VALUES (%s, %s, %s)",
                       (customer_name.get(), customer_phone.get(), ""))
        conn.commit()
        customer_id = cursor.lastrowid
        insert_order(customer_id, employee[0], total, order_items)
        messagebox.showinfo("Order Complete", f"Total: ₹{total}")
        dash.destroy()

    tk.Button(dash, text="Checkout", command=checkout).pack()
    dash.mainloop()

def inventory_dashboard(employee):
    dash = tk.Tk()
    dash.title("Inventory Manager")
    units = fetch_units()

    tk.Label(dash, text="Product Name").pack()
    name_entry = tk.Entry(dash)
    name_entry.pack()
    tk.Label(dash, text="Category").pack()
    category_entry = tk.Entry(dash)
    category_entry.pack()
    tk.Label(dash, text="Price").pack()
    price_entry = tk.Entry(dash)
    price_entry.pack()
    tk.Label(dash, text="Stock").pack()
    stock_entry = tk.Entry(dash)
    stock_entry.pack()

    tk.Label(dash, text="Unit").pack()
    unit_box = ttk.Combobox(dash, values=list(units.values()), state="readonly")
    unit_box.pack()

    tk.Label(dash, text="Supplier ID").pack()
    supplier_entry = tk.Entry(dash)
    supplier_entry.pack()

    def add_product():
        unit_name = unit_box.get()
        unit_id = list(units.keys())[list(units.values()).index(unit_name)]
        cursor.execute("INSERT INTO Products (name, category, price, stock, supplier_id, unit_id) VALUES (%s, %s, %s, %s, %s, %s)",
                       (name_entry.get(), category_entry.get(), float(price_entry.get()), int(stock_entry.get()), int(supplier_entry.get()), unit_id))
        conn.commit()
        messagebox.showinfo("Success", "Product added")

    tk.Button(dash, text="Add Product", command=add_product).pack()
    dash.mainloop()

# Start the program
login_screen()
