require 'faker'

# skip validation of locales
I18n.enforce_available_locales = false

module FakedCSV
    class Fakerer
        attr_reader :type
        def initialize(type)
            @type = type
            faker, class_name, @method = @type.split ':'
            begin
                @class = Kernel.const_get("Faker::#{_camelize class_name}")
            rescue
                raise "unsupported faker class: #{class_name}"
            end
        end

        def fake
            begin
                @class.send @method
            rescue
                raise "unsupported faker method: #{@method}"
            end
        end

        def _camelize(str)
            str.split('_').map {|w| w.capitalize}.join
        end
    end
end