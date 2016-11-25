class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: { message: "requerido*" }
  validates_format_of :username, :with => /[a-z]/
  validates :username, :length => { :minimum => 2, :message => '2 caracteres como minimo*' }

  validates :apellido, presence: { message: "requerido*" }
  validates_format_of :apellido, :with => /[a-z]/
  validates :apellido, :length => { :minimum => 2, :message => '2 caracteres como minimo*' }

  validates :numero_ci, presence: { message: "requerido*" }
  validates :numero_ci, :numericality => { :message => "ingrese valor numerico*" }
  validates :numero_ci, :length => { :minimum => 7, :maximum => 8, :message => '7 a 8 caracteres como minimo*' }
  
  validates :email, presence: { message: "requerido*" }  
  
  belongs_to :rol
    
  def has_role?(rol)
    !self.rol.actions.find_by(accion: rol).nil?     
  end

  def rol_name?(rol)
    if self.rol.nombre == rol 
    	return true     
    else
    	return false
    end
  end

end
