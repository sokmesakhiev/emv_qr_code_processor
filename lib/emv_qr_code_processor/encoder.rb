module EmvQrCodeProcessor
  class Encoder
    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def encode
      result = encode_data_objects(payload, Schema)
      result << calculate_crc(result)
      result
    end

    private

    def calculate_crc(data)
      format(Schema::CRC.id, Schema::CRC.calculate(data))
    end

    def encode_data_objects(data, template)
      sorted = data.sort_by { |name, _| find_data_object_type(name, template).id }

      sorted.each_with_object("") do |(name, value), result|
        data_object_type = find_data_object_type(name, template)
        value = encode_data_objects(value, data_object_type) unless data_object_type.primitive?
        result << format(data_object_type.id, value)
      end
    end

    def format(id, value)
      [id, value.length.to_s.rjust(2, "0"), value].join
    end

    def find_data_object_type(name, template)
      template.data_object_types.find { |d| d.name == name }
    end
  end
end
