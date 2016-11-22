class Room < ActiveRecord::Base
  belongs_to :type_of_room
  belongs_to :state
  belongs_to :comfort
  
  has_many :room_account_details
  has_many :photos, :dependent => :destroy
  validates :identificador, presence: true
  delegate :tipo, to: :type_of_room, prefix: true, allow_nil: true
  delegate :descripcion, to: :state, prefix: true, allow_nil: true
  delegate :descripcion, to: :comfort, prefix: true, allow_nil: true
  accepts_nested_attributes_for :photos ,:allow_destroy => true, update_only: true
  paginates_per 2 

  
  #atributos para filtros de reporte
  filterrific(available_filters: [:sorted_by_state,:sorted_by_type])
  #scopes para reporte
  scope :sorted_by_state, lambda{ |room_state_ids|where(:state => [*room_state_ids])}
  scope :sorted_by_type, lambda{ |room_type_ids|where(:type_of_room => [*room_type_ids])}
  #Metodo utilizado por filtros dentro de reportes para quejas
  def self.options_for_sorted_by_identificador
    order('LOWER(identificador)').map { |e| [e.identificador, e.id] }
  end





end 
