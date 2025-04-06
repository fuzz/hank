# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/simplecov/all/simplecov.rbi
#
# simplecov-0.22.0

module SimpleCov
  def self.adapt_coverage_result; end
  def self.add_not_loaded_files(result); end
  def self.at_exit_behavior; end
  def self.clear_result; end
  def self.collate(result_filenames, profile = nil, ignore_timeout: nil, &block); end
  def self.exit_and_report_previous_error(exit_status); end
  def self.exit_status_from_exception; end
  def self.external_at_exit; end
  def self.external_at_exit=(arg0); end
  def self.external_at_exit?; end
  def self.filtered(files); end
  def self.final_result_process?; end
  def self.grouped(files); end
  def self.initial_setup(profile, &block); end
  def self.load_adapter(name); end
  def self.load_profile(name); end
  def self.lookup_corresponding_ruby_coverage_name(criterion); end
  def self.make_parallel_tests_available; end
  def self.pid; end
  def self.pid=(arg0); end
  def self.previous_error?(error_exit_status); end
  def self.probably_running_parallel_tests?; end
  def self.process_coverage_result; end
  def self.process_result(result); end
  def self.process_results_and_report_error; end
  def self.ready_to_process_results?; end
  def self.remove_useless_results; end
  def self.result; end
  def self.result?; end
  def self.result_exit_status(result); end
  def self.result_with_not_loaded_files; end
  def self.round_coverage(coverage); end
  def self.run_exit_tasks!; end
  def self.running; end
  def self.running=(arg0); end
  def self.start(profile = nil, &block); end
  def self.start_coverage_measurement; end
  def self.start_coverage_with_criteria; end
  def self.wait_for_other_processes; end
  def self.write_last_run(result); end
  extend SimpleCov::Configuration
end
module SimpleCov::Formatter
  def self.from_env(env); end
end
class SimpleCov::Formatter::MultiFormatter
  def self.[](*args); end
  def self.new(formatters = nil); end
end
module SimpleCov::Formatter::MultiFormatter::InstanceMethods
  def format(result); end
end
module SimpleCov::Configuration
  def adapters; end
  def add_filter(filter_argument = nil, &filter_proc); end
  def add_group(group_name, filter_argument = nil, &filter_proc); end
  def at_exit(&block); end
  def at_fork(&block); end
  def branch_coverage?; end
  def branch_coverage_supported?; end
  def clear_coverage_criteria; end
  def command_name(name = nil); end
  def configure(&block); end
  def coverage_criteria; end
  def coverage_criterion(criterion = nil); end
  def coverage_criterion_enabled?(criterion); end
  def coverage_dir(dir = nil); end
  def coverage_for_eval_enabled?; end
  def coverage_for_eval_supported?; end
  def coverage_path; end
  def coverage_start_arguments_supported?; end
  def enable_coverage(criterion); end
  def enable_coverage_for_eval; end
  def enable_for_subprocesses(value = nil); end
  def enabled_for_subprocesses?; end
  def filters; end
  def filters=(arg0); end
  def formatter(formatter = nil); end
  def formatter=(arg0); end
  def formatters; end
  def formatters=(formatters); end
  def groups; end
  def groups=(arg0); end
  def maximum_coverage_drop(coverage_drop = nil); end
  def merge_timeout(seconds = nil); end
  def minimum_coverage(coverage = nil); end
  def minimum_coverage_by_file(coverage = nil); end
  def minimum_possible_coverage_exceeded(coverage_option); end
  def nocov_token(nocov_token = nil); end
  def parse_filter(filter_argument = nil, &filter_proc); end
  def primary_coverage(criterion = nil); end
  def print_error_status; end
  def print_error_status=(arg0); end
  def profiles; end
  def project_name(new_name = nil); end
  def raise_if_criterion_disabled(criterion); end
  def raise_if_criterion_unsupported(criterion); end
  def raise_on_invalid_coverage(coverage, coverage_setting); end
  def refuse_coverage_drop(*criteria); end
  def root(root = nil); end
  def skip_token(nocov_token = nil); end
  def track_files(glob); end
  def tracked_files; end
  def use_merging(use = nil); end
end
class SimpleCov::CoverageStatistics
  def compute_percent(covered, missed, total); end
  def compute_strength(total_strength, total); end
  def covered; end
  def initialize(covered:, missed:, total_strength: nil); end
  def missed; end
  def percent; end
  def self.from(coverage_statistics); end
  def strength; end
  def total; end
end
module SimpleCov::ExitCodes
end
module SimpleCov::ExitCodes::ExitCodeHandling
  def call(result, coverage_limits:); end
  def coverage_checks(result, coverage_limits); end
  def self.call(result, coverage_limits:); end
  def self.coverage_checks(result, coverage_limits); end
