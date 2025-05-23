# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `ruby-filemagic` gem.
# Please instead update this file by running `bin/tapioca gem ruby-filemagic`.


# source://ruby-filemagic//lib/filemagic/version.rb#1
class FileMagic
  def initialize(*_arg0); end

  def buffer(*_arg0); end
  def check(*_arg0); end
  def close; end
  def closed?; end
  def compile(*_arg0); end
  def descriptor(*_arg0); end

  # source://ruby-filemagic//lib/filemagic.rb#149
  def fd(fd); end

  def file(*_arg0); end
  def flags; end
  def flags=(_arg0); end

  # source://ruby-filemagic//lib/filemagic.rb#153
  def inspect; end

  # source://ruby-filemagic//lib/filemagic.rb#142
  def io(io, length = T.unsafe(nil), rewind = T.unsafe(nil)); end

  def list(*_arg0); end
  def load(*_arg0); end

  # Sets the attribute simplified
  #
  # @param value the value to set the attribute simplified to.
  #
  # source://ruby-filemagic//lib/filemagic.rb#136
  def simplified=(_arg0); end

  # @return [Boolean]
  #
  # source://ruby-filemagic//lib/filemagic.rb#138
  def simplified?; end

  def valid?(*_arg0); end

  class << self
    # Clear our instance cache.
    #
    # source://ruby-filemagic//lib/filemagic.rb#84
    def clear!; end

    def flags(_arg0); end

    # Provide a "magic singleton".
    #
    # source://ruby-filemagic//lib/filemagic.rb#73
    def fm(*flags); end

    def library_version; end

    # source://ruby-filemagic//lib/filemagic.rb#109
    def magic_version(default = T.unsafe(nil)); end

    # Just a short-cut to #open with the +mime+ flag set.
    #
    # source://ruby-filemagic//lib/filemagic.rb#105
    def mime(*flags, &block); end

    def new(*_arg0); end

    # Just like #new, but takes an optional block, in which case #close
    # is called at the end and the value of the block is returned.
    #
    # source://ruby-filemagic//lib/filemagic.rb#90
    def open(*flags); end

    def path; end

    private

    # source://ruby-filemagic//lib/filemagic.rb#122
    def auto_magic_version; end

    # source://ruby-filemagic//lib/filemagic.rb#118
    def user_magic_version(key = T.unsafe(nil)); end
  end
end

# source://ruby-filemagic//lib/filemagic.rb#17
FileMagic::DEFAULT_MAGIC = T.let(T.unsafe(nil), String)

# Map flag values to their names (Integer => :name).
#
# source://ruby-filemagic//lib/filemagic.rb#63
FileMagic::FLAGS_BY_INT = T.let(T.unsafe(nil), Hash)

# Map flag names to their values (:name => Integer).
#
# source://ruby-filemagic//lib/filemagic.rb#22
FileMagic::FLAGS_BY_SYM = T.let(T.unsafe(nil), Hash)

class FileMagic::FileMagicError < ::StandardError; end
FileMagic::MAGIC_APPLE = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_CHECK = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_COMPRESS = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_COMPRESS_TRANSP = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_CONTINUE = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_DEBUG = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_DEVICES = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_ERROR = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_EXTENSION = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_MIME = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_MIME_ENCODING = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_MIME_TYPE = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NODESC = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NONE = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_APPTYPE = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_ASCII = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_BUILTIN = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_CDF = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_COMPRESS = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_ELF = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_ENCODING = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_FORTRAN = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_SOFT = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_TAR = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_TEXT = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_TOKENS = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_NO_CHECK_TROFF = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_PRESERVE_ATIME = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_RAW = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_SYMLINK = T.let(T.unsafe(nil), Integer)
FileMagic::MAGIC_VERSION = T.let(T.unsafe(nil), String)

# Extract "simple" MIME type.
#
# source://ruby-filemagic//lib/filemagic.rb#66
FileMagic::SIMPLE_RE = T.let(T.unsafe(nil), Regexp)

# source://ruby-filemagic//lib/filemagic/version.rb#25
FileMagic::VERSION = T.let(T.unsafe(nil), String)

# source://ruby-filemagic//lib/filemagic/version.rb#3
module FileMagic::Version
  class << self
    # Returns array representation.
    #
    # source://ruby-filemagic//lib/filemagic/version.rb#12
    def to_a; end

    # Short-cut for version string.
    #
    # source://ruby-filemagic//lib/filemagic/version.rb#17
    def to_s; end
  end
end

# source://ruby-filemagic//lib/filemagic/version.rb#5
FileMagic::Version::MAJOR = T.let(T.unsafe(nil), Integer)

# source://ruby-filemagic//lib/filemagic/version.rb#6
FileMagic::Version::MINOR = T.let(T.unsafe(nil), Integer)

# source://ruby-filemagic//lib/filemagic/version.rb#7
FileMagic::Version::TINY = T.let(T.unsafe(nil), Integer)
