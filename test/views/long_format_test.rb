require 'minitest/autorun'
require_relative '../../lib/ls_file'
require_relative '../../lib/views/long_format'

module Views
  class LongFormatTest < Minitest::Test
    def ls_files
      params = Object.new
      def params.dot_match? = true
      def params.reverse? = false
      def params.target_directory = Pathname.new(__dir__).join('../fixtures').to_s
      LsFile.all(params)
    end

    def test_format
      expected = <<~TEXT.chomp
        total 80
        drwxr-xr-x  15 m-hori  staff   480 May 02 09:44 .
        drwxr-xr-x   4 m-hori  staff   128 May 03 16:29 ..
        -rw-r--r--   1 m-hori  staff   740 Apr 23 07:11 application.rb
        -rw-r--r--   1 m-hori  staff   207 Apr 23 07:11 boot.rb
        -rw-r--r--   1 m-hori  staff   193 Apr 23 07:11 cable.yml
        -rw-r--r--   1 m-hori  staff   464 Apr 23 07:11 credentials.yml.enc
        -rw-r--r--   1 m-hori  staff   620 Apr 23 07:11 database.yml
        -rw-r--r--   1 m-hori  staff   128 Apr 23 07:11 environment.rb
        drwxr-xr-x   5 m-hori  staff   160 Apr 23 07:11 environments
        -rw-r--r--   1 m-hori  staff   381 Apr 23 07:11 importmap.rb
        drwxr-xr-x   9 m-hori  staff   288 Apr 23 07:11 initializers
        drwxr-xr-x   5 m-hori  staff   160 Apr 23 07:11 locales
        -rw-r--r--   1 m-hori  staff  1792 Apr 23 07:11 puma.rb
        -rw-r--r--   1 m-hori  staff   322 Apr 23 07:11 routes.rb
        -rw-r--r--   1 m-hori  staff  1152 Apr 23 07:11 storage.yml
      TEXT
      assert_equal expected, LongFormat.new(ls_files).format
    end
  end
end