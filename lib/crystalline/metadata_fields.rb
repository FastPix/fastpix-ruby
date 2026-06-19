# Generated code for FastPix API SDK.

# typed: false
# frozen_string_literal: true

module Crystalline
  module MetadataFields

    class Field
      attr_accessor :name, :type, :metadata

      def initialize(name, type, metadata)
        @name = name
        @type = type
        @metadata = metadata
      end
    end

    module ClassMethods

      def fields
        @__fields__ = [] if @__fields__.nil?

        @__fields__
      end

      def field(field_name, type, metadata = {})
        attr_accessor field_name

        fields << Field.new(field_name, type, metadata)
      end

      def field_augmented?
        true
      end

      def unmarshal_single(field_type, value, format_metadata = nil)
        decoder = format_metadata.fetch(:decoder, nil)

        if field_type.instance_of?(Class) && field_type.include?(::Crystalline::MetadataFields)
          return field_type.from_dict(value)
        elsif field_type.to_s == 'Date'
          return Date.parse(value)
        elsif field_type.to_s == 'DateTime'
          return DateTime.parse(value)
        elsif field_type.to_s == 'Object'
          # rubocop:disable Lint/SuppressedException
          begin
            value = JSON.parse(value)
          rescue TypeError, JSON::ParserError
          end
          # rubocop:enable Lint/SuppressedException
          return value
        elsif field_type.to_s == 'Float'
          return value.to_f

        end
        if decoder.nil?
          value
        else
          decoder.call(value)
        end
      end

      def from_dict(d)
        to_build = {}

        fields.each do |field|
          key = field.name
          format_metadata = field.metadata.fetch(:format_json, {})
          lookup = format_metadata.fetch(:letter_case, nil).call
          value = d[lookup]
          field_type = field.type
          if ::Crystalline::Utils.nilable? field_type
            if value == 'null'
              to_build[key] = nil
              next
            end
            field_type = ::Crystalline::Utils.nilable_of(field_type)
          end
          
          # If field is not nilable, and the value is not in the dict, raise a KeyError
          raise KeyError, "key #{lookup} not found in hash" if value.nil? && !::Crystalline::Utils.nilable?(field.type)
          # If field is nilable, and the value is not in the dict, just move to the next field
          next if value.nil?

          result = unmarshal_field_value(field, field_type, value, format_metadata)
          to_build[key] = result unless result.equal?(UNRESOLVED_UNION)
        end
        new(**to_build)
      end

      # Sentinel returned when a union value cannot be resolved to any member type,
      # so the caller can leave the field unset (instead of assigning nil).
      UNRESOLVED_UNION = Object.new

      # Dispatches unmarshalling of a single field value based on its declared type.
      def unmarshal_field_value(field, field_type, value, format_metadata)
        if Crystalline::Utils.arr? field_type
          inner_type = Crystalline::Utils.arr_of(field_type)
          value.map { |f| unmarshal_single(inner_type, f, format_metadata) }
        elsif Crystalline::Utils.hash? field_type
          val_type = Crystalline::Utils.hash_of(field_type)
          # rubocop:disable Style/HashTransformValues
          value.map { |k, v| [k, unmarshal_single(val_type, v, format_metadata)] }.to_h
          # rubocop:enable Style/HashTransformValues
        elsif Crystalline::Utils.union? field_type
          unmarshal_union(field, field_type, value)
        elsif field_type.instance_of?(Class) && field_type.include?(::Crystalline::MetadataFields)
          Crystalline.unmarshal_json(value, field_type)
        else
          unmarshal_single(field_type, value, format_metadata)
        end
      end

      # Resolves a union-typed value, using a discriminator when present and otherwise
      # trying each candidate type in turn. Returns UNRESOLVED_UNION if none match.
      def unmarshal_union(field, field_type, value)
        discriminator = field.metadata.fetch(:discriminator, nil)
        unless discriminator.nil?
          discriminator_mapping = field.metadata.fetch(:discriminator_mapping, nil)
          discriminator_value = value.fetch(discriminator)
          type_to_deserialize =
            if discriminator_mapping.nil?
              # Fallback: try to match discriminator value against type name
              Crystalline::Utils.get_union_types(field_type).find { |t| t.name.split('::').last == discriminator_value }
            else
              # Use explicit mapping from discriminator value to type
              discriminator_mapping[discriminator_value]
            end
          return Crystalline.unmarshal_json(value, type_to_deserialize)
        end

        union_types = Crystalline::Utils.get_union_types(field_type)
        union_types = union_types.sort_by { |klass| Crystalline.non_nilable_attr_count(klass) }
        union_types.each do |union_type|
          return Crystalline.unmarshal_json(value, union_type)
        rescue TypeError, NoMethodError, KeyError
          next
        end
        UNRESOLVED_UNION
      end
    end

    def initialize
      instance = allocate
      fields.each { |mod| instance.singleton_class.include(mod) }
      instance.send(:initialize)
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def fields
      self.class.fields
    end

    def field(field_name)
      fields.each do |f|
        return f if f.name == field_name
      end
    end

    def marshal_single(field)
      if field.class.include? ::Crystalline::MetadataFields
        field.to_dict
      else
        if ::Crystalline.needs_string_conversion field
          ::Crystalline.json_encode field
        else
          field
        end
      end
    end

    def to_dict
      result = {}
      fields.sort_by(&:name).each do |field|
        format_json_meta = field.metadata[:format_json]
        required = !format_json_meta.nil? && format_json_meta.include?(:required)
        if !format_json_meta.nil? && format_json_meta.include?(:letter_case)
          key = format_json_meta[:letter_case].call(field.name)
        else
          key = field.name
        end

        f = send(field.name)
        next if f.nil? && !required
        result[key] = nil if f.nil? && required

        if f.is_a? Array
          result[key] = f.map { |o| marshal_single(o) }
        elsif f.is_a? Hash
          result[key] = f.map { |k, v| [k, marshal_single(v)] }
        else
          result[key] = marshal_single(f)
        end
      end
      result
    end

    def to_json(*args)
      JSON.generate(to_dict, *args)
    end
  end


end
