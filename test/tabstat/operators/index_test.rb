require 'minitest/autorun'

class IndexTest < Minitest::Test
  def setup
    @ctx = Context.new([{"a" => 1, "b" => 2, "c" => 3}, {"a" => 4, "b" => 5, "c" => "six"}])
  end

  def teardown
    # Do nothing
  end

  def test
    indexed_ctx = Index.apply @ctx, ""
    assert indexed_ctx.data != nil
    assert indexed_ctx.data.size == 2
  end
end
