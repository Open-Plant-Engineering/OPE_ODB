from __future__ import annotations

import os

from dotenv import load_dotenv
from psycopg_pool import ConnectionPool


load_dotenv()


class DatabaseConnection:

    _pool: ConnectionPool | None = None

    @classmethod
    def initialize(cls) -> None:

        if cls._pool is not None:
            return

        connection_string = (
            f"host={os.getenv('OPEGIT_DB_HOST')} "
            f"port={os.getenv('OPEGIT_DB_PORT')} "
            f"dbname={os.getenv('OPEGIT_DB_NAME')} "
            f"user={os.getenv('OPEGIT_DB_USER')} "
            f"password={os.getenv('OPEGIT_DB_PASSWORD')}"
        )

        cls._pool = ConnectionPool(
            conninfo=connection_string,
            min_size=int(os.getenv("OPEGIT_DB_MIN_POOL_SIZE", "1")),
            max_size=int(os.getenv("OPEGIT_DB_MAX_POOL_SIZE", "10"))
        )

    @classmethod
    def get_pool(cls) -> ConnectionPool:

        if cls._pool is None:
            cls.initialize()

        return cls._pool