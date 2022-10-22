class Cut
  def self.apply(ctx, params)
    fields_to_cut = params.split(',').map { |p| p.chomp }
    # TODO: Error handling.
    # Invalid params. Missing fields.
    cutData = ctx.data.map { |d| d.slice(*fields_to_cut) }
    ctx.with_data(cutData)
  end
end

class Max
  def self.apply(ctx, params)
    maxTargetColumn = params
    # TODO: Error handling.
    # Invalid fields.
    max = ctx.data.map { |d| d[maxTargetColumn] }.max
    ctx.with_data([{ "Max(#{maxTargetColumn})" => max }])
  end
end

class Index
  # Index the columns so that the operators can refer the columns using index.
  def self.apply(ctx, params)
    if data.nil? || data.size > 0
      ctx
    else
      key_index = get_keys(ctx.data).map.with_index.to_h
      data_with_index = ctx.data.map {|x| with_index(x, key_index)}
      ctx.with_data(data_with_index)
    end
  end

  def get_keys(data)
    data[0].keys
  end

  def with_index(hsh, key_index)
    indexed_hash = hsh.transform_index { |k| key_index[k] }
    indexed_hash.merge(hsh)
  end
end