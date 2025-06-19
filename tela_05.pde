// Variáveis globais para controlar a animação da flor
int florAtual = 0;
int tempoUltimaFlor = 0;
int intervalo = 400;

void desenharFlor(int pontos) {
  background(255);
  scale(1.25);

  // Calcula quantas flores devem ser exibidas proporcionalmente à pontuação
  int floresParaMostrar = int((pontos / 7.0) * 12);
  floresParaMostrar = constrain(floresParaMostrar, 0, flores.length); // Garante que não ultrapasse o tamanho do array

  // Atualiza a flor que deve aparecer com base no tempo
  if (florAtual < floresParaMostrar && millis() - tempoUltimaFlor > intervalo) {
    florAtual++;
    tempoUltimaFlor = millis();
  }

  // Desenha as flores já "reveladas"
  for (int i = 0; i < florAtual; i++) {
    if (i < flores.length && flores[i] != null) {
      image(flores[i], 0, 0);
    }
  }

  // Botão de pontuação final
  int botaoX = width / 5;
  int botaoY = 20;
  int largura = 180;
  int altura = 40;
  int raio = 20;
  String texto = "Pontuação Final: " + pontos + "/7";

  desenharBotao(corBordaBotao, corFundoBotao, corTextoBotao, largura, altura, raio, botaoX, botaoY, texto);
}
