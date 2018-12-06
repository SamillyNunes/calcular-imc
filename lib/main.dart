import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _informacao = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController =
      TextEditingController(); //controlador de peso
  TextEditingController heightController =
      TextEditingController(); // controlador de altura

  void _resetFields() {
    weightController.text =
        ""; //quando modifica texto se for controlador nao precisa colocar setState pq isso ja eh automatico
    heightController.text = "";

    setState(() {
      _informacao = "Informe seus dados!";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(
          weightController.text); //transforma esse texto em tipo double
      double height = double.parse(heightController.text) /
          100; //dividido por 100 pq o calculo eh kg por metros, e nesse caso eh centimetros

      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _informacao =
            "Abaixo do peso (${imc.toStringAsPrecision(4)})"; //toStringAsPrecision eh a precisao para 4 digitos apenas
      } else if (imc >= 18.6 && imc < 24.9) {
        _informacao = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _informacao = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _informacao = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _informacao = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _informacao = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            //acoes na barra, para o caso de botao etc
            IconButton(
              icon: Icon(Icons.refresh), //diz qual o icone
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //scrolView de apenas um filho, faz com que o conteudo possa ter rolagem e mesmo que venha algo por cima ele poder ser rolado e ser mostrado
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key:_formKey, //chave do formulario
            child: Column(
              // corpo
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //eixo cruzado (contrario ao eixo principal). Stretch faz com que alargue toda a largura
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType
                      .number, // input que recebe valores numericos
                  decoration: InputDecoration(
                      labelText: "Peso em kg",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize:
                          25.0), //estilo dos numeros quando sao digitados?
                  controller: weightController,
                  validator: (value){ //validacao do campo, passando o valor que for digitado e se for vazio vai dar uma msg de erro
                    if(value.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType
                      .number, // input que recebe valores numericos
                  decoration: InputDecoration(
                      labelText: "Altura em cm",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize:
                          25.0), //estilo dos numeros quando sao digitados?
                  controller: heightController,
                  validator: (value){ //validacao do campo
                    if(value.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    //um container pode definir altura e etc
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _informacao,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
