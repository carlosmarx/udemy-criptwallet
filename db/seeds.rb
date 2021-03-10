# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cadastrando criptomoedas..."
Coin.create!(
  description: "Bitcoin",
  acronym: "BTC",
  url_image: "https://logospng.org/download/bitcoin/logo-bitcoin-1536.png"
)

Coin.create!(
  description: "Ethereum",
  acronym: "ETH",
  url_image: "https://w7.pngwing.com/pngs/906/776/png-transparent-ethereum-blockchain-bitcoin-logo-see-you-there-angle-triangle-logo.png"
)

Coin.create!(
  description: "Dash",
  acronym: "DASH",
  url_image: "https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png"
)


puts "Criptomoedas cadastradas com sucesso!"