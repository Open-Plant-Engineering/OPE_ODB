from opegit.database.connection import DatabaseConnection


def pytest_configure() -> None:
    DatabaseConnection.initialize()