end
class SimpleCov::ExitCodes::MaximumCoverageDropCheck
  def compute_coverage_drop_data; end
  def coverage_drop_violations; end
  def drop_percent(criterion); end
  def exit_code; end
  def failing?; end
  def initialize(result, maximum_coverage_drop); end
  def last_coverage(criterion); end
  def last_run; end
  def maximum_coverage_drop; end
  def report; end
  def result; end
end
class SimpleCov::ExitCodes::MinimumCoverageByFileCheck
  def compute_minimum_coverage_data; end
  def exit_code; end
  def failing?; end
  def initialize(result, minimum_coverage_by_file); end
  def minimum_coverage_by_file; end
  def minimum_violations; end
  def report; end
  def result; end
end
class SimpleCov::ExitCodes::MinimumOverallCoverageCheck
  def calculate_minimum_violations; end
  def exit_code; end
  def failing?; end
  def initialize(result, minimum_coverage); end
  def minimum_coverage; end
  def minimum_violations; end
  def report; end
  def result; end
end
class SimpleCov::Profiles < Hash
  def define(name, &blk); end
  def load(name); end
end
class SimpleCov::SourceFile
  def branch_coverage_statistics; end
  def branches; end
  def branches_coverage_percent; end
  def branches_for_line(line_number); end
  def branches_report; end
  def build_branch(branch_data, hit_count, condition_start_line); end
  def build_branches; end
  def build_branches_from(condition, branches); end
  def build_branches_report; end
  def build_lines; end
  def build_no_cov_chunks; end
  def coverage_data; end
  def coverage_exceeding_source_warn; end
  def coverage_statistics; end
  def covered_branches; end
  def covered_lines; end
  def covered_percent; end
  def covered_strength; end
  def ensure_remove_undefs(file_lines); end
  def filename; end
  def initialize(filename, coverage_data); end
  def line(number); end
  def line_coverage_statistics; end
  def line_with_missed_branch?(line_number); end
  def lines; end
  def lines_of_code; end
  def lines_strength; end
  def load_source; end
  def missed_branches; end
  def missed_lines; end
  def never_lines; end
  def no_branches?; end
  def no_cov_chunks; end
  def no_lines?; end
  def process_skipped_branches(branches); end
  def process_skipped_lines(lines); end
  def project_filename; end
  def read_lines(file, lines, current_line); end
  def relevant_lines; end
  def restore_ruby_data_structure(structure); end
  def set_encoding_based_on_magic_comment(file, line); end
  def shebang?(line); end
  def skipped_lines; end
  def source; end
  def source_lines; end
  def src; end
  def total_branches; end
end
class SimpleCov::SourceFile::Line
  def coverage; end
  def covered?; end
  def initialize(src, line_number, coverage); end
  def line; end
  def line_number; end
  def missed?; end
  def never?; end
  def number; end
  def skipped!; end
  def skipped; end
  def skipped?; end
  def source; end
  def src; end
  def status; end
end
class SimpleCov::SourceFile::Branch
  def coverage; end
  def covered?; end
  def end_line; end
  def initialize(start_line:, end_line:, coverage:, inline:, type:); end
  def inline?; end
  def missed?; end
  def overlaps_with?(line_range); end
  def report; end
  def report_line; end
  def skipped!; end
  def skipped?; end
  def start_line; end
  def type; end
end
class SimpleCov::FileList
  def branch_covered_percent; end
  def compute_coverage_statistics; end
  def compute_coverage_statistics_by_file; end
  def count(*args, **, &block); end
  def coverage_statistics; end
  def coverage_statistics_by_file; end
  def covered_branches; end
  def covered_lines; end
  def covered_percent; end
  def covered_percentages; end
  def covered_strength; end
  def each(*args, **, &block); end
  def empty?(*args, **, &block); end
  def initialize(files); end
  def least_covered_file; end
  def length(*args, **, &block); end
  def lines_of_code; end
  def map(*args, **, &block); end
  def missed_branches; end
  def missed_lines; end
  def never_lines; end
  def size(*args, **, &block); end
  def skipped_lines; end
  def to_a(*args, **, &block); end
  def to_ary(*args, **, &block); end
  def total_branches; end
  extend Forwardable
  include Enumerable
end
class SimpleCov::Result
  def command_name; end
  def command_name=(arg0); end
  def coverage; end
  def coverage_statistics(*args, **, &block); end
  def coverage_statistics_by_file(*args, **, &block); end
  def covered_branches(*args, **, &block); end
  def covered_lines(*args, **, &block); end
  def covered_percent(*args, **, &block); end
  def covered_percentages(*args, **, &block); end
  def covered_strength(*args, **, &block); end
  def created_at; end
  def created_at=(arg0); end
  def filenames; end
  def files; end
  def filter!; end
  def format!; end
  def groups; end
  def initialize(original_result, command_name: nil, created_at: nil); end
  def least_covered_file(*args, **, &block); end
  def missed_branches(*args, **, &block); end
  def missed_lines(*args, **, &block); end
  def original_result; end
  def self.from_hash(hash); end
  def source_files; end
  def to_hash; end
  def total_branches(*args, **, &block); end
  def total_lines(*args, **, &block); end
  extend Forwardable
