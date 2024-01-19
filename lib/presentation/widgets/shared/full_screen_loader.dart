import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});



  Stream <String> getLoadingMessages(){
   final messages = <String>[
    'Cargando películas',
    'Cargando palomitas de maíz',
    'Cargando populares',
    'Llamando a mi novia',
    'Ya mero...',
    'Esto esta tardando más de lo esperado :(',
  ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espero Por Favor'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 20),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if( !snapshot.hasData) return const Text('Cargando');
              return Text(snapshot.data!);
            },
          ),
        ],
      )
    );
  }
}