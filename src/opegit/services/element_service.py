from __future__ import annotations

from opegit.repositories.element_repository import (
    ElementRepository,
)


class ElementService:

    @staticmethod
    def create_element(
        container_id: int,
        local_id: int,
    ) -> tuple[int, int]:

        ElementRepository.create_element(
            container_id=container_id,
            local_id=local_id,
        )

        return (
            container_id,
            local_id,
        )