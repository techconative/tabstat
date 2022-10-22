class Cut
  def self.apply(ctx, params)
    fields_to_cut = params.split(',').map{|p| p.chomp}
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
    ctx.with_data([{"Max(#{maxTargetColumn})" => max}])
  end
end

