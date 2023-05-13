import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Lugares',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Lugar> lugaresFiltrados = []; // Lista filtrada de lugares
  String filtro = ''; // Término de búsqueda actual
  final List<Lugar> lugares = [
    Lugar(
      nombre: 'Ebais Agua Buena',
      ubicacion: 'Agua Buena, Coto Brus',
      foto: '/EbaisAguaBuena.jpg',
      descripcion:
          'Centro de salud para los habitante de Agua Buena y pueblos aledaños',
      numeroTelefonico: '+5062734 0195',
      numeroTelefonico2: '987654321',
      Horario: 'Viernes 8:00–17:00 \n ' +
          'Sábado 8:00–12:00 \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 8:00–17:00 \n ' +
          'Martes 8:00–17:00 \n ' +
          'Miércoles 8:00–17:00 \n ' +
          'Jueves 8:00–17:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/4REt7hCJEae1gRQL6?coh=178573&entry=tt',
    ),
    Lugar(
      nombre: 'Ebais Canoas',
      ubicacion: 'Paso Canoas, Corredores',
      foto: '/EbaisCanoas.jpg',
      descripcion:
          'Centro de salud para los habitante de Paso Canoas y pueblos aledaños',
      numeroTelefonico: 'Desconocido', //No aparece información
      numeroTelefonico2: 'Desconocido',
      Horario: 'Viernes 8:00–17:00 \n ' +
          'Sábado 8:00–12:00 \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 8:00–17:00 \n ' +
          'Martes 8:00–17:00 \n ' +
          'Miércoles 8:00–17:00 \n ' +
          'Jueves 8:00–17:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/dA4V9Qdj3L8ym3wJ6',
    ),
    Lugar(
      nombre: 'Ebais Los Ángeles',
      ubicacion: 'Los Ángeles, Perez Zeledón',
      foto: '/EbaisLosAngelesPZ.jpg',
      descripcion:
          'Centro de salud para los habitante de Los Ángeles y pueblos aledaños',
      numeroTelefonico: '27853281',
      numeroTelefonico2: 'Desconocido',
      Horario: 'Viernes 7:00–15:00 \n ' +
          'Sábado Cerrado \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 7:00–16:00 \n ' +
          'Martes 7:00–16:00 \n ' +
          'Miércoles Cerrado \n ' +
          'Jueves 7:00–16:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/64NZwVJaeBLa7AU46',
    ),
    Lugar(
      nombre: 'Ebais Ciudad Neily',
      ubicacion: 'Ciudad Neily, Corredores',
      foto: '/EbaisCiudadNeily.jpg',
      descripcion:
          'Centro de salud para los habitante de Ciudad Neily y pueblos aledaños',
      numeroTelefonico: 'Desconocido',
      numeroTelefonico2: 'Desconocido',
      Horario: 'Viernes 7:00–15:00 \n ' +
          'Sábado Cerrado \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 7:00–16:00 \n ' +
          'Martes 7:00–16:00 \n ' +
          'Miércoles Cerrado \n ' +
          'Jueves 7:00–16:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/64NZwVJaeBLa7AU46',
    ),
    Lugar(
      nombre: 'Ebais Rio Claro',
      ubicacion: 'Rio Claro, Corredores',
      foto: ' ',
      descripcion:
          'Centro de salud para los habitante de Rio Claro y pueblos aledaños',
      numeroTelefonico: '27898111',
      numeroTelefonico2: 'Desconocido',
      Horario: 'Viernes 6:00–22:00 \n ' +
          'Sábado Cerrado \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 6:00–22:00 \n ' +
          'Martes 6:00–22:00 \n ' +
          'Miércoles 6:00–22:00 \n ' +
          'Jueves 6:00–22:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/cSJgTsWYyJRYQJWn6',
    ),
    Lugar(
      nombre: 'Ebais San Andrés Alamedas',
      ubicacion: 'Golfito, Golfito',
      foto: '/EbaisGolfito.jpg',
      descripcion:
          'Centro de salud para los habitante de Golfito y pueblos aledaños',
      numeroTelefonico: 'Desconocido',
      numeroTelefonico2: 'Desconocido',
      Horario: 'Viernes 6:00–22:00 \n ' +
          'Sábado Cerrado \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 6:00–22:00 \n ' +
          'Martes 6:00–22:00 \n ' +
          'Miércoles 6:00–22:00 \n ' +
          'Jueves 6:00–22:00',
      SitioWeb: 'http://www.ccss.sa.cr/',
      UbicacionUrl: 'https://goo.gl/maps/M7oN32VskfQM9pta9',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    lugaresFiltrados = lugares
        .where((lugar) =>
            lugar.nombre.toLowerCase().contains(filtro.toLowerCase()) ||
            lugar.ubicacion.toLowerCase().contains(filtro.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
          title: Text('Descubre tu Ciudad'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 163, 30, 51)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  filtro = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lugaresFiltrados.length,
              itemBuilder: (context, index) {
                final lugar = lugaresFiltrados[index];
                return GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetallesPage(lugar: lugar),
                        ),
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          color: Color.fromARGB(255, 41, 54, 88),
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 50,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          lugar.nombre,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Ubicación: " + lugar.ubicacion,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        lugar.foto,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Lugar {
  final String nombre;
  final String ubicacion;
  final String foto;
  final String descripcion;
  final String numeroTelefonico;
  final String numeroTelefonico2;
  final String Horario;
  final String SitioWeb;
  final String UbicacionUrl;

  Lugar({
    this.nombre,
    this.ubicacion,
    this.foto,
    this.descripcion,
    this.numeroTelefonico,
    this.numeroTelefonico2,
    this.Horario,
    this.SitioWeb,
    this.UbicacionUrl,
  });
}

class DetallesPage extends StatelessWidget {
  final Lugar lugar;

  DetallesPage({this.lugar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(lugar.nombre),
          backgroundColor: Color.fromARGB(255, 163, 30, 51)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(lugar.nombre,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Image.asset(
                lugar.foto,
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    "Descripción",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.descripcion.isNotEmpty
                        ? lugar.descripcion
                        : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.description),
                  onTap: () {
                    Alert(
                        context,
                        "Descripción",
                        lugar.descripcion.isNotEmpty
                            ? lugar.descripcion
                            : "Sin datos",
                        '--');
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    "Número WhatsApp",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.numeroTelefonico.isNotEmpty
                        ? lugar.numeroTelefonico
                        : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.message_outlined),
                  onTap: () {
                    Alert(
                        context,
                        "Número WhatsApp",
                        lugar.numeroTelefonico.isNotEmpty
                            ? lugar.numeroTelefonico
                            : "Sin datos",
                        'http://wa.me/${lugar.numeroTelefonico}');
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    "Número telefónico",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.numeroTelefonico2.isNotEmpty
                        ? lugar.numeroTelefonico2
                        : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.phone),
                  onTap: () {
                    Alert(
                        context,
                        "Descripción",
                        lugar.numeroTelefonico2.isNotEmpty
                            ? lugar.numeroTelefonico2
                            : "Sin datos",
                        '--');
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    "Horario de atencion",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.Horario.isNotEmpty ? lugar.Horario : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.schedule_outlined),
                  onTap: () {
                    Alert(
                        context,
                        "Horario de atencion",
                        lugar.Horario.isNotEmpty ? lugar.Horario : "Sin datos",
                        '--');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Sitio Web",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.SitioWeb.isNotEmpty ? lugar.SitioWeb : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.web_asset_outlined),
                  onTap: () {
                    Alert(
                        context,
                        "Sitio Web",
                        lugar.SitioWeb.isNotEmpty
                            ? lugar.SitioWeb
                            : "Sin datos",
                        lugar.SitioWeb);
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    "Ubicacion",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    lugar.ubicacion.isNotEmpty ? lugar.ubicacion : "Sin datos",
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.location_on_outlined),
                  onTap: () {
                    Alert(
                        context,
                        "Ubicacion",
                        lugar.ubicacion.isNotEmpty
                            ? lugar.ubicacion
                            : "Sin datos",
                        lugar.UbicacionUrl);
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget Alert(
      BuildContext context, String titulo, String descripcion, String URL) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(descripcion),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cerrar"),
              ),
              Visibility(
                visible: URL != '--',
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (await canLaunch(URL)) {
                      await launch(URL);
                    } else {
                      throw 'No se pudo abrir $URL';
                    }
                  },
                  child: Text("Abrir enlace"),
                ),
              ),
            ],
          );
        });
  }
}
