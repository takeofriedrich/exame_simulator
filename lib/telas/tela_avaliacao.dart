import 'dart:ui';

import 'package:exame_simulator/modelos/avaliacao.dart';
import 'package:exame_simulator/widgets/aviso.dart';
import 'package:flutter/material.dart';

class TelaAvalicao extends StatefulWidget {
  Avaliacao avaliacao;
  int tipo;
  TelaAvalicao(this.avaliacao, this.tipo);
  @override
  _TelaAvalicaoState createState() => _TelaAvalicaoState();
}

class _TelaAvalicaoState extends State<TelaAvalicao> {
  TextEditingController caixaNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.tipo == 2) {
      caixaNome.text = widget.avaliacao.nome;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${_titulo()} Avaliação'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _caixa(_caixaNome()),
          _caixa(_caixaPeso()),
          _caixa(_caixaNota()),
          _caixa(_botao()),
        ],
      ),
    );
  }

  _caixa(Widget dentro) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      child: dentro,
    );
  }

  _caixaNome() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: caixaNome,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Digite o nome da avaliação',
        ),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  _caixaPeso() {
    return Column(
      children: [
        Text('Peso'),
        Slider(
          value: widget.avaliacao.peso * 1.0,
          min: 0,
          max: 100,
          divisions: 100,
          label: 'Peso: ${widget.avaliacao.peso}%',
          onChanged: (novoValor) {
            setState(() {
              widget.avaliacao.peso = novoValor.toInt();
            });
          },
        ),
      ],
    );
  }

  _caixaNota() {
    return Column(
      children: [
        Text('Nota'),
        Slider(
          value: widget.avaliacao.nota,
          min: 0,
          max: 10,
          divisions: 100,
          label: 'Nota: ${widget.avaliacao.nota.toStringAsPrecision(2)}',
          onChanged: (novoValor) {
            setState(() {
              widget.avaliacao.nota = novoValor;
            });
          },
        ),
      ],
    );
  }

  _botao() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          onPressed: () {
            if (caixaNome.text.isEmpty) {
              exibirAviso(
                  context, 'Nome inválido', 'O nome não pode estar em branco!');
            } else {
              widget.avaliacao.nome = caixaNome.text;
              Navigator.pop(context, widget.avaliacao);
            }
          },
          child: Container(
            child: Text(
              _titulo(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          color: Colors.blue,
        ),
      ],
    );
  }

  _titulo() {
    return widget.tipo == 1 ? 'Criar' : 'Editar';
  }
}
