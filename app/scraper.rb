require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  # lista de fundos
  url = 'https://www.fundsexplorer.com.br/funds/'
  pag_nao_parseada = HTTParty.get(url)
  pag_parseada = Nokogiri::HTML(pag_nao_parseada)
  lista_fundos = pag_parseada.css('span.symbol')
  contagem_fundos = lista_fundos.count
  primeiro_lista = lista_fundos[0]
  ticker_fundo = primeiro_lista.children[0].text

  # fundo ABCP11
  fundo_url = 'https://www.fundsexplorer.com.br/funds/abcp11/'
  fundo_pag_nao_parseada = HTTParty.get(fundo_url)
  fundo_pag_parseada = Nokogiri::HTML(fundo_pag_nao_parseada)
  preco = fundo_pag_parseada.css('span.price')[0].text.delete('R$').strip
  nome_fundo = fundo_pag_parseada.css('h2.section-subtitle')[0].text
  cnpj = fundo_pag_parseada.css('span.description')[8].text.strip
  segmento = fundo_pag_parseada.css('span.description')[11].text.strip
  tx_adm = fundo_pag_parseada.css('span.description')[13].text.strip.delete('^0-9.').chomp('.')
  data_const = fundo_pag_parseada.css('span.description')[1].text.strip
  num_cotas_emitidas = fundo_pag_parseada.css('span.description')[2].text.strip
  patrimonio_inicial = fundo_pag_parseada.css('span.description')[3].text.delete('R$').strip
  valor_inicial_cota = fundo_pag_parseada.css('span.description')[4].text.delete('R$').strip
  prazo = fundo_pag_parseada.css('span.description')[12].text.strip
  tipo_gestao = fundo_pag_parseada.css('span.description')[5].text.strip

  byebug
end

scraper