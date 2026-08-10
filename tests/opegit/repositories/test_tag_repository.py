from opegit.repositories.tag_repository import (
    TagRepository,
)


def test_create_get_delete_tag() -> None:

    tag_hash = "a" * 64
    commit_hash = "b" * 64

    TagRepository.create_tag(
        tag_hash=tag_hash,
        target_hash=commit_hash,
        tag_name="v1.0",
        tagger_name="Test",
        tagger_email="test@test.com",
        tag_message="Version 1.0",
    )

    assert (
        TagRepository.tag_exists(
            "v1.0"
        )
        is True
    )

    assert (
        TagRepository.get_tag(
            "v1.0"
        )
        == commit_hash
    )

    TagRepository.delete_tag(
        "v1.0"
    )

    assert (
        TagRepository.tag_exists(
            "v1.0"
        )
        is False
    )