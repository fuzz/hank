# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: false
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/minitest/all/minitest.rbi
#
# minitest-5.25.5

module Minitest
  def self.__run(reporter, options); end
  def self.after_run(&block); end
  def self.allow_fork; end
  def self.allow_fork=(arg0); end
  def self.autorun; end
  def self.backtrace_filter; end
  def self.backtrace_filter=(arg0); end
  def self.cattr_accessor(name); end
  def self.clock_time; end
  def self.empty_run!(options); end
  def self.extensions; end
  def self.extensions=(arg0); end
  def self.filter_backtrace(bt); end
  def self.info_signal; end
  def self.info_signal=(arg0); end
  def self.init_plugins(options); end
  def self.load_plugins; end
  def self.parallel_executor; end
  def self.parallel_executor=(arg0); end
  def self.process_args(args = nil); end
  def self.register_plugin(name_or_mod); end
  def self.reporter; end
  def self.reporter=(arg0); end
  def self.run(args = nil); end
  def self.run_one_method(klass, method_name); end
  def self.seed; end
  def self.seed=(arg0); end
end
module Minitest::Parallel
end
class Minitest::Parallel::Executor
  def <<(work); end
  def initialize(size); end
  def shutdown; end
  def size; end
  def start; end
end
module Minitest::Parallel::Test
  def _synchronize; end
end
module Minitest::Parallel::Test::ClassMethods
  def run_one_method(klass, method_name, reporter); end
  def test_order; end
end
module Minitest::Compress
  def compress(orig); end
end
module Minitest::Assertions
  def _synchronize; end
  def _where; end
  def assert(test, msg = nil); end
  def assert_empty(obj, msg = nil); end
  def assert_equal(exp, act, msg = nil); end
  def assert_in_delta(exp, act, delta = nil, msg = nil); end
  def assert_in_epsilon(exp, act, epsilon = nil, msg = nil); end
  def assert_includes(collection, obj, msg = nil); end
  def assert_instance_of(cls, obj, msg = nil); end
  def assert_kind_of(cls, obj, msg = nil); end
  def assert_match(matcher, obj, msg = nil); end
  def assert_mock(mock, msg = nil); end
  def assert_nil(obj, msg = nil); end
  def assert_operator(o1, op, o2 = nil, msg = nil); end
  def assert_output(stdout = nil, stderr = nil); end
  def assert_path_exists(path, msg = nil); end
  def assert_pattern; end
  def assert_predicate(o1, op, msg = nil); end
  def assert_raises(*exp); end
  def assert_respond_to(obj, meth, msg = nil, include_all: nil); end
  def assert_same(exp, act, msg = nil); end
  def assert_send(send_ary, m = nil); end
  def assert_silent; end
  def assert_throws(sym, msg = nil); end
  def capture_io; end
  def capture_subprocess_io; end
  def diff(exp, act); end
  def exception_details(e, msg); end
  def fail_after(y, m, d, msg); end
  def flunk(msg = nil); end
  def message(msg = nil, ending = nil, &default); end
  def mu_pp(obj); end
  def mu_pp_for_diff(obj); end
  def pass(_msg = nil); end
  def refute(test, msg = nil); end
  def refute_empty(obj, msg = nil); end
  def refute_equal(exp, act, msg = nil); end
  def refute_in_delta(exp, act, delta = nil, msg = nil); end
  def refute_in_epsilon(a, b, epsilon = nil, msg = nil); end
  def refute_includes(collection, obj, msg = nil); end
  def refute_instance_of(cls, obj, msg = nil); end
  def refute_kind_of(cls, obj, msg = nil); end
  def refute_match(matcher, obj, msg = nil); end
  def refute_nil(obj, msg = nil); end
  def refute_operator(o1, op, o2 = nil, msg = nil); end
  def refute_path_exists(path, msg = nil); end
  def refute_pattern; end
  def refute_predicate(o1, op, msg = nil); end
  def refute_respond_to(obj, meth, msg = nil, include_all: nil); end
  def refute_same(exp, act, msg = nil); end
  def self.diff; end
  def self.diff=(o); end
  def skip(msg = nil, _ignored = nil); end
  def skip_until(y, m, d, msg); end
  def skipped?; end
  def things_to_diff(exp, act); end
end
class Minitest::Test < Minitest::Runnable
  def capture_exceptions; end
  def class_name; end
  def neuter_exception(e); end
  def new_exception(klass, msg, bt, kill = nil); end
  def run(*args); end
  def sanitize_exception(e); end
  def self.i_suck_and_my_tests_are_order_dependent!; end
  def self.io_lock; end
  def self.io_lock=(arg0); end
  def self.make_my_diffs_pretty!; end
  def self.parallelize_me!; end
  def self.runnable_methods; end
  extend Minitest::Guard
  include Minitest::Assertions
  include Minitest::Guard
  include Minitest::Reportable
  include Minitest::Test::LifecycleHooks
