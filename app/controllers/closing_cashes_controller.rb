class ClosingCashesController < ApplicationController
  before_action :set_closing_cash, only: [:show, :edit, :update, :destroy]

  # GET /closing_cashes
  # GET /closing_cashes.json
  def index
    @closing_cashes = ClosingCash.all
  end

  # GET /closing_cashes/1
  # GET /closing_cashes/1.json
  def show
  end

  # GET /closing_cashes/new
  def new
    @closing_cash = ClosingCash.new
  end

  # GET /closing_cashes/1/edit
  def edit
  end

  # POST /closing_cashes
  # POST /closing_cashes.json
  def create
    @closing_cash = ClosingCash.new(closing_cash_params)

    respond_to do |format|
      if @closing_cash.save
        format.html { redirect_to @closing_cash, notice: 'Closing cash was successfully created.' }
        format.json { render :show, status: :created, location: @closing_cash }
      else
        format.html { render :new }
        format.json { render json: @closing_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /closing_cashes/1
  # PATCH/PUT /closing_cashes/1.json
  def update
    respond_to do |format|
      if @closing_cash.update(closing_cash_params)
        format.html { redirect_to @closing_cash, notice: 'Closing cash was successfully updated.' }
        format.json { render :show, status: :ok, location: @closing_cash }
      else
        format.html { render :edit }
        format.json { render json: @closing_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /closing_cashes/1
  # DELETE /closing_cashes/1.json
  def destroy
    @closing_cash.destroy
    respond_to do |format|
      format.html { redirect_to closing_cashes_url, notice: 'Closing cash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closing_cash
      @closing_cash = ClosingCash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def closing_cash_params
      params.require(:closing_cash).permit(:fecha_cierre, :monto_efectivo, :monto_cheque, :monto_tcredito, :monto_tdebito)
    end
end