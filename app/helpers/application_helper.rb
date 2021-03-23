module ApplicationHelper
    def locale(locale)
        I18n.locale == :en ? "Estados Unidos" : "Português do Brasil"
    end
     
end
