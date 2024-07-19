class User < ApplicationRecord
  has_many :posts, foreign_key: 'usuario_id'

  has_secure_password

  validates :nombre, presence: true
  validates :apellido, presence: true
  validates :username, presence: true, uniqueness: true
  validates :correo, presence: true, uniqueness: true
  validates :contraseña, presence: true
end
