from dataclasses import dataclass


@dataclass(slots=True)
class ManifestResult:
    manifest_id: int
    manifest_hash: str