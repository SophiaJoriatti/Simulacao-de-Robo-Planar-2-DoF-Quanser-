# Simulação de Robô Planar 2 DoF (Quanser)

Este projeto contém scripts em MATLAB/Octave para a modelagem matemática e simulação gráfica de um robô planar de 2 graus de liberdade (DoF) com configuração RR (Rotacional-Rotacional), inspirado na arquitetura de um robô de desenho da Quanser. O repositório abrange tanto a análise da cinemática direta quanto a inversa.

## 🛠️ Estrutura do Projeto

**1. Cinemática Direta (`planar_direta.m`)**
Modela o posicionamento do manipulador utilizando a convenção de Denavit-Hartenberg (D-H)[cite: 16]. O código calcula as matrizes de transformação homogénea para as duas juntas rotacionais e renderiza um gráfico 3D estático ilustrando as ligações (elos) e os eixos espaciais X, Y e Z da base até ao punho do robô.

**2. Cinemática Inversa (`planar_inversa.m`)**
Simula o controle dinâmico do efetor final para seguir trajetórias predefinidas num plano cartesiano. O script permite ao utilizador escolher entre quatro padrões de desenho:
* Reta
* Semicírculo
* Curva Cúbica
* Coração (ajustado ao *workspace* do robô)

Através da lei dos cossenos e funções trigonométricas, o algoritmo calcula os ângulos necessários para as juntas alcançarem cada coordenada da trajetória escolhida, plotando simultaneamente as duas soluções possíveis: **Cotovelo para Cima** e **Cotovelo para Baixo**. A interface gráfica exibe a animação do braço em movimento e gráficos auxiliares com a evolução temporal dos ângulos de cada junta.

## 🚀 Como Executar

1. Necessita do **GNU Octave** (com o pacote `symbolic` instalado) ou **MATLAB**.
2. Para a **cinemática direta**, execute `planar_direta.m`.
3. Para a **cinemática inversa**, execute `planar_inversa.m` e siga as instruções na consola para selecionar o número da trajetória pretendida (1 a 4).
