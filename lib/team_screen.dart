import 'package:appsita/firestore_service.dart';
import 'package:appsita/team.dart';
import 'package:flutter/material.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final FireStoreService _fireStoreService = FireStoreService();
  final TextEditingController _alumnoController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _editAlumnoController = TextEditingController();
  final TextEditingController _editApellidoController = TextEditingController();
  final TextEditingController _editMatriculaController =
      TextEditingController();

  void _agregarEquipo() {
    _fireStoreService.insertData('1', {
      'alumno': _alumnoController.text,
      'apellido': _apellidoController.text,
      'matricula': _matriculaController.text,
    });
    _alumnoController.clear();
    _apellidoController.clear();
    _matriculaController.clear();
  }

  void _eliminarEquipo(String docId) {
    _fireStoreService.deleteData('1', docId);
  }

  void _actualizarEquipo(String docId) {
    _fireStoreService.updateData('1', docId, {
      'alumno': _alumnoController.text,
      'apellido': _apellidoController.text,
      'matricula': _matriculaController.text
    });
    _alumnoController.clear();
    _apellidoController.clear();
    _matriculaController.clear();
  }

  void _mostrarDialogoEditar(Team team) {
    // Asigna los valores iniciales al diálogo de edición
    _editAlumnoController.text = team.alumno;
    _editApellidoController.text = team.apellido;
    _editMatriculaController.text = team.matricula;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar equipo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editAlumnoController,
                decoration: const InputDecoration(labelText: 'Alumno'),
              ),
              TextField(
                controller: _editApellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _editMatriculaController,
                decoration: const InputDecoration(labelText: 'Matrícula'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Actualiza los datos en la base de datos
                _fireStoreService.updateData('1', team.id, {
                  'alumno': _editAlumnoController.text,
                  'apellido': _editApellidoController.text,
                  'matricula': _editMatriculaController.text,
                });
                // Limpia los controladores de edición
                _editAlumnoController.clear();
                _editApellidoController.clear();
                _editMatriculaController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                // Limpia los controladores de edición y cierra el diálogo
                _editAlumnoController.clear();
                _editApellidoController.clear();
                _editMatriculaController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Alumnitos'),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
        ),
        body: Column(
          children: [
            TextField(
                controller: _alumnoController,
                decoration: const InputDecoration(labelText: 'Alumno')),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(labelText: 'Matrícula'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _agregarEquipo,
              child: const Text('Agregar alumno'),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _fireStoreService.getData('1'),
                builder: (context, AsyncSnapshot<List<Team>> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return ListView(
                    children: snapshot.data!.map((Team team) {
                      return ListTile(
                        title: Text(team.alumno),
                        subtitle: Text(
                            'Apellido: ${team.apellido}\nMatrícula: ${team.matricula}'),
                        onTap: () {
                          _alumnoController.text = team.alumno;
                          _apellidoController.text = team.apellido;
                          _matriculaController.text = team.matricula;
                          _mostrarDialogoEditar(team);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _eliminarEquipo(team.id);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