end
module Minitest::Test::LifecycleHooks
  def after_setup; end
  def after_teardown; end
  def before_setup; end
  def before_teardown; end
  def setup; end
  def teardown; end
end
class Minitest::Runnable
  def assertions; end
  def assertions=(arg0); end
  def failure; end
  def failures; end
  def failures=(arg0); end
  def initialize(name); end
  def marshal_dump; end
  def marshal_load(ary); end
  def metadata; end
  def metadata=(arg0); end
  def metadata?; end
  def name; end
  def name=(o); end
  def passed?; end
  def result_code; end
  def run; end
  def self.inherited(klass); end
  def self.methods_matching(re); end
  def self.on_signal(name, action); end
  def self.reset; end
  def self.run(reporter, options = nil); end
  def self.run_one_method(klass, method_name, reporter); end
  def self.runnable_methods; end
  def self.runnables; end
  def self.test_order; end
  def self.with_info_handler(reporter, &block); end
  def skipped?; end
  def time; end
  def time=(arg0); end
  def time_it; end
end
module Minitest::Reportable
  def class_name; end
  def error?; end
  def location; end
  def passed?; end
  def result_code; end
  def skipped?; end
end
class Minitest::Result < Minitest::Runnable
  def class_name; end
  def klass; end
  def klass=(arg0); end
  def self.from(runnable); end
  def source_location; end
  def source_location=(arg0); end
  def to_s; end
  include Minitest::Reportable
end
class Minitest::AbstractReporter
  def initialize; end
  def passed?; end
  def prerecord(klass, name); end
  def record(result); end
  def report; end
  def start; end
  def synchronize(&block); end
end
class Minitest::Reporter < Minitest::AbstractReporter
  def initialize(io = nil, options = nil); end
  def io; end
  def io=(arg0); end
  def options; end
  def options=(arg0); end
end
class Minitest::ProgressReporter < Minitest::Reporter
  def prerecord(klass, name); end
  def record(result); end
end
class Minitest::StatisticsReporter < Minitest::Reporter
  def assertions; end
  def assertions=(arg0); end
  def count; end
  def count=(arg0); end
  def errors; end
  def errors=(arg0); end
  def failures; end
  def failures=(arg0); end
  def initialize(io = nil, options = nil); end
  def passed?; end
  def record(result); end
  def report; end
  def results; end
  def results=(arg0); end
  def skips; end
  def skips=(arg0); end
  def start; end
  def start_time; end
  def start_time=(arg0); end
  def total_time; end
  def total_time=(arg0); end
  def warnings; end
  def warnings=(arg0); end
end
class Minitest::SummaryReporter < Minitest::StatisticsReporter
  def aggregated_results(io); end
  def old_sync; end
  def old_sync=(arg0); end
  def report; end
  def start; end
  def statistics; end
  def summary; end
  def sync; end
  def sync=(arg0); end
  def to_s; end
end
class Minitest::CompositeReporter < Minitest::AbstractReporter
  def <<(reporter); end
  def initialize(*reporters); end
  def io; end
  def passed?; end
  def prerecord(klass, name); end
  def record(result); end
  def report; end
  def reporters; end
  def reporters=(arg0); end
  def start; end
end
class Minitest::Assertion < Exception
  def error; end
  def location; end
  def result_code; end
  def result_label; end
end
class Minitest::Skip < Minitest::Assertion
  def result_label; end
end
class Minitest::UnexpectedError < Minitest::Assertion
  def backtrace; end
  def error; end
  def error=(arg0); end
  def initialize(error); end
  def message; end
  def result_label; end
  include Minitest::Compress
end
class Minitest::UnexpectedWarning < Minitest::Assertion
  def result_label; end
end
module Minitest::Guard
  def jruby?(platform = nil); end
  def maglev?(platform = nil); end
  def mri?(platform = nil); end
  def osx?(platform = nil); end
  def rubinius?(platform = nil); end
  def windows?(platform = nil); end
end
class Minitest::BacktraceFilter
  def filter(bt); end
  def initialize(regexp = nil); end
  def regexp; end
  def regexp=(arg0); end
