module CoffeeGrounds
  module CoffeeGroundsHelper
    def coffee_grounds_script_tag( options = {} )
      js_namespace = ( options[:namespace] ) ? options[:namespace] : "App"
      <<-JS
      <script type="text/javascript">//<![CDATA[
        (function() {
          $(document).ready(function() {
            var _ref, _ref1, _ref2;
            if ((_ref = #{js_namespace}['#{params[:controller].parameterize}']) != null) {
              if (typeof _ref.init === "function") {
                _ref.init();
              }
            }
            if ((_ref1 = #{js_namespace}['#{params[:controller].parameterize}']) != null) {
              if ((_ref2 = _ref1['#{params[:action].parameterize}']) != null) {
                if (typeof _ref2.init === "function") {
                  _ref2.init();
                }
              }
            }
            return true;
          });

        }).call(this);
      //]]></script>
      JS
    end
  end
end