import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> 
with  TickerProviderStateMixin {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;

  late AnimationController energyProgressController;
  Timer? _gettingHungry;

  String _moodEmoji = '';
  Color moodColor = Colors.green;

   @override
   void initState() {
      super.initState();
      _gettingHungry = Timer.periodic(Duration(seconds: 30), (Timer timer) {
	       _hungryPet();
	 });

      energyProgressController=
	 AnimationController(
	    vsync: this,
	    duration: const Duration(seconds: 2),
	 )
	 ..addListener(() {
	    setState(() {});
	 })
	 ..repeat(reverse: true);
}
   
   void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      _updateHunger();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
    _moodEmojiUpdate();
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
       _moodEmojiUpdate();
    });
  }

  void _hungryPet() {
     setState(() {
	 hungerLevel +=20;
	 _updateHappiness();
      });
   }

   void _energyLevel() {
      setState((){



      });
   }
   
   @override
   void dispose() {
      energyProgressController.dispose();
      _gettingHungry?.cancel();
      super.dispose();
   }

   

  Color _moodColor(double happinessLevel) {
   if (happinessLevel > 70) {
      return Colors.green;
   } else if (happinessLevel >= 30) {
      return Colors.yellow;
   } else {
      return Colors.red;
      }
   } 

   void _moodEmojiUpdate() {
	 if (happinessLevel >70){
	     _moodEmoji=('\u{1F600}'); 
	 } else if (happinessLevel >= 30) {
	    _moodEmoji=('\u{1F610}');
	 } else {
	    _moodEmoji=('\u{1F61E}');
	 }
   }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
	    children: <Widget>[
	       ColorFiltered(
		  colorFilter: ColorFilter.mode(
		     _moodColor(happinessLevel.toDouble()),
		     BlendMode.modulate,
		  ),
		  child: Image.asset('assets/kola_pet.png'),
	       ), 
	       Row(
		  mainAxisAlignment: .center,
		  children: [
		     Text('Name: $petName ', style: TextStyle(fontSize: 20.0)),
		     Text(
			_moodEmoji,
		     ),
		  ],
	       ),
	       SizedBox(height: 16.0),
	       Text('Happiness Level: $happinessLevel', style: TextStyle(fontSize: 20.0),
	       ),
	       LinearProgressIndicator(
		  value: happinessLevel.toDouble() / 100.0,
	       ),
	       
	       SizedBox(height: 16.0),
	       Text('Hunger Level: $hungerLevel', style: TextStyle(fontSize: 20.0)),
	       LinearProgressIndicator(
		  value: hungerLevel.toDouble() / 100.0,
	       ),
	       
	       SizedBox(height: 32.0),
	       ElevatedButton(
		 onPressed: _playWithPet,
		 child: Text('Play with Your Pet'),
	       ),
	       SizedBox(height: 16.0),
	       ElevatedButton(
		 onPressed: _feedPet,
		 child: Text('Feed Your Pet'),
	       ),
          ],
        ),
      ),
    );
  }
}

