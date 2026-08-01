from __future__ import annotations

import hashlib
import json

from opegit.models.manifest import ManifestResult
from opegit.repositories.manifest_repository import ManifestRepository
from opegit.services.chunk_service import ChunkService


class ManifestService:

    ATTRIBUTE_IDS = {
        "NAME": 1,
        "SIZE": 2,
        "ACTIVE": 3,
    }

    @classmethod
    def create_manifest(
        cls,
        attributes: dict,
    ) -> ManifestResult:

        manifest_hash = cls._calculate_manifest_hash(
            attributes
        )

        manifest_id = (
            ManifestRepository.get_or_create_manifest(
                manifest_hash
            )
        )

        for attribute_name, value in attributes.items():

            attribute_id = cls.ATTRIBUTE_IDS[
                attribute_name
            ]

            chunk_hash = cls._store_value(
                value
            )

            ManifestRepository.add_manifest_entry(
                manifest_id=manifest_id,
                attribute_id=attribute_id,
                chunk_hash=chunk_hash,
            )

        return ManifestResult(
            manifest_id=manifest_id,
            manifest_hash=manifest_hash,
        )

    @staticmethod
    def _calculate_manifest_hash(
        attributes: dict,
    ) -> str:

        normalized_json = json.dumps(
            attributes,
            sort_keys=True,
            separators=(",", ":"),
        )

        return hashlib.sha256(
            normalized_json.encode("utf-8")
        ).hexdigest()

    @staticmethod
    def _store_value(
        value,
    ) -> str:

        if isinstance(value, bool):
            return ChunkService.store_boolean(
                value
            )

        if isinstance(value, int):
            return ChunkService.store_integer(
                value
            )

        return ChunkService.store_string(
            str(value)
        )