-- =====================================================
-- ELEMENT INDEXES
-- =====================================================

create index idx_element_type
on element(type_id);

create index idx_element_owner
on element
(
    owner_container_id,
    owner_local_id,
    owner_index
);

-- =====================================================
-- VALUE TABLES
-- =====================================================

create index idx_value_string_attribute
on value_string(attribute_id);

create index idx_value_real_attribute
on value_real(attribute_id);

create index idx_value_integer_attribute
on value_integer(attribute_id);

create index idx_value_logical_attribute
on value_logical(attribute_id);

create index idx_value_word_attribute
on value_word(attribute_id);

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

create index idx_value_unknown_attribute
on value_unknown(attribute_id);

-- =====================================================
-- ARRAY TABLES
-- =====================================================

create index idx_array_string_attribute
on array_string(attribute_id);

create index idx_array_real_attribute
on array_real(attribute_id);

create index idx_array_integer_attribute
on array_integer(attribute_id);

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

create index idx_array_datetime_attribute
on array_datetime(attribute_id);

create index idx_array_unknown_attribute
on array_unknown(attribute_id);

-- =====================================================
-- STRING POOL
-- =====================================================

create unique index idx_string_pool_value
on string_pool(string_value);

create index idx_value_string_node
on value_string(container_id, local_id);

create index idx_value_real_node
on value_real(container_id, local_id);

create index idx_value_integer_node
on value_integer(container_id, local_id);

create index idx_value_logical_node
on value_logical(container_id, local_id);

create index idx_value_word_node
on value_word(container_id, local_id);

create index idx_value_reference_node
on value_reference(container_id, local_id);