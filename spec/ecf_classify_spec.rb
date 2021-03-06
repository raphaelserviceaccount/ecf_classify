require 'tempfile'

RSpec.describe EcfClassify do
  let(:sequences){ "spec/support/sequences.fa"  }
  it "has a version number" do
    expect(EcfClassify::VERSION).not_to be nil
  end

  it "successfully runs hmmsearch for every hmm profile database" do
    file = Tempfile.new("foo")
    begin
      expect(EcfClassify::HMMER.hmmsearch(sequences,file.path,:general)[1]).to eq(0)
      expect(EcfClassify::HMMER.hmmsearch(sequences,file.path,:sigma3)[1]).to eq(0)
      expect(EcfClassify::HMMER.hmmsearch(sequences,file.path,:sigma2_4)[1]).to eq(0)
      expect(EcfClassify::HMMER.hmmsearch(sequences,file.path,:groups)[1]).to eq(0)
      expect(EcfClassify::HMMER.hmmsearch(sequences,file.path,:subgroups)[1]).to eq(0)
    ensure
      file.close
      file.unlink
    end
  end

  it "fails running when db not there" do
    file = Tempfile.new("bar")
    begin
      expect(EcfClassify::HMMER.hmmsearch(sequences, file.path, :db_not_there)[1]).to eq(2)
    ensure
      file.close
      file.unlink
    end
  end
end
