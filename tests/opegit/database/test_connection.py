from opegit.database.connection import DatabaseConnection


def test_database_connection() -> None:

    pool = DatabaseConnection.get_pool()

    with pool.connection() as conn:
        with conn.cursor() as cur:

            cur.execute("select 1;")

            result = cur.fetchone()

    assert result is not None
    assert result[0] == 1

def test_postgresql_version() -> None:

    pool = DatabaseConnection.get_pool()

    with pool.connection() as conn:
        with conn.cursor() as cur:

            cur.execute("select version();")

            result = cur.fetchone()

    assert result is not None
    assert "PostgreSQL" in result[0]