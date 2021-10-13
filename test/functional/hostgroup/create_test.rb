# frozen_string_literal: true
require_relative '../test_helper'

module HammerCLIForemanPuppet
  describe Hostgroup do
    describe CreateCommand do
      it 'allows puppet environment id' do
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['environment_id'] == 1 &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-environment-id 1])
      end

      it 'allows puppet environment name' do
        api_expects(:environments, :index) do |p|
          p[:search] == 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        # FIXME: Called twice because of environment_id being mentioned twice in the docs
        api_expects(:environments, :index) do |p|
          p[:search] == 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['environment_id'] == 1 &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-environment env1])
      end

      it 'allows puppet ca proxy id' do
        api_expects(:hostgroups, :create).with_params({
          hostgroup: {
            name: 'hg1',
            puppet_ca_proxy_id: 1,
          },
        })
        run_cmd(%w[hostgroup create --name hg1 --puppet-ca-proxy-id 1])
      end

      it 'allows puppet ca proxy name' do
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['puppet_ca_proxy_id'] == 1 &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-ca-proxy sp1])
      end

      it 'allows puppet class ids' do
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['puppetclass_ids'] == %w[1 2] &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-class-ids 1,2])
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
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['puppetclass_ids'] == [1, 2] &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-classes pc1,pc2])
      end

      it 'allows puppet class names that exceeds entries_per_page' do
        search_objects = []
        response_objects = []
        ids = []
        names = []
        1100.times.with_object('pc').each do |id, name|
          next_name = "\"#{name}#{id}\""
          search_objects << "name = #{next_name}"
          response_objects << { 'id' => id, 'name' => next_name }
          ids << id
          names << next_name
        end

        api_expects(:puppetclasses, :index) do |p|
          p[:search] == search_objects.join(' or ') &&
            p[:page].to_i == 1 &&
            p[:per_page].to_i == HammerCLIForeman::IdResolver::ALL_PER_PAGE
        end.returns(
          index_response('puppetclasses' => response_objects[0...1000])
        )

        api_expects(:puppetclasses, :index) do |p|
          p[:search] == search_objects.join(' or ') &&
            p[:page].to_i == 2 &&
            p[:per_page].to_i == HammerCLIForeman::IdResolver::ALL_PER_PAGE
        end.returns(index_response('puppetclasses' => response_objects[1000...1100]))

        # FIXME: Called twice because of puppetclass_ids being mentioned twice in the docs
        api_expects(:puppetclasses, :index) do |p|
          p[:search] == search_objects.join(' or ') &&
            p[:page].to_i == 1 &&
            p[:per_page].to_i == HammerCLIForeman::IdResolver::ALL_PER_PAGE
        end.returns(
          index_response('puppetclasses' => response_objects[0...1000])
        )

        api_expects(:puppetclasses, :index) do |p|
          p[:search] == search_objects.join(' or ') &&
            p[:page].to_i == 2 &&
            p[:per_page].to_i == HammerCLIForeman::IdResolver::ALL_PER_PAGE
        end.returns(index_response('puppetclasses' => response_objects[1000...1100]))

        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['name'] == 'hg1' &&
            p['hostgroup']['puppetclass_ids'] == ids
        end

        run_cmd(%w[hostgroup create --name hg1 --puppet-classes] << names.join(',').tr('"', ''))
      end

      it 'allows puppet proxy id' do
        api_expects(:hostgroups, :create).with_params({
          hostgroup: {
            name: 'hg1',
            puppet_proxy_id: 1,
          },
        })
        run_cmd(%w[hostgroup create --name hg1 --puppet-proxy-id 1])
      end

      it 'allows puppet proxy name' do
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hostgroups, :create) do |p|
          p['hostgroup']['puppet_proxy_id'] == 1 &&
            p['hostgroup']['name'] == 'hg1'
        end
        run_cmd(%w[hostgroup create --name hg1 --puppet-proxy sp1])
      end
    end
  end
end
