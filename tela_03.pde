// Variáveis globais para controlar o comportamento da rolagem (scroll)
float scrollOffset = 0; // Deslocamento vertical atual do conteúdo devido à rolagem
float scrollVelocidade = 20; // Quantidade de pixels que o conteúdo rola a cada evento da roda do mouse

// Variáveis para a barra de rolagem e sua interação
boolean arrastandoScroll = false; // Indica se o usuário está atualmente arrastando o ponteiro da barra de rolagem
float scrollBarX, scrollBarY, scrollBarLargura = 15, scrollBarAltura; // Posição (X,Y), largura e altura da trilha da barra de rolagem
float scrollPointerY, scrollPointerAltura = 50; // Posição Y e altura do ponteiro (a parte móvel) da barra de rolagem

float conteudoAlturaTotal = 0; // Altura total de todo o conteúdo que pode ser rolado (pergunta + opções)

// Função para exibir uma pergunta específica e suas opções
void mostrarPergunta(Pergunta perguntaAtual) {
  // Definições de layout para a caixa da pergunta
  int caixaPerguntaX = 50; // Posição X da caixa da pergunta
  int caixaPerguntaLargura = width - 100; // Largura da caixa da pergunta (tela inteira menos margens)
  int paddingLateral = 20; // Espaçamento interno lateral dentro das caixas de texto
  int paddingVertical = 15; // Espaçamento interno vertical dentro das caixas de texto

  pushMatrix(); // Salva a matriz de transformação atual (para isolar o efeito do translate)
  translate(0, -scrollOffset); // Aplica o deslocamento da rolagem a todo o conteúdo desenhado abaixo

  // --- Caixa da pergunta ---
  String textoPergunta = perguntaAtual.pergunta; // Obtém o texto da pergunta do objeto Pergunta
  int tamanhoFontePergunta = 14; // Tamanho inicial da fonte para o texto da pergunta
  String[] linhasPergunta; // Array para armazenar as linhas do texto da pergunta após a quebra de linha

  // Loop para ajustar o tamanho da fonte da pergunta dinamicamente
  // O objetivo é fazer o texto caber em uma altura máxima (220px) ou até a fonte ficar muito pequena (10px)
  while (true) {
    textSize(tamanhoFontePergunta); // Define o tamanho da fonte para cálculo
    // Quebra o texto da pergunta em múltiplas linhas para caber na largura da caixa
    // (Assumindo que wrapTextToLines é uma função auxiliar definida em outro lugar)
    linhasPergunta = wrapTextToLines(textoPergunta, caixaPerguntaLargura - paddingLateral * 2);
    float alturaTexto = linhasPergunta.length * (tamanhoFontePergunta + 4); // Calcula a altura total do texto (considerando um pequeno espaçamento entre linhas)
    if (alturaTexto <= 220 || tamanhoFontePergunta <= 10) break; // Condição de parada: texto cabe ou fonte mínima atingida
    tamanhoFontePergunta--; // Reduz o tamanho da fonte para a próxima iteração
  }

  // Calcula a altura final da caixa da pergunta com base no número de linhas e no tamanho da fonte final
  int alturaCaixaPergunta = int(linhasPergunta.length * (tamanhoFontePergunta + 10) + paddingVertical * 4);

  // Desenha a caixa de texto para a pergunta
  // (Assumindo que caixaTexto é uma função auxiliar definida em outro lugar para desenhar caixas com texto)
  caixaTexto(tamanhoFontePergunta, textoPergunta, corCaixaTexto, corTextoGeral, corCaixaBorda,
             caixaPerguntaX, 50, caixaPerguntaLargura, alturaCaixaPergunta);

  botoesOpcoes.clear();  // Limpa a lista de botões de opções antes de redesenhá-los (evita duplicatas a cada frame)
  int espacamentoVertical = 30; // Espaçamento vertical entre os botões de opção

  // Posições iniciais para os botões de opção
  int caixaY = 50; // Posição Y inicial da caixa da pergunta (referência)
  int caixaAltura = alturaCaixaPergunta; // Altura calculada da caixa da pergunta
  int yBotao = caixaY + caixaAltura + 20; // Posição Y inicial do primeiro botão de opção (abaixo da pergunta)

  textSize(12); // Define o tamanho da fonte para as opções
  String[] opcoesFormatadas = new String[perguntaAtual.options.length]; // Array para armazenar os textos formatados das opções
  float larguraMaximaTexto = 0; // Variável para rastrear a largura da opção mais longa

  // Primeiro loop pelas opções: formata o texto e calcula a largura máxima necessária para os botões
  for (int i = 0; i < perguntaAtual.options.length; i++) {
    String texto = (char)('A' + i) + ") " + perguntaAtual.options[i]; // Formata a opção (ex: "A) Opção 1")
    opcoesFormatadas[i] = texto;
    float larguraTexto = textWidth(texto); // Calcula a largura do texto da opção
    if (larguraTexto > larguraMaximaTexto) {
      larguraMaximaTexto = larguraTexto; // Atualiza a largura máxima se a atual for maior
    }
  }

  // Calcula a largura dos botões de opção
  // Usa a largura máxima do texto, adiciona padding, e restringe a um mínimo (200) e máximo (largura da tela - margens)
  int larguraBotao = int(constrain(larguraMaximaTexto + paddingLateral * 2, 200, width - 100));
  int xBotao = (width - larguraBotao) / 2; // Centraliza os botões de opção na tela

  // Segundo loop pelas opções: desenha cada botão de opção
  for (int i = 0; i < opcoesFormatadas.length; i++) {
    String texto = opcoesFormatadas[i]; // Pega o texto formatado da opção
    // Quebra o texto da opção em múltiplas linhas se necessário
    String[] linhas = wrapTextToLines(texto, larguraBotao - paddingLateral * 2);
    // Calcula a altura do botão com base no número de linhas e um espaçamento fixo por linha
    int alturaBotao = int(linhas.length * 18 + paddingVertical * 4);

    // ATENÇÃO: yBotaoComScroll não é usado para desenhar com caixaTexto, pois o translate já cuida do scroll.
    // yBotaoComScroll é a coordenada Y REAL do botão na tela, considerando o scroll.
    // É útil para detecção de mouse, por exemplo, se Botao precisar dessa coordenada.
    // A função caixaTexto desenha em (xBotao, yBotao) no sistema de coordenadas JÁ transladado.
    int yBotaoComScroll = yBotao - int(scrollOffset); // Calcula a posição Y do botão considerando o scroll (para lógica de clique, não desenho)

    // Desenha a caixa de texto para a opção atual
    caixaTexto(12, texto, corFundoBotao, corTextoBotao, corBordaBotao,
               xBotao, yBotao, larguraBotao, alturaBotao);

    // Adiciona um novo objeto Botao à lista de botões de opções.
    // Este objeto provavelmente armazena a posição e dimensões para detecção de cliques.
    // A posição Y fornecida aqui (yBotaoComScroll) é a posição *real* na tela.
    // Se a detecção de clique for feita dentro do push/popMatrix, então yBotao seria mais apropriado
    // e o clique seria testado contra mouseY - (-scrollOffset), ou seja, mouseY + scrollOffset.
    // A forma como está, Botao provavelmente espera coordenadas de tela absolutas.
    botoesOpcoes.add(new Botao(xBotao, yBotaoComScroll, larguraBotao, alturaBotao, i));

    yBotao += alturaBotao + espacamentoVertical; // Atualiza a posição Y para o próximo botão
  }

  popMatrix(); // Restaura a matriz de transformação original (remove o efeito do translate)
  
  // --- Barra de rolagem lateral ---
  // Define a posição e dimensões da trilha da barra de rolagem
  scrollBarX = width - scrollBarLargura - 10; // Posição X (à direita, com uma pequena margem)
  scrollBarY = 50; // Posição Y (começa abaixo do topo da tela)
  scrollBarAltura = height - 100; // Altura (ocupa a maior parte da altura da tela, com margens)
  
  // Calcula a altura total do conteúdo que pode ser rolado
  // É a posição Y final do último elemento (yBotao) menos a posição Y inicial do primeiro elemento (50, onde a pergunta começa)
  conteudoAlturaTotal = yBotao - 50; // yBotao aqui é o y do *próximo* botão, então já inclui a altura do último + espaçamento

  // Se o conteúdo total é menor que a área visível da janela, não há necessidade de rolagem.
  // Neste caso, a "altura total do conteúdo" é considerada como a altura da área visível para evitar divisões por zero ou lógicas estranhas.
  // A área visível aqui é (height - 100), que corresponde à altura da scrollBar.
  if (conteudoAlturaTotal < height - 100) {
    conteudoAlturaTotal = height - 100; // Efetivamente desabilita a rolagem se o conteúdo couber
  }

  // Garante que o scrollOffset (deslocamento) não ultrapasse os limites do conteúdo
  // O limite superior é a altura total do conteúdo menos a altura da área visível.
  scrollOffset = constrain(scrollOffset, 0, conteudoAlturaTotal - (height - 100));

  // Desenha o fundo (trilha) da barra de rolagem
  fill(200); // Cor cinza claro
  noStroke(); // Sem borda
  rect(scrollBarX, scrollBarY, scrollBarLargura, scrollBarAltura, 8); // Retângulo com cantos arredondados
  
  // Calcula a altura do ponteiro (a parte móvel) da barra de rolagem
  // É proporcional à quantidade de conteúdo visível em relação ao conteúdo total
  float proporcaoVisivel = scrollBarAltura / conteudoAlturaTotal;
  scrollPointerAltura = constrain(scrollBarAltura * proporcaoVisivel, 30, scrollBarAltura); // Altura mínima de 30px, máxima igual à altura da barra
  
  // Calcula a posição Y do ponteiro da barra de rolagem
  // Mapeia o scrollOffset (que varia de 0 ao máximo deslocamento possível)
  // para a posição Y dentro da trilha da barra de rolagem.
  scrollPointerY = scrollBarY + map(scrollOffset, 0, conteudoAlturaTotal - (height - 100), 0, scrollBarAltura - scrollPointerAltura);
  
  // Desenha o ponteiro da barra de rolagem
  fill(100); // Cor cinza escuro
  rect(scrollBarX, scrollPointerY, scrollBarLargura, scrollPointerAltura, 8); // Retângulo com cantos arredondados
}


