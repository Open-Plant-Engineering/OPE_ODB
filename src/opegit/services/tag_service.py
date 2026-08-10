from __future__ import annotations

from hashlib import sha256

from opegit.repositories.tag_repository import (
    TagRepository,
)


class TagService:

    @staticmethod
    def create_tag(
        target_hash: str,
        tag_name: str,
        tagger_name: str,
        tagger_email: str,
        tag_message: str,
    ) -> str:

        tag_hash = sha256(
            (
                target_hash
                + tag_name
                + tagger_name
                + tagger_email
                + tag_message
            ).encode()
        ).hexdigest()

        return TagRepository.create_tag(
            tag_hash=tag_hash,
            target_hash=target_hash,
            tag_name=tag_name,
            tagger_name=tagger_name,
            tagger_email=tagger_email,
            tag_message=tag_message,
        )

    @staticmethod
    def get_tag(
        tag_name: str,
    ) -> str | None:

        return TagRepository.get_tag(
            tag_name
        )

    @staticmethod
    def delete_tag(
        tag_name: str,
    ) -> None:

        TagRepository.delete_tag(
            tag_name
        )

    @staticmethod
    def list_tags() -> list[tuple[str, str]]:

        return TagRepository.list_tags()
