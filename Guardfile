# frozen_string_literal: true

def extensions
  {
    css: :css, scss: :css, sass: :css,
    js: :js, coffee: :js,
    html: :html,
    png: :png, gif: :gif, jpg: :jpg, jpeg: :jpeg
  }
end

def compiled_exts
  extensions.values.uniq
end

def asset_path(path, type)
  path = path[1]
  "/assets/#{path}.#{type}"
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})

  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }

  rails_view_exts = %w[erb haml slim]

  # file types LiveReload may optimize refresh for
  watch(%r{public/.+\.(#{compiled_exts * "|"})})

  extensions.each do |ext, type|
    watch(%r{
      (?:app|vendor)
      (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
        (?<ext>\.#{ext})) # matching extension (must be first encountered)
      (?:\.\w+|$) # other extensions
    }x) { |m| asset_path(m, type) }
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * "|"})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end
