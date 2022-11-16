import 'package:flutter/material.dart';
import 'questiondata.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionData questionData = QuestionData();

void main(){
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  bool correctAnswer = questionData.getAnswer();
  void checkAnswer(bool answer){
    setState(() {
      if(questionData.isFinished() == true){
        Alert(context: context, title: "FINISHED", desc: "You have concluded the Quiz game").show();
        questionData.reset();
        scoreKeeper = [];
      }else{
        if(answer == correctAnswer){
          scoreKeeper.add(const Icon(Icons.check,color:Colors.green ,),);
        }else{
          scoreKeeper.add(const Icon(Icons.check,color:Colors.green ,),);
        }
        questionData.nextQuestion();
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          // ignore: avoid_unnecessary_containers
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            child: Center(
              child:Padding(
                padding:const EdgeInsets.all(10.0),
                child: Text(
                  questionData.getQuestion(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize:25.0,

                    
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: (){
                checkAnswer(true);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
                child: const Text(
              'True',
              style: TextStyle(color: Colors.black,fontSize: 20.0),
            ),),
            TextButton(
              onPressed: (){
                checkAnswer(false);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1)),
                ),
              ),
              child: const Text(
              'False',
              style: TextStyle(color: Colors.white,fontSize: 20.0),
            ),
            ),
          ],
        ),),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

