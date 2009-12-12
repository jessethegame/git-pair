require 'tmpdir'
require 'test/unit/assertions'
World(Test::Unit::Assertions)


module RepositoryHelper
  # TODO: use 1.8.7's Dir.mktmpdir?
  REPO_PATH = File.join(Dir::tmpdir, "git-pair-test-repo")
  REPO_GIT_DIR = File.join(REPO_PATH, ".git")
  GIT_PAIR  = File.expand_path(File.join(File.dirname(__FILE__), "../../bin/git-pair"))

  def git_pair(options = "")
    output = `GIT_DIR=#{REPO_GIT_DIR} && #{GIT_PAIR} #{options} 2>&1`
    output.gsub(/\e\[\d\d?m/, '')  # strip any ANSI colors
  end

  def git_config
    `GIT_DIR=#{REPO_GIT_DIR} && git config --list 2>&1`
  end

  def backup_global_gitconfig
    FileUtils.cp File.expand_path('~/.gitconfig'),
                 File.expand_path('~/.gitconfig.bak')
  end

  def restore_global_gitconfig
    FileUtils.cp File.expand_path('~/.gitconfig.bak'),
                 File.expand_path('~/.gitconfig')
    FileUtils.rm File.expand_path('~/.gitconfig.bak')
  end
end

World(RepositoryHelper)


Before do
  backup_global_gitconfig
  FileUtils.mkdir_p RepositoryHelper::REPO_PATH
  `GIT_DIR=#{RepositoryHelper::REPO_GIT_DIR} && git init`
end

After do
  FileUtils.rm_rf RepositoryHelper::REPO_PATH
  restore_global_gitconfig
end
