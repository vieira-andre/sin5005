class Noticias < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'

  class Noticia
    attr_accessor :titulo
    attr_accessor :link
    attr_accessor :descricao

    def initialize(titulo, link, descricao)
        @titulo = titulo
        @link = link
        @descricao = descricao
      end

    end

  def self.pesquisa(termo)
    url = 'https://news.google.com/rss/search?q=' + termo + '&hl=pt-BR&gl=BR&ceid=BR:pt-419'

    Nokogiri::XML(open(url))
  end

  def self.extrairinformacoes(fii_xml)

    @lista_noticias = []

    titulo = ''
    link = ''
    descricao = ''

    fii_xml.xpath('//item/*').each{|e|

      if e.name == 'title'
        titulo = e.text
      end

      if e.name == 'link'
        link = e.text
      end

      if e.name == 'description'
        descricao = e.text
        @lista_noticias << Noticia.new(titulo,link,descricao)
      end

    }

    @lista_noticias
  end

  def self.lista(fii)
    return if fii.blank?

    @lista_noticias = []

    fii_xml = pesquisa(fii)

    @lista_noticias = extrairinformacoes(fii_xml)


    @lista_noticias

   end

end