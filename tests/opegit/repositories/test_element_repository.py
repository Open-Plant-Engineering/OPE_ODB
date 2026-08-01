from opegit.repositories.element_repository import (
    ElementRepository,
)


def test_create_element() -> None:

    ElementRepository.create_element(
        container_id=100,
        local_id=1,
    )

    exists = ElementRepository.element_exists(
        container_id=100,
        local_id=1,
    )

    assert exists is True


def test_get_element() -> None:

    ElementRepository.create_element(
        container_id=100,
        local_id=2,
    )

    element = ElementRepository.get_element(
        container_id=100,
        local_id=2,
    )

    assert element is not None
    assert element[0] == 100
    assert element[1] == 2


def test_delete_element() -> None:

    ElementRepository.create_element(
        container_id=100,
        local_id=3,
    )

    ElementRepository.delete_element(
        container_id=100,
        local_id=3,
    )

    exists = ElementRepository.element_exists(
        container_id=100,
        local_id=3,
    )

    assert exists is False