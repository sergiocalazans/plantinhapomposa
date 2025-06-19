// Cria uma lista de botões que representam as opções de resposta do quiz
ArrayList<Botao> botoesOpcoes = new ArrayList<Botao>();

// Classe Botao representa um botão na tela do questionário
class Botao {
  int x, y, largura, altura, indice; // Posição, tamanho e índice identificador do botão

  // Construtor do botão: define posição, tamanho e índice
  Botao(int x, int y, int largura, int altura, int indice) {
    this.x = x;
    this.y = y;
    this.largura = largura;
    this.altura = altura;
    this.indice = indice;
  }

  // Verifica se o botão foi clicado com base nas coordenadas do mouse
  boolean clicado(int mx, int my) {
    return mx >= x && mx <= x + largura && my >= y && my <= y + altura;
  }
}


// Função para desenhar um botão com texto adaptável e visual personalizado
void desenharBotao(color corBordaBotao, color corFundoBotao, color corTextoBotao,
                   int larguraBotao, int alturaBotao, int raioBotao,
                   int x, int y, String texto) {
  // Define a espessura da borda do botão
  strokeWeight(4);

  // Define a cor da borda do botão
  stroke(corBordaBotao);

  // Define a cor de fundo do botão
  fill(corFundoBotao);

  // Desenha o botão com cantos arredondados
  rect(x, y, larguraBotao, alturaBotao, raioBotao);

  // Centraliza o texto no centro do botão
  textAlign(CENTER, CENTER);

  // Tamanho máximo e mínimo para o texto
  int tamanhoMax = 18;
  int tamanhoMin = 8;
  int tamanhoAtual = tamanhoMax;

  // Aplica o tamanho de texto inicial
  textSize(tamanhoAtual);

  // Reduz o tamanho do texto até ele caber dentro do botão (com margem de 20 pixels)
  while (textWidth(texto) > larguraBotao - 20 && tamanhoAtual > tamanhoMin) {
    tamanhoAtual--;
    textSize(tamanhoAtual);
  }

  // Define a cor do texto
  fill(corTextoBotao);

  // Desenha o texto centralizado no botão, com leve ajuste vertical (+2)
  text(texto, x + larguraBotao / 2, y + alturaBotao / 2 + 2);
}


// Função auxiliar que verifica se o mouse clicou dentro da área de um botão
boolean clicouNoBotao(int x, int y) {
  // Retorna true se a posição do mouse estiver dentro da área do botão
  return mouseX > x && mouseX < x + larguraBotao &&
         mouseY > y && mouseY < y + alturaBotao;
}
