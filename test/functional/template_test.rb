# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'test_helper')

describe 'template' do
  describe 'combinations' do
    before do
      @cmd = %w[template combination]
    end

    it 'should create new combination' do
      params = ['create', '--provisioning-template-id=10', '--hostgroup-id=1', '--puppet-environment-id=1']
      expected_result = success_result("Template combination created.\n")
      api_expects(:template_combinations, :create, 'Create template combination') do |p|
        p['provisioning_template_id'] == '10' &&
          p['hostgroup_id'] == '1' &&
          p['environment_id'] == 1 &&
          p['template_combination'] == { 'environment_id' => 1, 'hostgroup_id' => '1' }
      end

      result = run_cmd(@cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'should update combination' do
      params = ['update', '--id=3', '--provisioning-template-id=10', '--hostgroup-id=1', '--puppet-environment-id=1']
      expected_result = success_result("Template combination updated.\n")
      api_expects(:template_combinations, :update, 'Update template combination') do |p|
        p['id'] == '3' &&
          p['provisioning_template_id'] == '10' &&
          p['hostgroup_id'] == '1' &&
          p['environment_id'] == 1 &&
          p['template_combination'] == { 'environment_id' => 1, 'hostgroup_id' => '1' }
      end

      result = run_cmd(@cmd + params)
      assert_cmd(expected_result, result)
    end
  end
end
