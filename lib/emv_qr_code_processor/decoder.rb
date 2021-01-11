module EmvQrCodeProcessor
  class Decoder
    attr_reader :raw_qr_code

    def initialize(raw_qr_code)
      @raw_qr_code = raw_qr_code
    end

    def decode(validate_crc: true)
      result = decode_data_objects(raw_qr_code, Schema)
      validate_crc(result.fetch(:crc)) if validate_crc

      result
    end

    private

    def decode_data_objects(raw_data, template)
      result = {}

      each_data_object(raw_data) do |data_object_id, value|
        data_object_type = find_data_object_type(data_object_id, template)
        raise Errors::InvalidQRCodePayload if data_object_type.nil?

        value = decode_data_objects(value, data_object_type) unless data_object_type.primitive?
        result[data_object_type.name] = value
      end

      result
    end

    def each_data_object(raw_data)
      scanner = StringScanner.new(raw_data)
      until scanner.eos?
        data_object_id = scanner.scan(/\d{2}/)
        value_length   = scanner.scan(/\d{2}/).to_i
        value          = scanner.scan(/.{#{value_length}}/)

        yield(data_object_id, value)
      end
    end

    def find_data_object_type(id, template)
      template.data_object_types.find { |d| d.id == id }
    end

    def validate_crc(crc)
      payload_without_crc = raw_qr_code[0..-9]
      calculated_crc = Schema::CRC.calculate(payload_without_crc)

      raise Errors::InvalidCRC if calculated_crc != crc
    end
  end
end
