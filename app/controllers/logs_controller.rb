class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @q = Log.ransack(params[:q])
    @logs = @q.result(distinct: true).order("created_at DESC")

    respond_to do |format|
      format.html do
        @logs = @logs.paginate(:page => params[:page], :per_page => 5)
      end
      format.xlsx do
        render xlsx: 'index', filename: "Chq_log.xlsx"
      end
    end
  end

  def show
  end

  def new
    if current_user.viewer?
      redirect_to root_path
    else
      @log = current_user.logs.build
      @log.prepared = current_user.name
    end
  end

  def edit
    if current_user.viewer?
      redirect_to root_path
    end
  end

  def create
    if current_user.viewer?
      redirect_to root_path
    else
      @log = current_user.logs.build(log_params)
      @log.prepared = current_user.name

      respond_to do |format|
        if @log.save
          format.html { redirect_to root_path, notice: 'Record was successfully created.' }
          format.json { render :show, status: :created, location: @log }
        else
          format.html { render :new }
          format.json { render json: @log.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.viewer?
      redirect_to root_path
    else
      respond_to do |format|
        if @log.update(log_params)
          format.html { redirect_to @log, notice: 'Record was successfully updated.' }
          format.json { render :show, status: :ok, location: @log }
        else
          format.html { render :edit }
          format.json { render json: @log.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.viewer?
      redirect_to root_path
    else
      @log.destroy
      respond_to do |format|
        format.html { redirect_to logs_url, notice: 'Record was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def import
    Log.import(params[:file])
    redirect_to root_url, notice: "Records imported."
  end

  private
    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:chq_number, :chq_date, :payee_name, :category, :deal_id, :particular, :prepared, :currencies, :amount, :sign_date, :present_date, :status, :salesperson, :voucher_no, :void_reason)
    end
end
