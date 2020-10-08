import 'package:exame_simulator/modelos/avaliacao.dart';
import 'package:exame_simulator/telas/tela_avaliacao.dart';
import 'package:flutter/material.dart';

class AvaliacoesWidget extends StatefulWidget {
  Avaliacao avaliacao;
  AvaliacoesWidget(this.avaliacao);

  @override
  _AvaliacoesWidgetState createState() => _AvaliacoesWidgetState();
}

class _AvaliacoesWidgetState extends State<AvaliacoesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: _body(),
          ),
        ),
      ],
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: _editar,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.avaliacao.nome,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Peso: ${widget.avaliacao.peso.toStringAsPrecision(2)}%',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Slider(
                  value: widget.avaliacao.nota,
                  min: 0,
                  max: 10,
                  divisions: 100,
                  label: _getLabel(),
                  onChanged: (novoValor) {
                    setState(() {
                      widget.avaliacao.nota = novoValor;
                    });
                  },
                ),
                Text(_getLabel()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getLabel() {
    if (widget.avaliacao.nota > 0.9)
      return widget.avaliacao.nota.toStringAsPrecision(2);
    else
      return widget.avaliacao.nota.toStringAsPrecision(1);
  }

  _editar() async {
    Avaliacao avaliacao = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaAvalicao(widget.avaliacao, 2);
        },
      ),
    );
    if (avaliacao != null) {
      setState(() {
        widget.avaliacao = avaliacao;
      });
    }
  }
}
