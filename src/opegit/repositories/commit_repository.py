from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class CommitRepository:

    @staticmethod
    def commit_exists(
        commit_hash: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select commit_exists(%s);
                    """,
                    (commit_hash,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_commit(
        commit_hash: str,
        tree_hash: str,
        author_name: str,
        author_email: str,
        committer_name: str,
        committer_email: str,
        commit_message: str,
        author_date,
        commit_date,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_commit(
                        %s,%s,%s,%s,%s,%s,%s,%s,%s
                    );
                    """,
                    (
                        commit_hash,
                        tree_hash,
                        author_name,
                        author_email,
                        committer_name,
                        committer_email,
                        commit_message,
                        author_date,
                        commit_date,
                    ),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def create_commit_with_parent(
        commit_hash: str,
        parent_hash: str,
        tree_hash: str,
        author_name: str,
        author_email: str,
        committer_name: str,
        committer_email: str,
        commit_message: str,
        author_date,
        commit_date,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_commit_with_parent(
                        %s,%s,%s,%s,%s,%s,%s,%s,%s,%s
                    );
                    """,
                    (
                        commit_hash,
                        parent_hash,
                        tree_hash,
                        author_name,
                        author_email,
                        committer_name,
                        committer_email,
                        commit_message,
                        author_date,
                        commit_date,
                    ),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_commit_tree(
        commit_hash: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_commit_tree(%s);
                    """,
                    (commit_hash,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def get_commit_parent(
        commit_hash: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_commit_parent(%s);
                    """,
                    (commit_hash,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def get_commit_count() -> int:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_commit_count();
                    """
                )

                row = cur.fetchone()

        return row[0]

    @staticmethod
    def get_commit(
        commit_hash: str,
    ) -> tuple | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from get_commit(%s);
                    """,
                    (commit_hash,),
                )

                row = cur.fetchone()

        return row
