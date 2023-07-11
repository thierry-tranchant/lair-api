# frozen_string_literal: true

class TranslatedEnumsController < ApplicationController
  
  # /api/translated_enums/:id
  def show    
    render json: {
      result:
        I18n.t("activerecord.attributes.#{params[:model]}/#{params[:id]}"),
    }
  end
end
