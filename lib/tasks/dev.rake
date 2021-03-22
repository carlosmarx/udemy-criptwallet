namespace :dev do
  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco de dados", "Banco apagado com sucesso!") { %x(rails db:drop) }
      show_spinner("Criando banco de dados", "Banco criado com sucesso!!") { %x(rails db:create) }
      show_spinner("Executando migrations", "Migrations executadas com sucesso!") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else 
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastro de moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas") do
      coins = 
      [
        { 
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://logospng.org/download/bitcoin/logo-bitcoin-1536.png",
          mining_type: MiningType.all.sample
        },

        {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://w7.pngwing.com/pngs/906/776/png-transparent-ethereum-blockchain-bitcoin-logo-see-you-there-angle-triangle-logo.png",
          mining_type: MiningType.find_by(acronym: 'PoW')
        },

        {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png",
          mining_type: MiningType.all.sample
        },
        {
          description: "Iota",
          acronym: "IOT",
          url_image: "https://img2.pngio.com/iota-png-4-png-image-iota-png-400_400.png",
          mining_type: MiningType.all.sample
        },
        {
          description: "ZCash",
          acronym: "ZEC",
          url_image: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADgCAMAAADCMfHtAAAA8FBMVEX////0tygjHyAAAAD8vSjzsgAdGyAZGCBKOyFqUiIhHiAfHSD+vykAByDjqicgHB0AAB8UFSBfSiKFZSOQbiQXERMcFxj0tR8TDA41LCEIAAD0tRkaFRf29vb5+fnX19empaWYl5d0c3OEg4Pr6+t9e3zh4OBWVFTCwcFCP0D++e6zsrJpZ2fJyMj75bz63qovLC399OP40IOgn5/1v0hNSks7ODn41I72xmH87tT86skLECD3yW11dHTPnCYoIyClfST1wEz52ZyOjI13WyJ/YSObdiTZoye8jiVNPCH1vDf2x2b40oezhyU6LyDfpydJsa+uAAASWUlEQVR4nO1daXvauBYuCLpkqZO2BtdAIGHfAiQhIUvbSehMp+ks///fXNuSDUjnyJItnMxz837p04TYfjn7kazz6tULXvCCF7zgBS94gRHUWvXe8HzZbJ8EaDePG8NevVV76ucygU7v+GQ+dQghrus4NoPjuK73I3s6b5/3Ok/9jInRGbb7Hg3HLll5GJZVsn2m82av9dRPq4v6cdcirl1CqHEoeTLOjxr/GWG2eic2caqY4DB5etKcNsdHT/30sWg1up59abKLWDrEHQ2ftf8ZdomrqJkIdqqEnIyfmgeCetsl1VT0GGxiHT9DzzPsEyehcorw1LXbe2pGG2gtCUmnnQKqJN94Nm6n1SbOjll+Piy3evwsOPr8zNNjHMnxU9N7dbTcGj/KsTR8WoINx90iv4AjmT5h8BhfEmPuU8ax+0T5XG2UBT8fVbJ8CoJDYqs/o1W1acHE4JVStk7m6mavqq2umgBZfTQdtZfnw15vPK7Xx+OeXw63R3mfqmL9YZF2tgQbKvmZXy4483ajjqZgrXHjpO96NBW+LaeUoRhrXRL7QFWXWCeNukLIrtXPR95XEStLKztrHDtxFugVCF29grZ+PI8vS9x+Ngn5cYwFljx6SYq8VsMjGXNpN4N8PEZDvapgLtIbzE4nV2d3i4uLRw8X94u7s6vJzWwgkryUe2iLNLdNsJOXPYHlOktOOWenV4tysVisVCplDzkP/r/ef72f5RYPp7PNz9dP5IIk3e1m4z1ZkVQi08bGp68fFhWPWkALRtnjmbubXK//Ve3YkXF0pts0xobEBC3SXzeSweSXx05CboNm+e50XWUbU8mNSm59awSbuAl6CfIav8HkXpHdGsvFZJ2jjcvRItvyNyOcIJmuFTk3C016Ecm7NXVtOHhZRhpbIdhFCyWHnK8+9pArJqDHSBYvVoKsNfHEaf2G5ghiX6mXMkbhYXbmOcg08JzsVWSRkuR3C8U/StCdRoY/u0vJL0CleBZxHLrYbY1TxAiuJYsev8TqiXKsnWBiNExxhNigEwlwcGaKH+X4EN665yLWaNTdnMAELfIl/MSkYkA/NzjmTtmlW3PEhxNzTaolfItSdIvri6JZfj6Ki1BVsVyfmKoYz2GCzjRMQf8yqaArlCNVHcPJokXMtKh6MEEyYr+/fjSsoCsUL1he3uqDns5yTOSoHVhFIh/6oKaghT0OBZW/KhfDDABOqKqX6QnWwFV4KzTBwb0iwe/fPm/g2x9KFHPFO/YgsDNwRuiTq2IO1YMWYUHiOqdogYV3h7sbuP2kxjBXeWSa2gAppg6LTShORAQVNTRg+GbzGoeqDD1NZXFjCFNM51BBL2O5zIWdqceIFAw9TX2QUEznbVqQl7EcRnChEQRTMcwVzyRfuD1PwbAPhKEoCF3oBIl0DHOVBb0nKMUUpgi5r9AGB49aUT4lwxiKSdsadcnVNAmmZpir3NOHgjyqNU3I8BLQURYHdQmmZxhRbAMU3WRd1CUQKEKV1yVogGFEESpVE+lpB/iuwgziQjvTNsAwV/lF7z4VdauUJHsD/Gh4nYV+qm2CYRg0WkCjMYE/BSzacmls1Qj0ZhnmWB4OhUWiG/ePgC1cLD9ST9WMM8wVb4JHAMKYrZuCN0VzZg7rJlE5b4hhrkjT8LnYu9F0Ni3xS2JGOEhW7ppiWH5kzyeoWKmvxXAk1kwsWZO50QKOve8Cwz3Jx/F7VGi9COQ2WqsZQDbD+uhXEh0tfHqH45/dzevtvpV8+DcJReZtRBloZTZdQc2rNIG/lhlh4cPtGxS7/BV38c/uf5RpcDFowdXEkKHRXYRESHVUcmOf4Rvh7xLhUMqwTHMbUU81hCiK0KUB9UzqZjJiGBbE4lMqC1EUoWUFv5DqaHYMmZ6KaaWyEEUjZm7qUXrf7BiWabEoxmxFdyrGwmo3+MVDTCjMjGGO9qaOBGdTUmtoLMWvJkgXBnHJTHYMc7ngScXcWSmxORK20VVpyncXl81kyLBCnU2ef1T7i4wag+iF6RcT42YyliF1NoAQFfYTCXUhy9rvY6veLBlWaKko7MJ1G7EERR+sKsJMGYZC5DstCvm34IJZvhYvwmwZUiGKZWy8r7GEPxkrijBbhkyIguN34tpuY15JLVoW/lLoPWXLsHLlP5cQvC07huEXPp+hpjtTKezNMfxdpTquBA8sJGBxa1GiXgf7neQpt2mGB18V7parTECli1FT4fM0hKq1Lkwx3FdcHqaJzZSTiZWXMhQ8KXVNkywZvvmgSLAY7GQ8hh8ZA58GsS9ErcdthuHurho/r8QIWjZCAHdkzWHx08GOCyU/4zH8ebCvCvy7OPiq3ISrBAGDT8KkQV9IEajE48qmEO/V8fEQIbj/aU+VICuizoWHlrS/+cYAK5r1F2JiUPi6j7xW++anRhu1/AtUPFkdzCey1PMqKqkO8kLrjWL3zXudyxSDp+a9qSReCA0a+m2oKqkyCu8wHT34U6sTTtWUz9wkhiia4dE2lLTw2z5C8PajuhH6oN5UCOIEfSfphMuASkF/JrZ7oUvwxwFihK/faq9l+A94JAgGTdz4aEgjy6lpM/z8Gia4s69lhD7oUlSXixcOtpO/Jkg7+C6UclJ17H1HjfBv/YXvIDfl0xp0LVF0NDXzZlj4+wAhePtdzwh90HjBGyLaGeYdDe0+GjbDf7FI+PqfJJcLSiihSHQRV8On3XbwcnGyNV8MhX8wIzz4keR61BD5xgSWfM85g6XFr9FouPf7LUwwvy9bM8RRCSLiiMvFsCUaPjeg38SdQTMs/IkZ4eG7RARZL4N3NUh5IbrSQJtjlmO08P4QMcLdfMIr0kUafvuJfQIyFDPYwNEYVNLCW6Ro2tlXL5k4PEKPjqzQ8F8ETe8Mpt17n1AjVO1biChC6mdVQYZDLljQFo05V4ob4ZsP+pEwYhg4Uz4bIyBDwVyD+l6tRaMEcbcCxe7rFBelu6T4MAAXwW2OoRu43CtTDPEujkbfQgTN24RwAQZEvrdKi0NTwaLwB1oyJdsdFTIMwkWbf3awuuAzdPqphRmGha+oEer0LQCGf0EWBjcyLnlrDbbQmMq7v2FGeKhdMm2AFsF8Su2CSY2Q3AXWaoafsb6FyDDYP8THAXihFG7KGXE05voWIsML/yn5WA7XwHDSZoKhpG+RqGTaQJDU8BUinJgKMgwYGgn4BvsWAgKGfPEONxSFvMAUQ6N9CxEQQzj1FoonQwzxvsVhgr6FGsMq2KkRokXLDMN/bzEj/GyAH6ylmTLE+xb7PwzoKMwQ7rbB2WtaX2q8b8EjiBa8L4V3f/ELTzSnSXl/Wd/ChBGyiC9EC9CXwvn5RboHeI8Z4e43E/zCjimf08DxkN9oQrPXdJl34edWSqY10L1RfF4K5zR8u5S25FJVT1vpW3AMwWYbnJfCn0qzaiHrWxgiyCpgQTpg9STocuouxvtDrGRS3m8RC9rFUKvxhaZjEFNSrK1tqW/BMQw21fD7MeBDT/ioSffsqWxKhLEn6VsYCRSUob/j5IjfgACvAgsrOLQjnJTh1voWmyj7Dym26yGC4hb2lEU+1rfYuU1fMq0ILkD1Q/YqCIlpmlbU3odt9S02QMOh0MxGFoF5h0TDRbKGqaRv8bs5I8SChYOcx8vvS6ErpKdJGBZ+4Eu9BiUYulKhaEDWD3lZ0xWcZEszeN/iX5ME2a4owdEga8DIToUE993Dm4cm+hYr0MpCWBfE1vGP4N0m+pnptvsWK9CslFc+/C093pnSGkQ/b8P3WxjpW6yB5mz8Xi5kCfiVuL5B38rTNsRt9y3WQPfr8z00/NUgXtosNdC869b7FivQeC8uz6M7vcWPBob4l5aaSvoWKZZ6YdBoKG6pxAi+esWfPkcjp17y/R4zQlN9izXQN4P4ZUG6pRIGn9WwV4J0borutzBZMjHQVZkaL0LZZn1R3kGdpVHn733EjPDwN/7kRByqx/EFb5IKZ7nI3gtC3l1QV1PcCPM733ZVofRmVy7chyEonoMTBN4omeqp6fvXSMnkU1SGIkPqSYXaEO7oh0DeClLdvYc3D7WgyJDuYxfeW4ZXuEMgb4KpvjSD9i22wzB4ZL6uiDtPiX87z3KDH6uVwWjfYisM6S4MwXXEnTrAp3is1FLa+5XtO6TMzwivyca9zS24XvaVqOzBzJYhXbAAXgmNO/RLOFGB+hqVtmnGbzoH1b3gZ+KPxuB3t4VdnfhbZsuQncMjnO0Yf0aNeDgNFfvkuZ04EIhQ8P1oeb8G4TQNttr4vGTIRCiECrz4XUHITZkQ4y0x05M/EBGqnJssHsDDhBi7hy9DhnS/nihCtXOUhEMHmBBj8+8MGdLCEBBhQ4WheLoJ29kQ13TLjiFtsYkHzVi22rgr4JgwpWOUMpRh8JziWUFYN5+HKHwWRmMiRnanmQU9xCPxxH/85VEO4vGzLI7KnU1WDNnhkOKJXbEnt0QQz3i17ODbkVdRWTEsB24GOvpQ/Rxa8Zxrh0ZSqZ4WPhy+RiE04Hbwz97KT4a8QRTN0RhVKlpiGEplhWLh+1sUP79xFHc+/8Q/LXs/gZ2BdZxKhEAo9XK5wBFLX/QS5pCsATihNVGvjR1CC5zFrepIKQAlZ2d5J9ybYeqU3fAgYdGOLIWcex3QMbvUnyY6CtrcScl0mgcwWER3wBVwVLLF9PxXomVvQ6dd02QG8BP60wOAU/XDI9mTvEZjhiGLhNBgEf1hLEDGEJriQHV8jmmGdJ0CHNpgS1ZjMIBHu9Ntm7OnOVe//EjHlI2g4QhJhs10gTlITBf0HaoBhmV6aBIUCRPOtIRGEIRDZrQppmdYLtM4Ac1h0TyPPQJ0LStPo47u68GpGZYrlCA8GibphDkgKOarl0dJpJiWYSjBDjREN/msxxo0t97uhxR1PGpKhuUctcEOMJQikR8NAURWL2awrvKsrEExHcMK86ItGxpA5SQY5B4BHFjnzKkUBxozrVIxDIc9dUrQoMeUg9fA0Xn2JfvW1OeSpWEYziTruCBBrZJCBGiKeTucby4bBmGKYTjksQ6OmkxjhOF1gcvmqxbzzzeK/qbw4YCD4m6ESo7N6u6BBK1SGiOkgAcrWqH2Kw+xTLajpMhMEBn3ambWKjwzPprT6RWMW5kk62M1hhQZXG9ojjyU6fpXD9/x29ow2eI9mwhcm8Mjl42Nde5DDjWfd/thQr8VMVYqoQDrNvwARKO5JkctDw4czlcjJZnpzLNUQrl4FzfS2U0/RzZCy4IpWiRakLx5NMqxeH8d3hsby+2mjhMbFB2YYt6ZRhmFweHjxcdw7LhX4CCj1R2jBJGMkIqxHa1oTcpGOK7xa3URDTVO0M/qEYp5J79y2ZNcWp9TXuPnBUFEgFsg6H2dYNpLxdhdxd3T+2IKQVaKv66jS/WmiAWatsGIYh722XnfqbZXydPsqpJMkOVi7mEQXaaDKujaXHfDqMEj3KnWkOVagnh6p03S+4O7m9UVOiNUQU3GQQFdVG08ju46R49kuVhRZFmuFHNna/RedU4Iqi8Gho3LAI2qDWE5pLnRtbx+WBTjWJY9dpVfk9n639VHMn6WxgC5JDjHjcOXIxlxBff15O6x4vGscC2PskfN//nF2SY7LwDOJfrpmbyddICzKsbS++dtMj3n28+D2c3k6m5xkStGyF0s7h5Ob2b81TtNh2AuO4DbT18PxqHVh/P8EJZLukOsxz4YzGaDAfLLzvGUQL20tWuTZMObddGUaqqHkkfyXFOZxst+DD3vuobKwXj0XIkniEi6J0O1Avyoft4lBM2ZIpB+kuWXZGjJwkYIy3ZJfnTck9KsD5ddh7hS22aXS9tU00RD7hCix6o6hJDL0XLYG3darVrNy9KParVWqz7uNZqjKSGuU0LeBNuEO922D+XR6sdZ4xpP23GJD9fvTZbC/zjC1DQUpYxczCaGDp7EoVx96P8V6WctQIpaWx4bTcFxtpvFyODl/0rmmAY2WaptGt0Sxpfq5pgEVTLKLkQgGJa2x7FEuk9jgBwa+e1wrD4Tfj6GU+M+x6vFRs+Gn4/xKDar1OJHnOaT2x+PTpMYEqQnvsvhk/pPFL0RAZdptejZJL98Vuq5idqwm0aSnvTsdrpl+QxQG45USiGRXdUrRZrPnh7FkV/OEo3E2i+0qqPGM1ZOAK3e8cj1qwlgF+c6t6DSmH5p1J+na4lDa3x+0s8HlZJdLa2qCqtUsoOKyp12m/9Vcmuo1Xvny/ZofmkRCnfa7560l8NxZ/uNsxe84AUveMELXvD/gf8BTL86x58PCmYAAAAASUVORK5CYII=",
          mining_type: MiningType.all.sample
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by(coin)
      end
    end
  end

  desc "Cadastro de tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando Tipos de Mineração") do
      mining_types = 
      [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Service", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}

        
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by(mining_type)
      end
    end
  end

  def show_spinner(msg_start = "Executando", msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}...")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
