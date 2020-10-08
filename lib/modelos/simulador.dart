import 'package:exame_simulator/exceptions/aprovado_exception.dart';
import 'package:exame_simulator/exceptions/reprovado_exception.dart';
import 'package:exame_simulator/modelos/avaliacao.dart';

class Simulador {
  static double mf(List<Avaliacao> avaliacoes) {
    double mf = 0;
    avaliacoes.forEach(
      (avaliacao) {
        mf += avaliacao.ponderada;
      },
    );
    return mf;
  }

  static double exame(List<Avaliacao> avaliacoes) {
    double mef = mf(avaliacoes);
    if (mef < 1.7) {
      throw new ReprovadoException();
    } else if (mef < 7) {
      return (-1.5 * mef) + 12.5;
    } else {
      throw new AprovadoException();
    }
  }
}
