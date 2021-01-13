# EMV QR Code Processor

[![Gem Version](https://badge.fury.io/rb/emv_qr_code_processor.svg)](https://rubygems.org/gems/emv_qr_code_processor)
[![Build Status](https://github.com/sokmesakhiev/emv_qr_code_processor/workflows/Build%20Gem/badge.svg)](https://github.com/sokmesakhiev/emv_qr_code_processor/actions?query=workflow%3A%22Build+Gem%22)
[![Dependabot](https://img.shields.io/badge/dependabot-enabled-success.svg)](https://dependabot.com)

EMV QR Code Processor is a gem that makes it easy to encode and decode EMV QR Code data.

## Installation

```ruby
gem 'emv_qr_code_processor'
```
And run `bundle install`. After this, check out the guide related to the framework you're using.

## Example
```
   qr_code_string = "00020101021252044131153137210116372101160123456789ABCDE6016Banteay Meanchey5913Kuntheas Shop5802KH540510.005303840621201081234567863041FF2"
   data = EmvQrCodeProcessor::Decoder.new(qr_code_string).decode
```

```
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

    qr_code_string = EmvQrCodeProcessor::Encoder.new(payload).encode
    // 000201010212153137210116372101160123456789ABCDE520441315303840540510.005802KH5913Kuntheas Shop6016Banteay Meanchey62120108123456786304A7A8
```

## License

MIT License.

