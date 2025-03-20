import 'package:flutter/material.dart';


   const MaterialColor kPrimaryColor =
      MaterialColor(0xFF1DB954, <int, Color>{});

   const MaterialColor kSecondaryColor =
      MaterialColor(0xFF121212, <int, Color>{});

   const MaterialColor kSecondarySwatchColor =
      MaterialColor(0xFF2A2A2A, <int, Color>{});
const kDefaultPadding = 16.0;


const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kBgColor = Color(0xFF212332);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
// const kHost="http://192.168.240.33:3000/api/v1/";
// const kHost="http://192.168.240.33:3000/";
const kHost="https://diabeticapi.vercel.app/api/v1/";
const k_host="https://diabeticapi.vercel.app/";
class Songs {
  static const Map<String, List<Map<String, String>>> songDetails = {
    'Arijit Singh': [
      {
        'name': 'Agar Tum Saath Ho (From Tamasha)',
        'image': 'assets/songs/arijitSingh/images/tamasha.jpg',
        'song': 'songs/arijitSingh/songs/agar_tum_saath_ho.mp3'
      },
      {
        'name': 'Phir Aur Kya Chahiye (From Zara Hatke Zara Bachke)',
        'image': 'assets/songs/arijitSingh/images/zara_hatke_zara bachke.jpg'
      },
      {
        'name': 'Kesariya',
        'image': 'assets/songs/arijitSingh/images/brahmashtra.jpg'
      },
      {
        'name': 'Humdard',
        'image': 'assets/songs/arijitSingh/images/ek_villan.jpg'
      },
      {
        'name': 'Tujhe Kitna Chahne Lage (From Kabir Singh)',
        'image': 'assets/songs/arijitSingh/images/kabir_singh.jpg'
      },
    ],
    'Iqlipse Nova': [
      {
        'name': 'Mera Safar',
        'image': 'assets/songs/iqlipseNova/images/mera_safar.jpg',
        'song': 'songs/iqlipseNova/songs/meraSafar.mp3'
      },
      {'name': 'Khwab', 'image': 'assets/songs/iqlipseNova/images/khwab.jpg'},
      {
        'name': 'Middle Class',
        'image': 'assets/songs/iqlipseNova/images/middle_class.jpg'
      },
      {
        'name': 'Aarzoo',
        'image': 'assets/songs/iqlipseNova/images/aarzoo.jpg',
        'song': 'songs/iqlipseNova/songs/aarzoo.mp3'
      },
      {
        'name': 'Khwab - Reprise',
        'image': 'assets/songs/iqlipseNova/images/khwab_reprise.jpg'
      },
    ],
    'The Ranveer Show': [
      {'name': 'Podcast No. - 150', 'image': 'assets/songs/trs/images/trs-150.jpg'},
      {'name': 'Podcast No. - 154', 'image': 'assets/songs/trs/images/trs-154.jpg'},
      {
        'name': 'Podcast No. - 161',
        'image': 'assets/songs/trs/images/trs-161.jpg'
      },
      {'name': 'Podcast No. - 167', 'image': 'assets/songs/trs/images/trs-167.jpg'},
      {
        'name': 'Podcast No. - 266',
        'image': 'assets/songs/trs/images/trs-266.jpg'
      },
    ],
    'Imagine Dragons': [
      {
        'name': 'Believer',
        'image': 'assets/songs/imagineDragons/images/believer.jpg'
      },
      {
        'name': 'Bones',
        'image': 'assets/songs/imagineDragons/images/bones.jpg'
      },
      {
        'name': 'Thunder',
        'image': 'assets/songs/imagineDragons/images/thunder.jpg'
      },
      {
        'name': 'Enemy',
        'image': 'assets/songs/imagineDragons/images/enemy.jpg'
      },
      {
        'name': 'Demons',
        'image': 'assets/songs/imagineDragons/images/demons.jpg'
      },
    ],
  };
}
