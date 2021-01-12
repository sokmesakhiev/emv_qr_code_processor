require "spec_helper"

module EmvQrCodeProcessor
  RSpec.describe Encoder do
    describe "#encode" do
      it "encodes emv payload for dynamic qr_code" do

        payload = {
          payload_format_indicator: "01",
          point_of_initiation_method: "12",
          merchant_category_code: "4131",
          "merchant_account_information.union_pay": "37210116372101160123456789ABCDE",
          merchant_city: "Banteay Meanchey",
          merchant_name: "Kuntheas Shop",
          country_code: "KH",
          transaction_amount: "10.00",
          transaction_currency: "840",
          additional_data_field: {
            bill_number: "12345678"
          }
        }

        qr_code_string = Encoder.new(payload).encode

        expect(qr_code_string).to eq("000201010212153137210116372101160123456789ABCDE520441315303840540510.005802KH5913Kuntheas Shop6016Banteay Meanchey62120108123456786304A7A8")
      end
    end
  end
end
