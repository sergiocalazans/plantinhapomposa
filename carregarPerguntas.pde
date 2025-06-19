// Função que carrega as perguntas de um arquivo JSON e preenche a lista de perguntas do quiz
void carregarPerguntas(String caminhoArquivo) {
  // Limpa a lista de perguntas existente, caso já tenha sido preenchida antes
  perguntas.clear();

  // Carrega o conteúdo do arquivo JSON para a variável 'perguntasJSON'
  perguntasJSON = loadJSONArray(caminhoArquivo);

  // Percorre cada objeto do array JSON
  for (int i = 0; i < perguntasJSON.size(); i++) {
    // Obtém o objeto JSON na posição i (representa uma pergunta)
    JSONObject obj = perguntasJSON.getJSONObject(i);

    // Lê o ID da pergunta
    int id = obj.getInt("id");

    // Lê o texto da pergunta
    String pergunta = obj.getString("pergunta");

    // Lê o array de opções de resposta
    JSONArray opcoesJSON = obj.getJSONArray("opcoes");

    // Converte o JSONArray de opções em um array de Strings
    String[] opcoes = new String[opcoesJSON.size()];
    for (int j = 0; j < opcoesJSON.size(); j++) {
      opcoes[j] = opcoesJSON.getString(j);
    }

    // Lê o índice da opção correta
    int correta = obj.getInt("correta");

    // Cria um novo objeto da classe Pergunta com os dados extraídos
    Pergunta p = new Pergunta(id, pergunta, opcoes, correta);

    // Adiciona a pergunta à lista principal do jogo
    perguntas.add(p);
  }
}