// Função chamada automaticamente quando o botão do mouse é solto
void mouseReleased(){
  arrastandoScroll = false; // Define que o usuário não está mais arrastando a barra de rolagem
}

// Função chamada automaticamente quando o mouse é arrastado (movido com o botão pressionado)
void mouseDragged(){
  // Verifica se o arraste da barra de rolagem foi iniciado (arrastandoScroll == true)
  // (Presume-se que arrastandoScroll é setado para true em mousePressed quando o clique é sobre o ponteiro)
  if (arrastandoScroll) {
    // Calcula a posição Y do mouse relativa ao início da trilha da barra de rolagem
    // e a restringe aos limites da trilha onde o ponteiro pode se mover.
    float mouseRelativo = constrain(mouseY - scrollBarY, 0, scrollBarAltura - scrollPointerAltura);
    
    // Mapeia a posição relativa do mouse na trilha da barra para o scrollOffset do conteúdo.
    scrollOffset = map(mouseRelativo, 0, scrollBarAltura - scrollPointerAltura,
                       0, conteudoAlturaTotal - (height - 100));
                       
    // Garante novamente que o scrollOffset permaneça dentro dos limites válidos.
    scrollOffset = constrain(scrollOffset, 0, conteudoAlturaTotal - (height - 100));
  }
}

// Função chamada automaticamente quando a roda do mouse é girada
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // Obtém a direção e magnitude da rolagem (-1 para cima, 1 para baixo, geralmente)
  scrollOffset += e * scrollVelocidade; // Atualiza o scrollOffset com base na direção e velocidade definida
  // Limita o scrollOffset para que não ultrapasse o início ou o fim do conteúdo rolável
  scrollOffset = constrain(scrollOffset, 0, conteudoAlturaTotal - (height - 100));
}
