import pytest
from opegit.database.connection import DatabaseConnection


def pytest_configure() -> None:
    DatabaseConnection.initialize()

@pytest.fixture(autouse=True)
def clean_database():

    pool = DatabaseConnection.get_pool()

    with pool.connection() as conn:
        with conn.cursor() as cur:

            cur.execute(
                """
                truncate table
                    git_element_manifest_entry,
                    git_element_manifest,
                    git_blob_chunk_pool
                cascade;
                """
            )

        conn.commit()

    yield