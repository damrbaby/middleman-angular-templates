require "middleman-core"

class AngularTemplates < ::Middleman::Extension
  option :base_dir, nil, 'Base diretory to Angular template partials'

  def after_configuration
    @@base_dir = options.base_dir
  end

  helpers do
    def angular_include_templates(path = '')
      base_dir = Pathname.new(@@base_dir || config.source)
      source_dir = Pathname.new(config.source)
      ''.tap do |html|
        Dir[File.join(base_dir, path, '**/*.{html,erb,slim,haml}')].each do |filename|
          template_name = File.basename(filename, '.*')
          next unless template_name.slice!(0) == '_'
          template_path = Pathname.new(File.join(File.dirname(filename), template_name))
          template_id = template_path.relative_path_from(base_dir)
          html << content_tag(
            :script,
            partial(
              template_path.relative_path_from(source_dir)),
              type: "text/ng-template",
              id: "#{template_id}.html"
          )
        end
      end
    end
  end

end

AngularTemplates.register(:angular_templates)
