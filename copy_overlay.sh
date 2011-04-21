#!/bin/sh

cd overlay
tar cf ../overlay.tar --exclude .svn *
cd ../tree
tar xvf ../overlay.tar
rm ../overlay.tar
