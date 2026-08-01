from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)

from opegit.services.head_service import (
    HeadService,
)


def test_init_repository() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPOSITORY"
        )
    )

    assert repository_id > 0

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )