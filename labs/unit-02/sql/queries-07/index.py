import psycopg2 as pg
from pprint import pprint

def query(q, cur):
    cur.execute(q)
    return cur.fetchall()


def main():
    try:
        DBNAME = "sakila-pg"
        USER_NAME = "postgres"
        USER_PASWD = "9182"
        conn = pg.connect(
            f" \
            dbname={DBNAME} \
            user={USER_NAME} \
            password={USER_PASWD}"
        )
        cur = conn.cursor()
        print(query("select * from film;", cur))
    except:
        raise
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    main()