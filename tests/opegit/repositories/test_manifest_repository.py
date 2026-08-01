from opegit.repositories.manifest_repository import (
    ManifestRepository,
)


TEST_MANIFEST_HASH = (
    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
)


def test_create_manifest() -> None:

    manifest_id = (
        ManifestRepository.get_or_create_manifest(
            TEST_MANIFEST_HASH
        )
    )

    assert manifest_id > 0


def test_manifest_exists() -> None:

    ManifestRepository.get_or_create_manifest(
        TEST_MANIFEST_HASH
    )

    exists = ManifestRepository.manifest_exists(
        TEST_MANIFEST_HASH
    )

    assert exists is True


def test_get_manifest_id() -> None:

    expected_id = (
        ManifestRepository.get_or_create_manifest(
            TEST_MANIFEST_HASH
        )
    )

    manifest_id = (
        ManifestRepository.get_manifest_id(
            TEST_MANIFEST_HASH
        )
    )

    assert manifest_id == expected_id