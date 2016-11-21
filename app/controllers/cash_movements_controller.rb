class CashMovementsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_cash_movement, only: [:show, :edit, :update, :destroy]
  
  # GET /cash_movements
  # GET /cash_movements.json
  def index
    @cash_movements = CashMovement.all
  end

  # GET /cash_movements/1
  # GET /cash_movements/1.json
  def show
  end

  # GET /cash_movements/new
  def new
    @cash_movement = CashMovement.new
    @cash_movement.payment_types.build()
    @apertura = OpeningCash.find(params[:opening_cash_id])
  end

  
  def client_invoices
      client_id = params[:client_id]
      @invoices = Invoice.where(client_id: client_id,state: "pendiente")
      respond_to do |format|
        format.json { render json: @invoices.to_json }
      end
  end


  # GET /cash_movements/1/edit
  def edit
  end

  # POST /cash_movements
  # POST /cash_movements.json
  def create
    @cash_movement = CashMovement.new(cash_movement_params)
    client_id = params[:client_id]
    
    respond_to do |format|
      if @cash_movement.save
        payment_types = PaymentType.where("cash_movement_id = ?",@cash_movement.id)
        payment_types.each do |payment|
          if payment.payment_value_id == 2
            cheque = Check.new
            cheque.banco = payment.banco
            cheque.titular = payment.titular
            cheque.n_cheque = payment.n_cheque
            cheque.fecha_disponibilidad = payment.fecha_disponibilidad
            cheque.total = payment.total
            cheque.save
          end
        end
        
        invoices = Invoice.where("state = ? and client_id = ?" , "pendiente", @cash_movement.client_id)
        invoices.each do |invoice|  
          cash_movement_detail = DetailOfCashMovement.new
          cash_movement_detail.cash_movement_id = @cash_movement.id
          cash_movement_detail.invoice_id = invoice.id
          cash_movement_detail.sub_monto = invoice.total
          cash_movement_detail.save      
          invoice.state = "pagado"
          invoice.save         
        end
        format.html{ redirect_to new_cash_movement_path(opening_cash_id: @cash_movement.opening_cash_id) }
        format.json { render :show, status: :created, location: @cash_movement }
      else
        format.html { render :new }
        format.json { render json: @cash_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_movements/1
  # PATCH/PUT /cash_movements/1.json
  def update
    respond_to do |format|
      if @cash_movement.update(cash_movement_params)
        format.html { redirect_to @cash_movement, notice: 'Cash movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @cash_movement }
      else
        format.html { render :edit }
        format.json { render json: @cash_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_movements/1
  # DELETE /cash_movements/1.json
  def destroy
    @cash_movement.destroy
    respond_to do |format|
      format.html { redirect_to cash_movements_url, notice: 'Cash movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_movement
      @cash_movement = CashMovement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cash_movement_params
      params.require(:cash_movement).permit(:id, :monto_total, :opening_cash_id, :type_of_cash_movement_id , :client_id, :payment_types_attributes =>[:id,:titular,:banco,:n_cheque,:tarjeta_tipo,:fecha_disponibilidad,:payment_value_id,:total,:_destroy])
    end
end
