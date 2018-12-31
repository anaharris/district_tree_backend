class TreeSerializer < ActiveModel::Serializer
  attributes :type, :properties, :geometry

  def type
    return "Feature"
  end

  def properties
    return {
      id: object.id,
      address: object.address,
      ward: object.ward,
      scientific_name: object.scientific_name,
      common_name: object.common_name,
      disease: object.disease,
      pests: object.pests,
      condition: object.condition,
      fam_name: object.fam_name,
      genus_name: object.genus_name
    }
  end

  def geometry
    return {
      type: "Point",
      coordinates: [
        object.xy.x,
        object.xy.y
      ]
    }
  end

end
