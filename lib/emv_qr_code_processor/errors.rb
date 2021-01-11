module EmvQrCodeProcessor
  module Errors
    class EMVQRCodeError < StandardError; end
    class InvalidCRC < EMVQRCodeError; end
    class InvalidQRCodePayload < EMVQRCodeError; end
  end
end
