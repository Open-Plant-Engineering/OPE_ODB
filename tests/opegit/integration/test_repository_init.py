from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)

from opegit.services.head_service import (
    HeadService,
)


def test_repository_initialization() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "INTEGRATION_REPO"
        )
    )

    assert repository_id > 0

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )