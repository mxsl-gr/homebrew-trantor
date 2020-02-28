class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.0.1.tar.gz"
  version "0.0.1"
  sha256 "eb3ebac48ded490e070d72475116f1eb8fa67ea2909ebefce481fc5a26821b93"

  depends_on "docker"

  def shim_script(target)
    <<~EOS
      #!/bin/bash
      if [ -z "$JAVA_HOME" ] ; then
        JAVACMD=`which java`
      else
        JAVACMD="$JAVA_HOME/bin/java"
      fi
      exec "$JAVACMD" -jar "#{libexec}/trantor-cli.jar"
    EOS
  end

  def install
    # Remove windows files
    lib.install Dir["lib/*"]
    libexec.install Dir["libexec/*"]

    Pathname.glob("#{libexec}/bin/*.sh") do |path|
      script_name = path.basename
      bin_name    = path.basename ".sh"
      (bin+bin_name).write shim_script(script_name)
    end
    rm_f Dir["libexec/bin"]
  end

  test do
    system "#{bin}/trantor", "version"
  end

end
