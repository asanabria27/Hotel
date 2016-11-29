class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :facturar]

  # GET /accounts
  # GET /accounts.json
  def index    
    @accounts = Account.page(params[:page]).per(5)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  def facturar
    
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'La Cuenta fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        if @account.numero.nil?
          format.html { redirect_to @account, notice: 'La Cuenta fue editada exitosamente.' }
          format.json { render :show, status: :ok, location: @account }
        else
          format.js { }
        end
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'La Cuenta fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  def report
  @filterrific = initialize_filterrific(
    Account,
    params[:filterrific],select_options: {
        sorted_by_state: Account.options_for_sorted_by_state
      },
     persistence_id: false
  ) or return

  @accounts = @filterrific.find.page(params[:page]).paginate(:per_page => 5, :page => params[:page])
  @accounts_report = @filterrific.find
  respond_to do |format|
    format.html
    format.js
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(
        :client_id,
        :ruc,
        :fecha_entrada,
        :fecha_salida,
        :room_id,
        :identificador_hab,
        :telefono,
        :correo,
        :nombre,
        :direccion,
        :numero,
        :subtotal,
        :descuento,
        :total,
        :iva,
        #:room_account_details_attributes => [:id, :room_id, :precio, :subtotal, :_destroy],
        :account_details_attributes => [:id, :service_id, :servicio, :cantidad, :precio, :subtotal, :_destroy])
    end
end
