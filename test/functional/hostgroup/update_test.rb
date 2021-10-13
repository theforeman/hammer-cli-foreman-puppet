# frozen_string_literal: true

require_relative '../test_helper'

module HammerCLIForemanPuppet
  describe Hostgroup do
    describe UpdateCommand do
      it 'allows environment id' do
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['environment_id'] == 1 &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-environment-id 1])
      end

      it 'allows environment name' do
        api_expects(:environments, :index) do |p|
          p[:search] = 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        # FIXME: Called twice because of environment_id being mentioned twice in the docs
        api_expects(:environments, :index) do |p|
          p[:search] = 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['environment_id'] == 1 &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-environment env1])
      end

      it 'allows puppet ca proxy id' do
        api_expects(:hostgroups, :update).with_params({
          id: '1',
          hostgroup: { puppet_ca_proxy_id: 1 },
        })
        run_cmd(%w[hostgroup update --id 1 --puppet-ca-proxy-id 1])
      end

      it 'allows puppet ca proxy name' do
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['puppet_ca_proxy_id'] == 1 &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-ca-proxy sp1])
      end

      it 'allows puppet class ids' do
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['puppetclass_ids'] == %w[1 2] &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-class-ids 1,2])
      end

      it 'allows puppet class names' do
        api_expects(:puppetclasses, :index) do |p|
          p[:search] = 'name = "pc1" or name = "pc2"'
        end.returns(index_response('puppetclasses' => [
                                     { 'id' => 1, 'name' => 'pc1' },
                                     { 'id' => 2, 'name' => 'pc2' },
                                   ]))
        # FIXME: Called twice because of puppetclass_ids being mentioned twice in the docs
        api_expects(:puppetclasses, :index) do |p|
          p[:search] = 'name = "pc1" or name = "pc2"'
        end.returns(index_response('puppetclasses' => [
                                     { 'id' => 1, 'name' => 'pc1' },
                                     { 'id' => 2, 'name' => 'pc2' },
                                   ]))
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['puppetclass_ids'] == [1, 2] &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-classes pc1,pc2])
      end

      it 'allows puppet proxy id' do
        api_expects(:hostgroups, :update).with_params({
          id: '1',
          hostgroup: { puppet_proxy_id: 1 },
        })
        run_cmd(%w[hostgroup update --id 1 --puppet-proxy-id 1])
      end

      it 'allows puppet proxy name' do
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :update) do |p|
          p['hostgroup']['puppet_proxy_id'] == 1 &&
            p['id'] == '1'
        end
        run_cmd(%w[hostgroup update --id 1 --puppet-proxy sp1])
      end
    end
  end
end
