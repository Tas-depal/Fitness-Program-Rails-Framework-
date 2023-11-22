class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :category, :name, :status, :price, :video

  def video
    object.video.url
  end

  def category
    object.category.category_name
  end
end
