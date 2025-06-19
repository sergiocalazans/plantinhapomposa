// Função para quebrar uma string de texto em múltiplas linhas,
// garantindo que nenhuma linha exceda uma largura máxima especificada.
String[] wrapTextToLines(String texto, float larguraMax) {
  // Divide o texto original em um array de palavras, usando o espaço como delimitador.
  // "splitTokens" é mais robusto que "split" para múltiplos espaços e espaços no início/fim.
  String[] palavras = splitTokens(texto, " ");
  // Cria um ArrayList para armazenar as linhas resultantes.
  // ArrayList é usado porque não sabemos o número de linhas de antemão.
  ArrayList<String> linhas = new ArrayList<String>();
  // String para construir a linha atual que está sendo processada.
  String linhaAtual = "";

  // Itera sobre cada palavra do texto.
  for (String palavra : palavras) {
    // Tenta adicionar a palavra atual à linhaAtual.
    // Se linhaAtual estiver vazia, a tentativa é apenas a palavra.
    // Caso contrário, é linhaAtual + um espaço + a palavra.
    String tentativa = linhaAtual.equals("") ? palavra : linhaAtual + " " + palavra;

    // Verifica se a largura da 'tentativa' (em pixels) é menor ou igual à largura máxima permitida.
    // IMPORTANTE: textSize() deve ter sido definido ANTES de chamar esta função
    // para que textWidth() funcione corretamente.
    if (textWidth(tentativa) <= larguraMax) {
      // Se couber, a 'tentativa' se torna a nova 'linhaAtual'.
      linhaAtual = tentativa;
    } else {
      // Se não couber:
      // 1. Adiciona a 'linhaAtual' (que continha as palavras que cabiam) à lista de 'linhas',
      //    mas apenas se 'linhaAtual' não estiver vazia (evita adicionar linhas em branco se uma palavra for muito longa).
      if (!linhaAtual.equals("")) {
        linhas.add(linhaAtual);
      }
      // 2. A 'palavra' atual (que não coube na linha anterior) inicia uma nova 'linhaAtual'.
      //    Nota: Se uma única palavra for mais longa que 'larguraMax', ela ficará sozinha em uma linha
      //    e ainda excederá 'larguraMax'. Esta função não quebra palavras.
      linhaAtual = palavra;
    }
  }

  // Após o loop, adiciona a última 'linhaAtual' que foi construída à lista de 'linhas',
  // se ela não estiver vazia.
  if (!linhaAtual.equals("")) {
    linhas.add(linhaAtual);
  }

  // Converte o ArrayList de linhas para um array de String padrão e o retorna.
  return linhas.toArray(new String[linhas.size()]);
}


// Função para desenhar uma "borda" ou "contorno" ao redor de um texto.
// Isso é feito desenhando o mesmo texto várias vezes com pequenos deslocamentos.
void bordaTexto(String texto, int textoX, int textoY, int espessuraBorda) {
  // Itera em um quadrado ao redor da posição original do texto.
  // 'dx' e 'dy' são os deslocamentos horizontal e vertical.
  // 'espessuraBorda' (passado como 'i' no código original) define o quão "grossa" ou "afastada" a borda será.
  for (int dx = -espessuraBorda; dx <= espessuraBorda; dx++) {
    for (int dy = -espessuraBorda; dy <= espessuraBorda; dy++) {
      // Desenha o texto deslocado, exceto na posição exata do texto original (dx=0 e dy=0).
      // Isso garante que o texto da borda não se sobreponha perfeitamente ao texto principal
      // que será desenhado depois.
      // A cor de preenchimento (fill) deve ser definida ANTES de chamar esta função para ser a cor da borda.
      if (dx != 0 || dy != 0) { // Não desenha no centro exato (0,0 offset)
        text(texto, textoX + dx, textoY + dy);
      }
    }
  }
}

// Função para desenhar uma caixa de texto com texto formatado e centralizado dentro dela.
void caixaTexto(int textoTamanho, String texto, color corCaixa, color corTexto, color corBorda,
                  int caixaX, int caixaY, int caixaLargura, int caixaAltura) {
  
  // --- Desenha a caixa (retângulo de fundo) ---
  strokeWeight(6);        // Define a espessura da borda da caixa.
  stroke(corBorda);       // Define a cor da borda da caixa.
  fill(corCaixa);         // Define a cor de preenchimento da caixa.
  // Desenha o retângulo da caixa com cantos arredondados (raio de 20).
  rect(caixaX, caixaY, caixaLargura, caixaAltura, 20);

  // --- Prepara para desenhar o texto ---
  textSize(textoTamanho);   // Define o tamanho da fonte para o texto.
  // Define o espaçamento entre linhas (leading). Se o texto tiver múltiplas linhas,
  // elas terão 28 pixels de distância vertical entre suas bases (ou topos, dependendo do textAlign).
  textLeading(28);
  fill(corTexto);         // Define a cor do texto.

  // --- Quebra o texto em linhas e calcula o posicionamento vertical ---
  // Quebra o texto original em linhas que caibam na largura da caixa,
  // subtraindo 40 pixels da largura da caixa para criar uma margem interna (20px de cada lado).
  String[] linhas = wrapTextToLines(texto, caixaLargura - 40);
  // Calcula a altura total que o bloco de texto ocupará, multiplicando o número de linhas pelo espaçamento.
  float alturaTextoTotal = linhas.length * 28; // Usando o textLeading definido
  // Calcula a posição Y inicial para o texto, de forma a centralizá-lo verticalmente dentro da caixa.
  float yTextoInicial = caixaY + (caixaAltura - alturaTextoTotal) / 2;

  // Define o alinhamento do texto.
  // CENTER: O texto será centralizado horizontalmente em relação à coordenada X fornecida.
  // TOP: A coordenada Y fornecida para 'text()' se referirá ao topo da linha de texto.
  textAlign(CENTER, TOP);
  
  // --- Desenha cada linha de texto ---
  for (int i = 0; i < linhas.length; i++) {
    // Desenha a linha atual.
    // Posição X: centro horizontal da caixa (caixaX + caixaLargura / 2).
    // Posição Y: yTextoInicial (topo do bloco de texto) mais o deslocamento para a linha atual (i * 28).
    text(linhas[i], caixaX + caixaLargura / 2, yTextoInicial + i * 28);
  }
}
