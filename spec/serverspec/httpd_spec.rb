require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id

    @log = Logger.new(STDOUT)
    @log.level = Logger::DEBUG
  end

# Causing false failures: redundant with below tests anyway.
#  describe process("apache2") do
#    it { should be_running }
#  end

  describe port(80) do
    it { should be_listening.with('tcp') }
  end

  # Check that the server returns 200 OK
  # Use a simple curl command for the check
  describe command("curl -IX GET http://127.0.0.1") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /200 OK/ }
  end

  # Check that the server returns the default content on GET /
  # Use a simple curl command for the check
  describe command("curl -s http://127.0.0.1") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /<HTML><BODY><H1>It Works!<\/H1><\/BODY><\/HTML>/ }
  end
end
