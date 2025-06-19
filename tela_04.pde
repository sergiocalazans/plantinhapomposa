// Função para exibir a tela de explicação após uma questão
void mostrarExplicacao() {
  // --- Título "EXPLICANDO" COM BORDA ---
  String titulo = "EXPLICANDO";
  int tituloX = width / 2;
  int tituloY = 40;

  textSize(35);
  textAlign(CENTER, TOP);

  fill(corCaixaBorda);
  bordaTexto(titulo, tituloX, tituloY, 2);

  fill(corTextoTitulo);
  text(titulo, tituloX, tituloY);

  // --- Caixa para vídeo ---
  float caixaX = 50;
  float caixaY = 100;
  float caixaLargura = 425;
  float caixaAltura = 300;

  strokeWeight(8);
  stroke(corCaixaBorda);
  fill(#000000);
  rect(caixaX, caixaY, caixaLargura, caixaAltura);

  // Exibe o vídeo, se estiver carregado corretamente
  if (perguntaAtual >= 0 && perguntaAtual < videos.length && videos[perguntaAtual] != null &&
      videos[perguntaAtual].width > 0 && videos[perguntaAtual].height > 0) {
    image(videos[perguntaAtual], caixaX, caixaY, caixaLargura, caixaAltura);
  }

  // --- Texto explicativo ---
  textSize(22);
  fill(corTextoGeral);
  textAlign(CENTER, TOP);
  text("ESTE VIDEO EXPLICA A QUESTAO QUE VOCE\nACABOU DE RESOLVER.", width / 2, caixaY + caixaAltura + 30);

  // --- Botão de continuar ou ver resultado ---
  String textoBotao = fimDoQuiz ? "RESULTADO" : "CONTINUAR";

  desenharBotao(
    corBordaBotao,
    corFundoBotao,
    corTextoBotao,
    larguraBotao,
    alturaBotao,
    raioBotao,
    150,
    600,
    textoBotao
  );
}
