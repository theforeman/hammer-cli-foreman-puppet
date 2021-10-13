require_relative '../test_helper'

module HammerCLIForemanPuppet
  describe Host do
    describe CreateCommand do
      let(:cmd) { %w[host create] }
      let(:minimal_params_without_hostgroup) { %w[--location-id=1 --organization-id=1 --name=hst1] }

      it 'allows puppet environment id' do
        params = %w[--puppet-environment-id=1]
        api_expects(:hosts, :create) do |p|
          p['host']['environment_id'] == 1 &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet environment name' do
        params = %w[--puppet-environment=env1]
        api_expects(:environments, :index) do |p|
          p[:search] == 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        # FIXME: Called twice because of environment_id being mentioned twice in the docs
        api_expects(:environments, :index) do |p|
          p[:search] == 'name = "env1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hosts, :create) do |p|
          p['host']['environment_id'] == 1 &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet ca proxy id' do
        params = %w[--puppet-ca-proxy-id=1]
        api_expects(:hosts, :create).with_params(
          {
            host: {
              name: 'hst1',
              puppet_ca_proxy_id: 1
            }
          }
        )
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet ca proxy name' do
        params = %w[--puppet-ca-proxy=sp1]
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hosts, :create) do |p|
          p['host']['puppet_ca_proxy_id'] == 1 &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet class ids' do
        params = %w[--puppet-class-ids=1,2]
        api_expects(:hosts, :create) do |p|
          p['host']['puppetclass_ids'] == %w[1 2] &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet class names' do
        params = %w[--puppet-classes=pc1,pc2]
        api_expects(:puppetclasses, :index) do |p|
          p[:search] = 'name = "pc1" or name = "pc2"'
        end.returns(index_response('puppetclasses' => [
                                     { 'id' => 1, 'name' => 'pc1' },
                                     { 'id' => 2, 'name' => 'pc2' }
                                   ]))
        # FIXME: Called twice because of puppetclass_ids being mentioned twice in the docs
        api_expects(:puppetclasses, :index) do |p|
          p[:search] = 'name = "pc1" or name = "pc2"'
        end.returns(index_response('puppetclasses' => [
                                     { 'id' => 1, 'name' => 'pc1' },
                                     { 'id' => 2, 'name' => 'pc2' }
                                   ]))
        api_expects(:hosts, :create) do |p|
          p['host']['puppetclass_ids'] == [1, 2] &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
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
        params = ["--puppet-classes=#{names.join(',').tr('"', '')}"]

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

        api_expects(:hosts, :create) do |p|
          p['host']['name'] == 'hst1' &&
            p['host']['puppetclass_ids'] == ids
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet proxy id' do
        params = %w[--puppet-proxy-id=1]
        api_expects(:hosts, :create).with_params(
          {
            host: {
              name: 'hst1',
              puppet_proxy_id: 1
            }
          }
        )
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end

      it 'allows puppet proxy name' do
        params = %w[--puppet-proxy=sp1]
        api_expects(:smart_proxies, :index) do |p|
          p[:search] = 'name = "sp1"'
        end.returns(index_response([{ 'id' => 1 }]))
        api_expects(:hosts, :create) do |p|
          p['host']['puppet_proxy_id'] == 1 &&
            p['host']['name'] == 'hst1'
        end
        run_cmd(cmd + minimal_params_without_hostgroup + params)
      end
    end
  end
end
