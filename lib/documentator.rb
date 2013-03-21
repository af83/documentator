# encoding: utf-8
require 'boson/runner'
require 'pathname'
require 'fileutils'

module Documentator
  class Runner < Boson::Runner
    include FileUtils

    desc "Generate and populate a doc directory"
    def bootstrap
      create_default_dir!
      Dir[bootstrap_path.join("*")].each do |file|
        cp(file, doc_path).tap { puts "✓ #{File.basename(file, File.extname(file))} created!" }
      end
    end

    desc "import a template to doc directory"
    def import(*templates)
      templates.each do |template|
        begin
          unless File.exists?(doc_path)
            puts "You should run `bootstrap` before trying to import documentation"
            exit 1
          end
          cp(templates_path.join("#{template}.md"), doc_path)
          puts "✓ File #{template} copied."
        rescue Errno::ENOENT
          puts "x File #{template} not found."
        end
      end
    end

    desc "List all templates"
    def list
      Dir[templates_path.join("*")].each do |file|
        puts "* #{File.basename(file, File.extname(file))}"
      end
    end

    private

    def create_default_dir!
      mkdir doc_path rescue nil
    end

    def doc_path
      Pathname.new(Dir.pwd).join('doc')
    end

    def bootstrap_path
      Pathname.new(File.expand_path("../", __FILE__)).join "documentator", "bootstrap"
    end

    def templates_path
      Pathname.new(File.expand_path("../", __FILE__)).join "documentator", "templates"
    end
  end
end
