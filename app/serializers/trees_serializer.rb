class TreesSerializer < ActiveModel::Serializer
  attributes :type, :features

  def type
    return "FeatureCollection"
  end

  def features
    object.map do |tree|
      TreeSerializer.new(tree)
    end
  end

end
