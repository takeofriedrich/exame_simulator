import 'package:exame_simulator/modelos/avaliacao.dart';

class Controller {
  List<Avaliacao> avaliacoes = [];

  addAvaliacao(Avaliacao a) {
    if (somaPesos() + a.peso > 100) {
      throw new Exception('Peso inválido!');
    }
    avaliacoes.add(a);
  }

  somaPesos() {
    double pesoTotal = 0;
    avaliacoes.forEach((element) {
      pesoTotal += element.peso;
    });
    return pesoTotal;
  }

  removerAvaliacao(Avaliacao a) {
    avaliacoes.remove(a);
  }
}
