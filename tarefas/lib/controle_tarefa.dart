//ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:tarefas/modelo_tarefa.dart';

class Controle_tarefa extends ChangeNotifier {
  List<Modelo_tarefa> tarefas = [];

  void adicionar (String titulo) {
    tarefas.add(Modelo_tarefa(titulo: titulo));
    notifyListeners();
  }

  void remover(int id){
    tarefas.removeAt(id);
    notifyListeners();
  }
  void concluir(int id) {
    tarefas[id].completa = !tarefas[id].completa;
    notifyListeners();
  }

}