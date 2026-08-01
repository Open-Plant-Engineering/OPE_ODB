from opegit.services.element_service import (
    ElementService,
)

from opegit.repositories.element_repository import (
    ElementRepository,
)


def test_create_element() -> None:

    ElementService.create_element(
        container_id=200,
        local_id=1,
    )

    exists = ElementRepository.element_exists(
        container_id=200,
        local_id=1,
    )

    assert exists is True