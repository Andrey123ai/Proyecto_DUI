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
      nombre: 'Ebais',
      ubicacion: 'Agua Buena',
      foto: '/ebais.jpg',
      descripcion: 'abierto de 7 a 5 de la tarde ',
      numeroTelefonico: '+50687048683',
      numeroTelefonico2: '987654321',
      Horario: 'Viernes 8:00–17:00 \n ' +
          'Sábado 8:00–12:00 \n ' +
          'Domingo Cerrado \n ' +
          'Lunes 8:00–17:00 \n ' +
          'Martes 8:00–17:00 \n ' +
          'Miércoles 8:00–17:00 \n ' +
          'Jueves 8:00–17:00',
      SitioWeb: 'https://edus.ccss.sa.cr/eduscitasweb/',
      UbicacionUrl: 'https://goo.gl/maps/4REt7hCJEae1gRQL6?coh=178573&entry=tt',
    ),
    Lugar(
      nombre: 'CCSS',
      ubicacion: 'San vito',
      foto: 'ruta/a/imagen2.jpg',
      descripcion: 'siempre disponible para adultos mayores',
      numeroTelefonico: '987654321',
      numeroTelefonico2: '987654321',
      Horario: 'de 7 a 8',
      SitioWeb: 'url del sitio',
      UbicacionUrl: 'url de la ubicacion',
    ),
    // Añade más lugares aquí...
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
      ),
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
                          color: Colors.grey,
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
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                  Row(
                                    children: [
                                      Text(
                                        "Ubicación: " + lugar.ubicacion,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
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
      ),
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
