import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; //Autenticação firebase
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/*

void main() async {

  /*

  WidgetsFlutterBinding
      .ensureInitialized(); //Ta sendo necessário utilizar na nova depedencia

  Firestore db = Firestore.instance; //Instância do firebase



  //Salvar ou alterar dados no Firebase passando o identificador (collection)
  db.collection("usuarios")
      .document("002")
      .setData({
        "Nome ": "Ana",
        "idade" : "28"
      }
  );



  //Criar um identificador automático (sem o uso de document)
    DocumentReference  ref = await db.collection("noticias") //retorna o identificador
    .add(
      {
        "titulo" : "Criada a nova moeda virtual",
        "descricao" : "Texto exemplo"
      }
    );

    print("Identificador: "+ref.documentID);


  
  //Alterar dados no firebase quando o identificador é automático
    db.collection("noticias")
    .document(ref.documentID)
    .setData(
        {
          "titulo" : "Ondas de calor de São Paulo",
          "descricao" : "Texto exemplo..."
        }
    );


   //Remover um item
      db.collection("usuarios")
      .document("002")
      .delete();


  //Recuperar  dados (individualmente) solicitando ao firebase
    DocumentSnapshot snapshot = await db.collection("usuarios")
    .document("001")
    .get();

    var dados = snapshot.data;

    print("Dados: ${dados["Nome "]} idade ${dados["idade"]}" );


  //Recuperar todos o sdados do coleção de uma vez (Solicitando ao firebase)
    QuerySnapshot querySnapshot = await db.collection("usuarios").getDocuments();

    for(DocumentSnapshot item in querySnapshot.documents){
      var dados = item.data;
      //print("Dados usuários: ${dados.toString()}");
      print("Dados usuários: ${dados["nome"]} - ${dados["idade"]}");
    }


  //Receber notificação do firebase de dados alterados
      db.collection("usuarios")
      .snapshots().listen(
          (snapshot){
            for(DocumentSnapshot item in snapshot.documents){
              var dados = item.data;
              print("Dados usuários: ${dados["nome"]} - ${dados["idade"]}");
            }
          }
      );




  //Filtros
    QuerySnapshot querySnapshot = await db.collection("usuarios")

    //.where("nome",isEqualTo: "rafael")//igual a ...

    //.where("idade",isGreaterThan: 15)//maior que...

    //.orderBy("idade",descending: true)//ordenar, do maior para o menor

    //.orderBy("nome",descending: false)//caso a idade seja a mesma ordena pelo nome

        ///No caso a cima vai Aparecer um erro falando que é necessário criar um indice
        ///(quando se usa um descendente e um ascendente) é so clicar no link do erro
        ///e mandar o firebase criar os indices e executar novamente

    //.limit(2) //Quantidade de resultados que quer retornar

    //Pesquisar por parte do nome
    .where("nome",isGreaterThanOrEqualTo: "raf")
    .where("nome",isLessThanOrEqualTo: "raf"+"\uf8ff")
    .getDocuments();

    for(DocumentSnapshot item in querySnapshot.documents){

      var dados =item.data;
      print("Filtro nome: ${dados["nome"]} idade ${dados["idade"]}");

  }

   */

  runApp(App());

  /*

  //Autenticação de usuários

  //  * Tem que ativar no firebase - Authentication --> método de login
  FirebaseAuth auth = FirebaseAuth.instance;



  // Criando usuário com e-mail e senha
    String email = "rafael@gmail.com";
    String senha = "123456";

    auth.createUserWithEmailAndPassword(
        email: email,
        password: senha
    ).then((firebaseUser){ //Capturar dados do usuario
        print("Sucesso ao criar usuario "+firebaseUser.user.email);
    }).catchError((erro){
      print("Erro ao criar usuario ${erro.toString()}");
    });




  //Deslogar usuário
    auth.signOut();


  //Logar usuário
    String email = "rafael@gmail.com";
    String senha = "123456";
    auth.signInWithEmailAndPassword(
        email: email,
        password: senha
    ).then((firebaseUser){ //Capturar dados do usuario
    print("Sucesso ao logar "+firebaseUser.user.email);
    }).catchError((erro){
      print("Erro ao logar ${erro.toString()}");
    });


    // Verificar se o usuário está logado
      FirebaseUser usuarioAtual = await auth.currentUser();
      if(usuarioAtual !=null){ //logado
        print("Usuario logado ${usuarioAtual.email}");
      }else{
        print("Usuario atual esta deslogado");
      }

     */

}
  


class  App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
]

 */

void main() async{
  runApp(MaterialApp(
    home: Home(),
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {



  File imagem; //Imagem que será carregada



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuparImagem(true);
              },
            ),

            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuparImagem(false);
              },
            ),
            imagem == null ? //Condicional
            Container()
                : Image.file((imagem)),


            RaisedButton(
              child: Text("Upload Firebase"),
              onPressed: (){

                uploadImagem();
              },
            ),
          ],

        ),
      ),
    );
  }

  Future _recuparImagem(bool daCamera) async{

    File imagemSelecionada;

    if(daCamera){ //Camera
      imagemSelecionada = await  ImagePicker.pickImage(
          source: ImageSource.camera);
    }else{ //Galeria
      imagemSelecionada = await ImagePicker.pickImage(
          source: ImageSource.gallery);
    }

    setState(() {
      imagem = imagemSelecionada;
    });
  }

  Future uploadImagem() async{


    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;//pegar instância
    StorageReference pastaRaiz = storage.ref(); //pegar referencia da pasta raiz
    StorageReference arquivo = pastaRaiz.child("fotos").child("foto1.jpg"); //Criar pasta ou arquivo
    // ex: "fotos" = pasta, "cao.png" = arquivo, "video.mov" = arquivo

    //Fazer upload da imagem
    arquivo.putFile(imagem);
  }


}



