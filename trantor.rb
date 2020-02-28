class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.0.1.tar.gz"
  version "0.0.1"
  sha256 "94b08394258b8672e79b5deee1646a4b50315a3ab565d09720a3f75ea7be54aa"

  depends_on "docker"

  def install
    # Remove windows files
    bin.install Dir["bin/*"]
    libexec.install Dir["bin/*"]

    Pathname.glob("#{libexec}/bin/*") do |file|
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
