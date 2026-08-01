from __future__ import annotations

from opegit.hashing.chunk_hash import ChunkHash
from opegit.repositories.chunk_repository import ChunkRepository


class ChunkService:

    @staticmethod
    def store_string(
        value: str,
    ) -> str:

        chunk_hash = ChunkHash.calculate(
            data_type_id=1,
            value=value,
        )

        return ChunkRepository.get_or_create_chunk(
            chunk_hash=chunk_hash,
            data_type_id=1,
            string_value=value,
        )

    @staticmethod
    def store_integer(
        value: int,
    ) -> str:
    
        chunk_hash = ChunkHash.calculate(
            data_type_id=2,
            value=str(value),
        )
    
        return ChunkRepository.get_or_create_chunk(
            chunk_hash=chunk_hash,
            data_type_id=2,
            integer_value=value,
        )
    
    
    @staticmethod
    def store_boolean(
        value: bool,
    ) -> str:
    
        chunk_hash = ChunkHash.calculate(
            data_type_id=3,
            value=str(value),
        )
    
        return ChunkRepository.get_or_create_chunk(
            chunk_hash=chunk_hash,
            data_type_id=3,
            boolean_value=value,
        )