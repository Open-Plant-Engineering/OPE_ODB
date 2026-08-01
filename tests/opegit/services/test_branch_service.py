from opegit.repositories.repository_repository import RepositoryRepository
from opegit.services.branch_service import BranchService


def test_create_branch() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    BranchService.create_branch(
        repository_id=repository_id,
        branch_name="main",
        commit_hash="a" * 64,
    )

    assert BranchService.branch_exists(
        repository_id=repository_id,
        branch_name="main",
    )


def test_get_branch_head() -> None:
    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    BranchService.create_branch(
        repository_id=repository_id,
        branch_name="develop",
        commit_hash="b" * 64,
    )

    result = BranchService.get_branch_head(
        repository_id=repository_id,
        branch_name="develop",
    )

    assert result == ("b" * 64)


def test_move_branch_head() -> None:
    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )
    
    BranchService.create_branch(
        repository_id=repository_id,
        branch_name="feature",
        commit_hash="c" * 64,
    )

    BranchService.move_branch_head(
        repository_id=repository_id,
        branch_name="feature",
        commit_hash="d" * 64,
    )

    result = BranchService.get_branch_head(
        repository_id=repository_id,
        branch_name="feature",
    )

    assert result == ("d" * 64)


def test_delete_branch() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    BranchService.create_branch(
        repository_id=repository_id,
        branch_name="temp",
        commit_hash="e" * 64,
    )

    BranchService.delete_branch(
        repository_id=repository_id,
        branch_name="temp",
    )

    assert not BranchService.branch_exists(
        repository_id=repository_id,
        branch_name="temp",
    )