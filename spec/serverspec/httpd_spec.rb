require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  describe process("apache2") do
    its(:user) { should eq "www-data" }
  end

  describe port(80) do
    it { should be_listening }
  end
end
