class FundosController < ApplicationController

  def index
    @fundos = Fundo.all
    render json: {status: 'Sucesso', message: 'Fundos carregados', data: @fundos},
           status: :ok
  end

  def recupera
    @fundo = Fundo.find_by_ticker(params[:ticker])

    if !@fundo.nil?
      render json: {status: 'Sucesso', message: 'Fundo carregado', data: @fundo},
             status: :ok
    else
      render json: {status: 'Não encontrado', message: "Fundo #{params[:ticker].upcase} não encontrado"},
             status: :not_found
    end
  end

  def create
    @fundo = Fundo.new(fundo_params)

    respond_to do |format|
      if @fundo.save
        format.html { redirect_to @fundo, notice: 'Fundo was successfully created.' }
        format.json { render :show, status: :created, location: @fundo }
      else
        format.html { render :new }
        format.json { render json: @fundo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fundo.destroy
    respond_to do |format|
      format.html { redirect_to fundos_url, notice: 'Fundo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def fundo_params
    params.require(:fundo).permit(:ticker, :nome, :cnpj, :segmento, :tx_adm,
                                  :data_const, :num_cotas_emitidas, :patrimonio_inicial,
                                  :valor_inicial_cota, :prazo, :tipo_gestao)
  end
end