# frozen_string_literal: true

RSpec.describe Analyses::Perform::Checkout do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  before do
    allow(FileUtils).to receive(:mkpath)
    allow(Git).to receive(:clone)

    allow(analysis.project).to receive(:base_path)
      .and_return('test_base_path')
  end

  it 'sets up the base project path' do
    expect(FileUtils).to receive(:mkpath)
      .with(analysis.project.base_path)
      .once

    context
  end

  it 'clones the repo in the project path' do
    expect(Git).to receive(:clone)
      .with(analysis.project.full_repo_url, analysis.commit, path: analysis.project.base_path)
      .once

    context
  end
end
