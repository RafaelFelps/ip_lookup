#!/bin/bash

# Verifica se o usuário passou um IP como parâmetro
if [ -z "$1" ]; then
    echo "Por favor, informe um endereço IP como parâmetro."
    exit 1
fi

# Armazena o endereço IP em uma variável
ip="$1"

# Verifica se o IP é válido
if ! [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Endereço IP inválido."
    exit 1
fi

# Define o caminho da wordlist a ser utilizada
wordlist="/path/to/wordlist.txt"

# Loop que percorre a wordlist em busca de diretórios
while read diretorio; do
    url="http://$ip/$diretorio/"
    resposta=$(curl -s -o /dev/null -w "%{http_code}" $url)
    if [ "$resposta" == "200" ]; then
        echo "Diretório encontrado: $url"
    fi
done < "$wordlist"
