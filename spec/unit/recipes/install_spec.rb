require 'spec_helper'

describe 'xdebug::install' do
  before(:all) {
    @config_path = '/etc/php5/conf.d/xdebug.ini'
  }

  context 'with the default attributes' do
    let(:chef_run) {
      @runner = ChefSpec::Runner.new
      @runner.converge('xdebug::install')
    }

    let(:config_template) {
      chef_run.template(@config_path)
    }

    it 'installs the extension' do
      #expect(chef_run).to execute_command '/usr/sbin/pecl xdebug'
      #expect(chef_run).to install_php_pear(@config_path)
    end

    it 'writes the config file' do
      expect(chef_run).to render_file(@config_path).with_content('zend_extension=xdebug.so')
    end
  end

  context 'with custom directives' do
    let(:chef_run) {
      @profiler_output_dir = '/test_output'

      @runner = ChefSpec::Runner.new
      @runner.node.set['xdebug']['directives'] = {
        :custom_directive => 'custom_value',
        :profiler_output_dir => @profiler_output_dir,
      }
      @runner.converge('xdebug::install')
    }

    it 'writes custom directives in config file' do
      expect(chef_run).to render_file(@config_path).with_content('xdebug.custom_directive="custom_value"')
    end

    it 'handle profiler_output_dir' do
      expect(chef_run).to render_file(@config_path).with_content("xdebug.profiler_output_dir=\"#{@profiler_output_dir}\"")
      expect(chef_run).to create_directory(@profiler_output_dir)
    end
  end
end
