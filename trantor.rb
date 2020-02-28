class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.0.1.tar.gz"
  version "0.0.1"
  sha256 "eb3ebac48ded490e070d72475116f1eb8fa67ea2909ebefce481fc5a26821b93"

  depends_on "docker"

  def install
    # Remove windows files
    bin.install Dir["bin/*"]
    lib.install Dir["lib/*"]
    libexec.install Dir["libexec/*"]

    Pathname.glob("#{bin}/*") do |file|
      next if file.directory?
      basename = file.basename

      (bin/basename).write_env_script file, :JAVA_HOME => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
      (bin/basename).write_env_script file, :TRANTOR_HOME => "#{Formula["trantor"].lib}"
    end
  end

  test do
    system "#{bin}/pampas", "version"
  end

end