end
class MockExpectationError < StandardError
end
class Minitest::Mock
  def ===(*args, **kwargs, &b); end
  def __call(name, data); end
  def __respond_to?(*arg0); end
  def class(*args, **kwargs, &b); end
  def expect(name, retval, args = nil, **kwargs, &blk); end
  def initialize(delegator = nil); end
  def inspect(*args, **kwargs, &b); end
  def instance_eval(*args, **kwargs, &b); end
  def instance_variables(*args, **kwargs, &b); end
  def method_missing(sym, *args, **kwargs, &block); end
  def object_id(*args, **kwargs, &b); end
  def public_send(*args, **kwargs, &b); end
  def respond_to?(sym, include_private = nil); end
  def respond_to_missing?(*args, **kwargs, &b); end
  def send(*args, **kwargs, &b); end
  def to_s(*args, **kwargs, &b); end
  def verify; end
end
module Minitest::Expectations
  def must_be(*args, **); end
  def must_be_close_to(*args, **); end
  def must_be_empty(*args, **); end
  def must_be_instance_of(*args, **); end
  def must_be_kind_of(*args, **); end
  def must_be_nil(*args, **); end
  def must_be_same_as(*args, **); end
  def must_be_silent(*args, **); end
  def must_be_within_delta(*args, **); end
  def must_be_within_epsilon(*args, **); end
  def must_equal(*args, **); end
  def must_include(*args, **); end
  def must_match(*args, **); end
  def must_output(*args, **); end
  def must_pattern_match(*args, **); end
  def must_raise(*args, **); end
  def must_respond_to(*args, **); end
  def must_throw(*args, **); end
  def path_must_exist(*args, **); end
  def path_wont_exist(*args, **); end
  def wont_be(*args, **); end
  def wont_be_close_to(*args, **); end
  def wont_be_empty(*args, **); end
  def wont_be_instance_of(*args, **); end
  def wont_be_kind_of(*args, **); end
  def wont_be_nil(*args, **); end
  def wont_be_same_as(*args, **); end
  def wont_be_within_delta(*args, **); end
  def wont_be_within_epsilon(*args, **); end
  def wont_equal(*args, **); end
  def wont_include(*args, **); end
  def wont_match(*args, **); end
  def wont_pattern_match(*args, **); end
  def wont_respond_to(*args, **); end
end
class Object < BasicObject
  def stub(name, val_or_callable, *block_args, **block_kwargs, &block); end
  include Minitest::Expectations
end
class Minitest::Expectation < Struct
  def ctx; end
  def ctx=(_); end
  def must_be(*args, **); end
  def must_be_close_to(*args, **); end
  def must_be_empty(*args, **); end
  def must_be_instance_of(*args, **); end
  def must_be_kind_of(*args, **); end
  def must_be_nil(*args, **); end
  def must_be_same_as(*args, **); end
  def must_be_silent(*args, **); end
  def must_be_within_delta(*args, **); end
  def must_be_within_epsilon(*args, **); end
  def must_equal(*args, **); end
  def must_include(*args, **); end
  def must_match(*args, **); end
  def must_output(*args, **); end
  def must_pattern_match(*args, **); end
  def must_raise(*args, **); end
  def must_respond_to(*args, **); end
  def must_throw(*args, **); end
  def path_must_exist(*args, **); end
  def path_wont_exist(*args, **); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.keyword_init?; end
  def self.members; end
  def self.new(*arg0); end
  def target; end
  def target=(_); end
  def wont_be(*args, **); end
  def wont_be_close_to(*args, **); end
  def wont_be_empty(*args, **); end
  def wont_be_instance_of(*args, **); end
  def wont_be_kind_of(*args, **); end
  def wont_be_nil(*args, **); end
  def wont_be_same_as(*args, **); end
  def wont_be_within_delta(*args, **); end
  def wont_be_within_epsilon(*args, **); end
  def wont_equal(*args, **); end
  def wont_include(*args, **); end
  def wont_match(*args, **); end
  def wont_pattern_match(*args, **); end
  def wont_respond_to(*args, **); end
end
class Module
  def infect_an_assertion(meth, new_name, dont_flip = nil); end
end
module Kernel
  def describe(desc, *additional_desc, &block); end
end
class Minitest::Spec < Minitest::Test
  def initialize(name); end
  def self.current; end
  extend Minitest::Spec::DSL
  include Minitest::Spec::DSL::InstanceMethods
end
module Minitest::Spec::DSL
  def after(_type = nil, &block); end
  def before(_type = nil, &block); end
  def children; end
  def create(name, desc); end
  def desc; end
  def describe_stack; end
  def it(desc = nil, &block); end
  def let(name, &block); end
  def name; end
  def nuke_test_methods!; end
  def register_spec_type(*args, &block); end
  def self.extended(obj); end
  def spec_type(desc, *additional); end
  def specify(desc = nil, &block); end
  def subject(&block); end
  def to_s; end
end
module Minitest::Spec::DSL::InstanceMethods
  def _(value = nil, &block); end
  def before_setup; end
  def expect(value = nil, &block); end
  def value(value = nil, &block); end
end
