from opegit.services.manifest_service import ManifestService

def test_create_manifest() -> None:

    manifest = ManifestService.create_manifest(
        {
            "NAME": "PIPE-100",
            "SIZE": 250,
            "ACTIVE": True,
        }
    )

    assert manifest.manifest_id > 0
    assert len(manifest.manifest_hash) == 64