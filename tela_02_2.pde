void mostrarInstrucoes() {
  // Título principal da tela de instruções
  String titulo = "INSTRUÇÕES";
  
  // Define as coordenadas de exibição do título, centralizado horizontalmente
  int tituloX = width/2;
  int tituloY = 40;
  
  // Texto explicativo que será mostrado na tela
  String texto = "Ao prosseguir, aparecerá a primeira questão do jogo. Abaixo da questão, há alternativas para responder (uma escolha). Após responder, virá a tela de explicação da questão com um vídeo e um texto. Ao apertar no botão continuar, segue para a próxima questão. No final do questionário, você saberá se a planta cresceu e sua pontuação.";

  // Define tamanho da fonte para o título
  textSize(35);
  textAlign(CENTER, TOP); // Alinha o texto ao centro horizontal e ao topo vertical

  // Desenha a borda do título com cor personalizada e 2px de espessura
  fill(corCaixaBorda);
  bordaTexto(titulo, tituloX, tituloY, 2);

  // Escreve o título por cima da borda com a cor principal
  fill(corTextoTitulo);
  text(titulo, tituloX, tituloY);

  // Define a posição e tamanho da "caixa de texto" que conterá as instruções
  int caixaX = 50;
  int caixaY = 100;
  int caixaLargura = 400;
  int caixaAltura = 400; // Altura ideal para textos longos ou vídeos curtos

  // Desenha a caixa de texto com o conteúdo explicativo
  caixaTexto(
    20,              // Tamanho da fonte
    texto,           // Texto a ser exibido
    corCaixaTexto,   // Cor de fundo da caixa
    corTextoGeral,   // Cor do texto
    corCaixaBorda,   // Cor da borda da caixa
    caixaX, caixaY,  // Posição (x, y) da caixa
    caixaLargura, caixaAltura // Tamanho da caixa
  );

  // Desenha o botão "CONTINUAR" na parte inferior da tela
  desenharBotao(
    corBordaBotao,  // Cor da borda do botão
    corFundoBotao,  // Cor de fundo
    corTextoBotao,  // Cor do texto
    larguraBotao,   // Largura do botão (provavelmente definido globalmente)
    alturaBotao,    // Altura
    raioBotao,      // Raio de arredondamento dos cantos
    150, 600,       // Posição (x, y)
    "CONTINUAR"     // Texto do botão
  );
}
