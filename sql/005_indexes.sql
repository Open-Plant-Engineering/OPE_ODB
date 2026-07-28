-- =====================================================
-- OPE_ODB
-- Indexes
-- =====================================================

-- =====================================================
-- ELEMENT
-- =====================================================

create index idx_element_type
on element(type_id);

create index idx_element_owner
on element
(
    owner_container_id,
    owner_local_id,
    sequence_no
);

-- =====================================================
-- ATTRIBUTE DEFINITION
-- =====================================================

create unique index idx_attribute_definition_name
on attribute_definition(attribute_name);

-- =====================================================
-- STRING POOL
-- =====================================================

create unique index idx_string_pool_value
on string_pool(string_value);

-- =====================================================
-- VECTOR3 POOL
-- =====================================================

create unique index idx_vector3_pool_xyz
on vector3_pool
(
    x_value,
    y_value,
    z_value
);

-- =====================================================
-- VALUE TABLES
-- =====================================================

create index idx_value_string_attribute
on value_string(attribute_id);

create index idx_value_number_attribute
on value_number(attribute_id);

create index idx_value_logical_attribute
on value_logical(attribute_id);

create index idx_value_reference_attribute
on value_reference(attribute_id);

create index idx_value_reference_target
on value_reference
(
    ref_container_id,
    ref_local_id
);

create index idx_value_position_attribute
on value_position(attribute_id);

create index idx_value_direction_attribute
on value_direction(attribute_id);

create index idx_value_orientation_attribute
on value_orientation(attribute_id);

create index idx_value_datetime_attribute
on value_datetime(attribute_id);

create index idx_value_json_attribute
on value_json(attribute_id);

create index idx_value_blob_attribute
on value_blob(attribute_id);

create index idx_value_uuid_attribute
on value_uuid(attribute_id);

-- =====================================================
-- ARRAY TABLES
-- =====================================================

create index idx_array_string_attribute
on array_string(attribute_id);

create index idx_array_number_attribute
on array_number(attribute_id);

create index idx_array_logical_attribute
on array_logical(attribute_id);

create index idx_array_reference_attribute
on array_reference(attribute_id);

create index idx_array_reference_target
on array_reference
(
    ref_container_id,
    ref_local_id
);

create index idx_array_position_attribute
on array_position(attribute_id);

create index idx_array_direction_attribute
on array_direction(attribute_id);

create index idx_array_orientation_attribute
on array_orientation(attribute_id);

create index idx_array_datetime_attribute
on array_datetime(attribute_id);

create index idx_array_json_attribute
on array_json(attribute_id);

create index idx_array_blob_attribute
on array_blob(attribute_id);

create index idx_array_uuid_attribute
on array_uuid(attribute_id);