end
class SimpleCov::Filter
  def filter_argument; end
  def initialize(filter_argument); end
  def matches?(_source_file); end
  def passes?(source_file); end
  def self.build_filter(filter_argument); end
  def self.class_for_argument(filter_argument); end
end
class SimpleCov::StringFilter < SimpleCov::Filter
  def matches?(source_file); end
end
class SimpleCov::RegexFilter < SimpleCov::Filter
  def matches?(source_file); end
end
class SimpleCov::BlockFilter < SimpleCov::Filter
  def matches?(source_file); end
end
class SimpleCov::ArrayFilter < SimpleCov::Filter
  def initialize(filter_argument); end
  def matches?(source_files_list); end
end
class SimpleCov::Formatter::SimpleFormatter
  def format(result); end
end
module SimpleCov::LastRun
  def self.last_run_path; end
  def self.read; end
  def self.write(json); end
end
class SimpleCov::LinesClassifier
  def classify(lines); end
  def self.no_cov_line; end
  def self.no_cov_line?(line); end
  def self.whitespace_line?(line); end
end
module SimpleCov::ResultMerger
  def self.adapt_pre_simplecov_0_18_result(result); end
  def self.adapt_result(result); end
  def self.create_result(command_names, coverage); end
  def self.merge_and_store(*file_paths, ignore_timeout: nil); end
  def self.merge_coverage(*results); end
  def self.merge_results(*file_paths, ignore_timeout: nil); end
  def self.merge_valid_results(results, ignore_timeout: nil); end
  def self.merged_result; end
  def self.parse_file(path); end
  def self.parse_json(content); end
  def self.pre_simplecov_0_18_result?(result); end
  def self.read_file(path); end
  def self.read_resultset; end
  def self.resultset_path; end
  def self.resultset_writelock; end
  def self.store_result(result); end
  def self.synchronize_resultset; end
  def self.time_since_result_creation(data); end
  def self.valid_results(file_path, ignore_timeout: nil); end
  def self.within_merge_timeout?(data); end
end
module SimpleCov::CommandGuesser
  def self.from_command_line_options; end
  def self.from_defined_constants; end
  def self.from_env; end
  def self.guess; end
  def self.original_run_command; end
  def self.original_run_command=(arg0); end
end
class SimpleCov::ResultAdapter
  def adapt; end
  def initialize(result); end
  def result; end
  def self.call(*args); end
end
module SimpleCov::Combine
  def combine(combiner_module, coverage_a, coverage_b); end
  def empty_coverage?(coverage_a, coverage_b); end
  def existing_coverage(coverage_a, coverage_b); end
  def self.combine(combiner_module, coverage_a, coverage_b); end
  def self.empty_coverage?(coverage_a, coverage_b); end
  def self.existing_coverage(coverage_a, coverage_b); end
end
module SimpleCov::Combine::BranchesCombiner
  def combine(coverage_a, coverage_b); end
  def self.combine(coverage_a, coverage_b); end
end
module SimpleCov::Combine::FilesCombiner
  def combine(coverage_a, coverage_b); end
  def self.combine(coverage_a, coverage_b); end
end
module SimpleCov::Combine::LinesCombiner
  def combine(coverage_a, coverage_b); end
  def merge_line_coverage(first_val, second_val); end
  def self.combine(coverage_a, coverage_b); end
  def self.merge_line_coverage(first_val, second_val); end
end
module SimpleCov::Combine::ResultsCombiner
  def combine(*results); end
  def combine_file_coverage(coverage_a, coverage_b); end
  def combine_result_sets(combined_results, result); end
  def self.combine(*results); end
  def self.combine_file_coverage(coverage_a, coverage_b); end
  def self.combine_result_sets(combined_results, result); end
end
module SimpleCov::UselessResultsRemover
  def self.call(coverage_result); end
  def self.root_regx; end
end
module SimpleCov::SimulateCoverage
  def call(absolute_path); end
  def self.call(absolute_path); end
end
class InvalidName___Class_0x00___CoverageLimits_2 < Struct
  def maximum_coverage_drop; end
  def maximum_coverage_drop=(_); end
  def minimum_coverage; end
  def minimum_coverage=(_); end
  def minimum_coverage_by_file; end
  def minimum_coverage_by_file=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.keyword_init?; end
  def self.members; end
  def self.new(*arg0); end
end
