namespace :dev do
  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Apagando banco de dados...")
      spinner.auto_spin

      show_spinner("Apagando banco de dados", "Banco apagado com sucesso!") { %x(rails db:drop) }
      show_spinner("Criando banco de dados", "Banco criado com sucesso!!") { %x(rails db:create) }
      show_spinner("Executando migrations", "Migrations executadas com sucesso!") { %x(rails db:migrate) }
      show_spinner("Populando banco de dados", "Banco de dados populado com sucesso!") { %x(rails db:seed) }
      
    else 
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  def show_spinner(msg_start, msg_end)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}...")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
