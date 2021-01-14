lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/emv_qr_code_processor/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "emv_qr_code_processor"
  spec.version       = EmvQrCodeProcessor::VERSION::STRING
  spec.authors       = ["Sokmesa KHIEV"]
  spec.email         = ["ksokmesa@gmail.com"]
  spec.summary       = %q{EMV QRCode reader and writer}
  spec.description   = %q{Process to generate and read data EMV QRCode }
  spec.homepage      = "https://github.com/sokmesakhiev/emv_qr_code_processor"
  spec.license       = "MIT"
  # include all files required to run
  spec.files         = Dir['{lib}/**/*']
  # put any files in ./bin if you want them auto-installed to path when gem is installed
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  # use add_runtime_dependency where this gem needs a gem in order to function
  # spec.add_runtime_dependency "gem dependency"
  spec.add_dependency "digest-crc", "~> 0.6.3"
end
