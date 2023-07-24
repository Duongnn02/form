import 'package:cloud_firestore/cloud_firestore.dart'; 

import 'constants.dart';
import 'helper.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

CollectionReference get colData => _firestore.collection(kdb_data); 

// final _storage = FirebaseStorage.instance;
// Reference refByUrl(String url) => _storage.refFromURL(url);
// Reference get refGalleryImages => _storage.ref().child('gallery/images/');
