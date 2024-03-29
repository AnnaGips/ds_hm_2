from faker import Faker
import psycopg2

fake = Faker()

def seed_data():
    conn = None
    try:
        conn = psycopg2.connect("dbname=your_db_name user=your_username password=your_password")
        cur = conn.cursor()
        
        # Seed users
        for _ in range(10):  
            fullname = fake.name()
            email = fake.email()
            cur.execute("INSERT INTO users (fullname, email) VALUES (%s, %s)", (fullname, email))
        
        # Seed statuses
        statuses = ['new', 'in progress', 'completed']
        for status in statuses:
            cur.execute("INSERT INTO status (name) VALUES (%s)", (status,))
        
        # Seed tasks
        for _ in range(20):  
            title = fake.sentence()
            description = fake.paragraph()
            status_id = fake.random_int(min=1, max=3)  
            user_id = fake.random_int(min=1, max=10)  
            cur.execute("INSERT INTO tasks (title, description, status_id, user_id) VALUES (%s, %s, %s, %s)", 
                        (title, description, status_id, user_id))
        
        conn.commit()
        print("Data seeding successful.")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    seed_data()
