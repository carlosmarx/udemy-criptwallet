# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cadastrando criptomoedas..."

coins = 
[
  { 
    description: "Bitcoin",
    acronym: "BTC",
    url_image: "https://logospng.org/download/bitcoin/logo-bitcoin-1536.png"
  },

  {
    description: "Ethereum",
    acronym: "ETH",
    url_image: "https://w7.pngwing.com/pngs/906/776/png-transparent-ethereum-blockchain-bitcoin-logo-see-you-there-angle-triangle-logo.png"
  },

  {
    description: "Dash",
    acronym: "DASH",
    url_image: "https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png"
  }
]

coins.each do |coin|
  Coin.find_or_create_by(coin)
end


puts "Criptomoedas cadastradas com sucesso!"