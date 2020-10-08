import 'package:exame_simulator/controller/controller.dart';
import 'package:exame_simulator/exceptions/aprovado_exception.dart';
import 'package:exame_simulator/exceptions/reprovado_exception.dart';
import 'package:exame_simulator/modelos/avaliacao.dart';
import 'package:exame_simulator/modelos/simulador.dart';
import 'package:exame_simulator/telas/tela_avaliacao.dart';
import 'package:exame_simulator/widgets/avaliacoes_widget.dart';
import 'package:exame_simulator/widgets/aviso.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulação de Notas'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.cleaning_services), onPressed: _limpar),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              }),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _criarAvaliacao(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: controller.avaliacoes.length == 0
                  ? Center(
                      child: Text('Não há avaliações na lista!'),
                    )
                  : ListView.builder(
                      itemCount: controller.avaliacoes.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        final Avaliacao av = controller.avaliacoes[index];
                        return Dismissible(
                          key: Key('avaliacao${av.hashCode}'),
                          child: AvaliacoesWidget(av),
                          onDismissed: (direction) {
                            setState(
                              () {
                                controller.avaliacoes.removeAt(index);
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
            Expanded(
              flex: 2,
              child: _resultados(),
            ),
          ],
        ),
      ),
    );
  }

  _resultados() {
    return Column(
      children: [
        Divider(
          color: Colors.black,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Média Final:  ${_mf()}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        _campoExame(),
      ],
    );
  }

  _campoExame() {
    return controller.somaPesos() == 100
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    _exame(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  _mf() {
    double mf = Simulador.mf(controller.avaliacoes);
    if (mf < 1) {
      return mf.toStringAsPrecision(1);
    } else {
      return mf.toStringAsPrecision(2);
    }
  }

  _exame() {
    double ex = 0;
    try {
      ex = Simulador.exame(controller.avaliacoes);
      if (ex < 1) {
        return 'Exame: ${ex.toStringAsPrecision(1)}';
      } else {
        return 'Exame: ${ex.toStringAsPrecision(2)}';
      }
    } on AprovadoException catch (e) {
      return e.mensagem;
    } on ReprovadoException catch (e) {
      return e.mensagem;
    }
  }

  _criarAvaliacao(context) async {
    Avaliacao avaliacao = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaAvalicao(Avaliacao(), 1);
        },
      ),
    );
    if (avaliacao != null) {
      try {
        setState(() {
          controller.addAvaliacao(avaliacao);
        });
      } on Exception catch (e) {
        exibirAviso(context, 'Peso inválido',
            'Reduza o peso das avaliação para que elas somem 100%');
      }
    }
  }

  _limpar() {
    setState(() {
      controller.avaliacoes.clear();
    });
  }
}
