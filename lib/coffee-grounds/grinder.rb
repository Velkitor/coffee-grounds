module CoffeeGrounds
  class Grinder
    def initialize( rails_app, options = {} )
      @rails = rails_app
      config = @rails.application.config
      @target_dir = ( options[:output_dir] ) ? options[:output_dir] : File.join(@rails.root, "app/assets/javascripts")
    end
    
    def grind
      if !Dir.exists?( @target_dir )
        Dir.mkdir( @target_dir )
      end
      route_hash = Hash.new
      @rails.application.routes.routes.to_a.each do |route|
        if route.name && !route.name.empty?
          route_hash[ route.name.to_s] = route.path.spec.to_s
        end
      end
      save_routes_to_js( @target_dir, route_hash )
    end
    
    private
    def js_route_format_fn
      <<-FN
window.CoffeeGrinder = {
  formatRoute: function( path, ids, format ){
    ids = typeof ids !== 'undefined' ? ids : {};
    format = typeof format !== 'undefined' ? format : '';
    var output = path;
    for(id in ids){
      var re = new RegExp(":" + id, "i");
      output = output.replace(re, ids[id] )
    }
    output = output.replace("(.:format)", '' );
    if( format.length > 0 )
      output += "." + format.replace(/^[.]/,'');
    return output
  },
  requestRoute: function( route, ids, params, fn, format ){
    ids = typeof ids !== 'undefined' ? ids : {};
    params = typeof params !== 'undefined' ? params : {};
    fn = typeof fn !== 'function' ? fn : null;
    format = typeof format !== 'undefined' ? format : '';
    request_format = typeof format !== 'undefined' ? format : null;
    $.get(App.routes[route]( ids, format), params, fn, request_format );
  },
  postRoute: function( route, ids, params, fn, format ){
    ids = typeof ids !== 'undefined' ? ids : {};
    params = typeof params !== 'undefined' ? params : {};
    fn = typeof fn !== 'function' ? fn : null;
    format = typeof format !== 'undefined' ? format : '';
    request_format = typeof format !== 'undefined' ? format : null;
    $.post(App.routes[route]( ids, format), params, fn, request_format );
  }
}
if( typeof window.App == 'undefined' )
  window.App = {};
window.App.request = {};
window.App.post = {};
window.App.routes = {};
      FN
    end
    def build_js_route( route, path )
      return <<-ROUTE
window.App.routes.#{route.to_s}_path = function( ids, format ){
  ids = typeof ids !== 'undefined' ? ids : {};
  format = typeof format !== 'undefined' ? format : '';
  return CoffeeGrinder.formatRoute( "#{path}", ids, format);
}
window.App.request.#{route.to_s}_path = function( ids, params, fn, format ){
  CoffeeGrinder.requestRoute( '#{route.to_s}_path', ids, params, fn, format );
}
window.App.post.#{route.to_s}_path = function( ids, params, fn, format ){
  CoffeeGrinder.postRoute( '#{route.to_s}_path', ids, params, fn, format );
}
      ROUTE
    end
    
    def save_routes_to_js( file_path, route_hash, options = {} )
      File.open("#{file_path}/coffee-grounds.js", 'w+') do |f|
        f.write js_route_format_fn
        route_hash.each do |route, path|
          f.write build_js_route( route, path)
        end
      end
    end
    
  end
end