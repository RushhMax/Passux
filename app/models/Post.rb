class Post < ApplicationRecord
  belongs_to :usuario, class_name: 'Usuario', foreign_key: 'usuario_id'

  validates :content, presence: true
  validates :usuario_id, presence: true
end
