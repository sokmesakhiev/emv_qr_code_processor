require "spec_helper"

module EmvQrCodeProcessor
  RSpec.describe Decoder do
    describe "#decode" do
      it "decodes dynamic qr_code payload" do
        qr_code_string = "00020101021252044131153137210116372101160123456789ABCDE6016Banteay Meanchey5913Kuntheas Shop5802KH540510.005303840621201081234567863041FF2"

        data = Decoder.new(qr_code_string).decode

        expect(data).to eq(
          payload_format_indicator: "01",
          point_of_initiation_method: "12",
          merchant_name: "Kuntheas Shop",
          merchant_city: "Banteay Meanchey",
          merchant_category_code: "4131",
          transaction_amount: "10.00",
          transaction_currency: "840",
          "merchant_account_information.union_pay": "37210116372101160123456789ABCDE",
          country_code: "KH",
          crc: "1FF2",
          additional_data_field: {
            bill_number: "12345678"
          }
        )
      end

      it "handles invalid crc" do
        expect {
          Decoder.new("00020101021153038405802KH6304FFFF").decode
        }.to raise_error(Errors::InvalidCRC)
      end
    end
  end
end
