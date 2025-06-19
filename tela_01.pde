// Função para desenhar o conteúdo da tela inicial.
void mostrarInicio(color corTextoBorda) {
  // Define o título do jogo, com quebra de linha entre as palavras
  String titulo = "PLANTINHA\nPOMPOSA";
  
  // Define a cor da borda do texto e desenha uma borda ao redor do título
  fill(corTextoBorda);
  bordaTexto(titulo, width / 2, 150, 4); // Essa função personalizada desenha uma borda em torno do texto (não mostrada aqui, mas provavelmente faz sombra ou contorno)

  // Define a cor do texto principal
  fill(#f6f3cb); // Cor clara (provavelmente marfim) para o texto do título
  textAlign(CENTER, CENTER); // Centraliza o texto horizontal e verticalmente

  // Desenha o título centralizado na tela, com a palavra "PLANTINHA" em cima de "POMPOSA"
  text(titulo, width / 2, 150);

  // Desenha os botões da tela inicial usando a função personalizada 'desenharBotao'

  // Botão "INICIAR" – inicia o quiz
  desenharBotao(
    corBordaBotao,    // Cor da borda do botão
    corFundoBotao,    // Cor do fundo do botão
    corTextoBotao,    // Cor do texto do botão
    larguraBotao,     // Largura do botão
    alturaBotao,      // Altura do botão
    raioBotao,        // Raio dos cantos arredondados
    xBotaoIniciar,    // Posição X do botão
    yBotaoIniciar,    // Posição Y do botão
    "INICIAR"         // Texto exibido no botão
  );

  // Botão "SOBRE O PROJETO" – leva à tela com informações sobre o projeto
  desenharBotao(
    corBordaBotao,
    corFundoBotao,
    corTextoBotao,
    larguraBotao,
    alturaBotao,
    raioBotao,
    xBotaoSobre,
    yBotaoSobre,
    "SOBRE O PROJETO"
  );
}
