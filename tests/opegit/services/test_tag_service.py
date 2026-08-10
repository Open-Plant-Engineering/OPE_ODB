from opegit.services.tag_service import (
    TagService,
)


def test_tag_service() -> None:

    commit_hash = "c" * 64

    TagService.create_tag(
        target_hash=commit_hash,
        tag_name="v1.0",
        tagger_name="Test User",
        tagger_email="test@test.com",
        tag_message="Release Tag",
    )

    assert (
        TagService.get_tag(
            "v1.0"
        )
        == commit_hash
    )

    tags = (
        TagService.list_tags()
    )

    assert len(tags) == 1

    TagService.delete_tag(
        "v1.0"
    )