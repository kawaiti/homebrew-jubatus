require 'formula'

class ZooKeeperRequirement < Requirement
  def initialize
    super
    @zk = Formula.factory('zookeeper')
  end

  def fatal?
    true
  end

  def satisfied?
    @zk.installed? and File.exist?(@zk.lib + 'libzookeeper_mt.dylib')
  end

  def message
    return nil if satisfied?
    if @zk.installed?
      <<-EOS.undent
        ZooKeeper build was requested, but Zookeeper was already built without `--c` option.
        You will need to `brew uninstall zookeeper; brew install zookeeper --c` first.
      EOS
    else
      <<-EOS.undent
        ZooKeeper build was requested, but Zookeeper is not installed.
        You will need to `brew install zookeeper --c` first.
      EOS
    end
  end
end

class Jubatus < Formula
  # url 'https://github.com/jubatus/jubatus/tarball/0.5.0'
  url 'https://github.com/hido/jubatus/tarball/fix_macosx_error'
  head 'https://github.com/jubatus/jubatus.git', :revision => '21ce129c1259a8070262bfdaf0a3002ea0b6eba2'
  homepage 'http://jubat.us/'
  # sha1 'ae06f9b0a6dc39c6b37f9de1bb74ea874d231a25'
  version '0.5.0'

  option 'disable-onig', 'Disable oniguruma for regex'
  option 'enable-mecab', 'Enable mecab for Japanese NLP'
  option 'enable-zookeeper', 'Enable ZooDeeper for distributed environemnt'

  depends_on 'glog'
  depends_on 'pkg-config'
  depends_on 'jubatus-msgpack-rpc'

  depends_on ZooKeeperRequirement.new if build.include? 'enable-zookeeper'
  depends_on 'mecab' if build.include? "enable-mecab"
  depends_on 'oniguruma' unless build.include? "disable-onig"
  # snow leopard default gcc version is 4.2
  depends_on 'gcc' if build.include? 'snow-leopard'

  def install
    # does not support Mavenricks                                                                                                                                
    if MacOS.version >= "10.9"
      <<-EOS.undent
        Jubatus currently does not support Mavericks or later version
      EOS
      system "Jubatus currently does not support Mavericks or later version"
      onoe "Error! Jubatus currently does not support Mavericks or later version"
    end
    if ENV.compiler == :gcc
      gcc = Formula.factory('gcc')
      version = '4.7'

      if File.exist?(gcc.bin)
        bin = gcc.bin.to_s
        ENV['CC'] = bin+"/gcc-#{version}"
        ENV['LD'] = bin+"/gcc-#{version}"
        ENV['CXX'] = bin+"/g++-#{version}"
      end
    end

    STDERR.puts ENV['CC'], ENV['CXX']
    args = []
    args << "--prefix=#{prefix}"
    args << "--disable-onig" if build.include? "disable-onig"
    args << "--enable-mecab" if build.include? "enable-mecab"
    args << "--enable-zookeeper" if build.include? "enable-zookeeper"
    system "./waf", "configure", *args
    system "./waf", "build"
    system "./waf", "install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test jubatus`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
