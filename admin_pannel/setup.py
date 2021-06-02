#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Made by Leo Smith
# Created on: Thu 27 May 2021 01:35:42 PM CEST
# setup.py
# Description:
#  script to setup firebase.
# Requirements:
#  firebase_admin

import firebase_admin
import sys
from firebase_admin import credentials
from firebase_admin import firestore

def usage():
    print("%s [google_services_files].json" % sys.argv[0])
    sys.exit(0)

# Use a service account
try:
    cred = credentials.Certificate(sys.argv[1])
except:
    usage()
firebase_admin.initialize_app(cred)

db = firestore.client()

doc_ref = db.collection(u'users').document(u'0000000000000000000000000000')
doc_ref.set({
    u'name': u'Admin', # Administrators name
    u'bio': u'Administrator Account', # Administrators biography
    u'email': u'admin@anilist.com', # Administrators email
    u'favs': [],
    u'id': u'0000000000000000000000000000',
    u'animesList': [],
    u'photo': u'https://firebasestorage.googleapis.com/v0/b/anilist-67a8a.appspot.com/o/0000000000000000000000000000/profile-picture.jpeg?alt=media&token=e628697d-e939-4e0b-9946-5b6c2492412d',
    u'admin': True # Keep this value at true
})
