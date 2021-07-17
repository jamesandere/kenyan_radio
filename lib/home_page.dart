import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenya_radio/models/radio.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;
  MyRadio _selectedRadio;
  Color _selectedColor;
  bool _isPlaying = false;

  final AudioPlayer _audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setupAlan();
    fetchRadios();

    _audioplayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  setupAlan() {
    AlanVoice.addButton("298e626bbef3e8df379a8dc48b2ae4682e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response){
    switch (response["command"]) {
      case "play":
        _playMusic(_selectedRadio.url);
        break;

      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString('assets/radio.json');
    radios = MyRadioList.fromJson(radioJson).radios;
    _selectedRadio = radios[0];
    print(radios);
    setState(() {});
  }

  _playMusic(String url) {
    _audioplayer.play(url);
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xFF181725),
            child: radios != null?
            VStack([
              100.heightBox,
              "All Channels".text.xl.white.semiBold.make().px16(),
              20.heightBox,
              ListView(
                padding: Vx.m0,
                shrinkWrap: true,
                children: radios.map((e) {
                  return GestureDetector(
                    onTap: (){
                      _playMusic(e.url);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(e.icon),
                      ),
                      title: e.name.text.white.make(),
                    ),
                  );
                }).toList(),
              ).expand(),
            ],
              crossAlignment: CrossAxisAlignment.start,
            )

        : const Offstage()
        ),
      ),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              // .withGradient(LinearGradient(
              //   colors: [
              //     Color(0xFF000000),
              //     Color(0xFF040304),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ))
          .color(Color(0xFF181725))
              .make(),
          VStack([
            AppBar(
              title: "🇰🇪 Radio".text.xl4.bold.make(),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0.0,
            ).h(120.0).p16(),
            30.heightBox,
            radios != null
                ? VxSwiper.builder(
                    itemCount: radios.length,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    itemBuilder: (context, index) {
                      final rad = radios[index];
                      return VxBox(
                        child: ZStack([
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: VStack(
                              [rad.name.text.xl3.white.bold.make()],
                              crossAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              CupertinoIcons.play_circle,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ]),
                      ).neumorphic(color: Color(0xFF181725), elevation: 1.0, curve: VxCurve.concave)
                          .bgImage(
                            DecorationImage(
                              image: NetworkImage(rad.image),
                              // fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          )
                          .withRounded(value: 20.0)
                          .make()
                          .onTap(() {
                            _playMusic(rad.url);
                      })
                          .p16();
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: [
              if(_isPlaying)
                "Playing Now - ${_selectedRadio.frequency} FM".text.white.makeCentered(),
              Icon(
              _isPlaying ? CupertinoIcons.stop_circle : CupertinoIcons.play_circle,
              color: Colors.white,
              size: 50.0,
            ).onInkTap(() {
              if(_isPlaying){
                _audioplayer.stop();
              }
              else{
                _playMusic(_selectedRadio.url);
              }
              })].vStack(),
          ).pOnly(bottom: context.percentHeight * 12),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
