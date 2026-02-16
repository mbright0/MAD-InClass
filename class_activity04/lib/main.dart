import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
   const MyApp({super.key});
   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
      return MaterialApp(
	 // Application name
	 title: 'Stateful Widget',
	 theme: ThemeData(
	    primarySwatch: Colors.blue,
	 ),
	 // A widget that will be started on the application startup
	 home: CounterWidget(),
	 );
      }
   }
class CounterWidget extends StatefulWidget {
   @override
   _CounterWidgetState createState() => _CounterWidgetState();
}
class _CounterWidgetState extends State<CounterWidget> {
   //initial couter value
   int _counter = 0;
   int _stepValue = 1;
   int _counterMax = 100;
   int _counterMilestone = 0;
   final _history = <int>[];

   final _maxController = TextEditingController();
   final _milestoneController = TextEditingController();
   final _stepController = TextEditingController(); 

   Color _counterColor = Colors.blue;
   String _counterStatus = '';

   @override
   void dispose(){
      _milestoneController.dispose();
      _maxController.dispose();
      _stepController.dispose();
      super.dispose();
   }
   void _updateHistory(){
    setState((){    
      if(_history.length == 5){
	 _history.removeAt(0);
      }
      _history.add(_counter);
    });
  }

  void _incrementCounter() {
      if((_counter+_stepValue) <= _counterMax){
	 setState(() => _counter+= _stepValue);
      }
  }

  void _decrementCounter(){
     if((_counter-_stepValue) >= 0){
	 setState(() => _counter-= _stepValue);
     }
  }

  void _resetCounter(){
     setState(()=> _counter = 0);
  }

  void _undoCounter(){
     setState((){
	 _counter= _history.removeLast();
	});
  }

  void _updateValues(){
      setState((){
	 _counterMax = int.parse(_maxController.text);
	 _counterMilestone = int.parse(_milestoneController.text);
	 _stepValue = int.parse(_stepController.text);

      });
  }

  void _counterTracker(){
     setState((){
	 if (_counter == 0){
	    _counterStatus = '';
	    _counterColor = Colors.red;
	 } else if( _counter == _counterMax){
	    _counterStatus = 'Maxium Value Reached';
	    _counterColor = Colors.green;
	 
	 }else if (_counter == _counterMilestone){
	    _counterStatus = 'Milestone: $_counterMilestone Reached';
	    _counterColor = Colors.green;   
	 }else{
	    _counterStatus = '';
	    _counterColor = Colors.blue;
	 }
      }
     );

  }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
	 appBar: AppBar(
	    title: const Text('Stateful Widget'),
	 ),
	 body: Column(
	    mainAxisAlignment: MainAxisAlignment.center,
	    children: [
	       Text(
		  '$_counterStatus',
		  style: TextStyle(fontSize: 35.0),
	       ),
	       Center(
		  child: Container(
		  padding: const EdgeInsets.all(7.0),
		  color: _counterColor,
		  child: Text(
		     //displays the current number
		     '$_counter',
		     style: TextStyle(fontSize: 50.0),
		  ),
		  ),
	       ),
	       Slider(
		  min: 0,
		  max: _counterMax.toDouble(),
		  value: _counter.toDouble(),
		  onChanged: (double value) {
		     setState(() {
		     _counter = value.toInt();
		     _counterTracker();
		     });
		  },
		  activeColor: Colors.blue,
		  inactiveColor: Colors.red,
	       ),
	       // Counter History 
	       Text(
		  'History: $_history',
	       ),
	       const SizedBox(height: 12),
	       Row(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [ 
		     ElevatedButton(
			onPressed: () => [_updateHistory(), _incrementCounter(), _counterTracker()],
			child: const Text('Increment'),
		     ),
		     ElevatedButton(
			onPressed: () => [_updateHistory(), _decrementCounter(), _counterTracker()],
			child: const Text('Decrement'),
		     ),
		     ElevatedButton(
			onPressed: () => [_updateHistory(), _resetCounter(), _counterTracker()],
			child: const Text('Reset'),
		     ),
		  ],
	       ),
	       const SizedBox(height: 12),
	       Row(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [
		     ElevatedButton(
			onPressed: _undoCounter,
			child: Text('Undo'),
		     ),
		  ],
	       ),
	       const SizedBox(height: 15), 
	       TextFormField(
		  controller: _stepController,
		  decoration: const InputDecoration(
		     labelText: ' Step Value:'
		  )
	       ),
	       const SizedBox(height: 12), 
	       TextFormField(
		  controller: _maxController,
		  decoration: const InputDecoration(
		     labelText: ' Maxium:'
		  )
	       ),
		  
	       const SizedBox(height: 12), 
	       TextFormField(
		  controller: _milestoneController,
		  decoration: const InputDecoration(
		     labelText: ' Milestone:'
		  )
	       ),

	       const SizedBox(height: 12),
	       ElevatedButton(
		  onPressed: _updateValues, 
		  child: const Text('Update'),
	       ),

	    ],
	 ),
      );
   }
}

