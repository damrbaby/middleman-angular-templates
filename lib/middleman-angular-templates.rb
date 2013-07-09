require "middleman-core"

class AngularTemplates < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def angular_include_templates(path = '')
      base_dir = Pathname.new('source')
      ''.tap do |html|
        Dir[File.join(base_dir, path, '**/*.{html,erb,slim,haml}')].each do |filename|
          template_name = File.basename(filename, '.*')
          next unless template_name.slice!(0) == '_'
          template_path = Pathname.new(File.join(File.dirname(filename), template_name)).relative_path_from(base_dir)
          html << content_tag(:script, partial(template_path), type: "text/ng-template", id: "#{template_path}.html")
        end
      end
    end
  end

end

AngularTemplates.register(:angular_templates)
