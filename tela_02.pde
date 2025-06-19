void mostrarSobre(color corCaixaTexto, color corCaixaBorda, color corTextoTitulo, color corTextoGeral) {
  // Define o título da tela "Sobre o Projeto"
  String titulo = "SOBRE O PROJETO";
  int tituloX = 60;
  int tituloY = 50;

  // Define o tamanho do texto do título
  textSize(35);
  textAlign(LEFT, TOP); // Alinha o texto à esquerda e ao topo

  // Desenha o contorno do título chamando uma função personalizada
  fill(corCaixaBorda); // Usa a cor da borda para o efeito de sombra ou contorno
  bordaTexto(titulo, tituloX, tituloY, 2); // Desenha o texto com um contorno de 2px de espessura

  // Desenha o texto do título por cima do contorno
  fill(corTextoTitulo); // Define a cor principal do título (normalmente mais clara)
  text(titulo, tituloX, tituloY); // Escreve o título na tela

  // Define o texto explicativo que será mostrado dentro de uma "caixa de texto"
  String texto = "O projeto irá abordar o tema de sustentabilidade e meio ambiente, apresentando uma plantinha para determinar o seu avanço. Ao abrir o aplicativo e iniciar, vai ser apresentado um questionário sobre os temas listados acima, e ao acertar uma pergunta a planta irá crescer. Caso erre, a planta irá perder uma folha, encerrando o aplicativo caso cometa três erros.";

  // Mostra o texto explicativo dentro de uma caixa estilizada
  caixaTexto(
    22,            // Tamanho do texto
    texto,         // O texto a ser exibido
    corCaixaTexto, // Cor de fundo da caixa de texto
    corTextoGeral, // Cor do texto dentro da caixa
    corCaixaBorda, // Cor da borda da caixa
    50, 100,       // Posição (x, y) da caixa
    400, 500       // Largura e altura da caixa
  );

  // Desenha o botão "VOLTAR" para retornar à tela inicial
  desenharBotao(
    corBordaBotao,   // Cor da borda do botão
    corFundoBotao,   // Cor de fundo
    corTextoBotao,   // Cor do texto
    larguraBotao,    // Largura do botão
    alturaBotao,     // Altura
    raioBotao,       // Arredondamento dos cantos
    150, 620,        // Posição (x, y)
    "VOLTAR"         // Texto do botão
  );
}
