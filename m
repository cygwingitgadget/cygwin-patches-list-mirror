Return-Path: <cygwin-patches-return-1809-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17715 invoked by alias); 29 Jan 2002 04:01:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17676 invoked from network); 29 Jan 2002 04:01:35 -0000
Message-ID: <000a01c1a879$90fddcf0$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 20:01:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C1A836.736035F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00166.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-length: 1720

The current setup.exe source has quite a number of messages that announce
method calls.  Most are being sent to setup.log and add bulk to that file
without providing diagnostic benefit.  I have changed the log() calls to
send the messages to setup.log.full only.

I also shortened the messages in iostream.cc to make them more consistent
with the other messages.

The log() call in compress_gz::error() is commented out.  Should the
corresponding call in compress_bz::error() be commented out as well?
--
Mac :})
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

2002-01-25  Michael A Chase <mchase@ix.netcom.com>

    * archive.cc (archive::read): Send log() output only to setup.log.full.
    (archive::write): Ditto.
    (archive::peek): Ditto.
    (archive::tell): Ditto.
    (archive::error): Ditto.
    (archive::next_file_name): Ditto.
    (archive::~archive): Ditto.
    * compress.cc (compress::read): Ditto.
    (compress::write): Ditto.
    (compress::peek): Ditto.
    (compress::tell): Ditto.
    (compress::error): Ditto.
    (compress::next_file_name): Ditto.
    * compress_bz.cc (compress_bz::write): Ditto.
    (compress_bz::peek): Ditto.
    (compress_bz::tell): Ditto.
    (compress_bz::seek): Ditto.
    (compress_bz::error): Ditto.
    * compress_gz.cc (compress_gz::peek): Ditto.
    (compress_gz::tell): Ditto.
    (compress_gz::seek): Ditto.
    (compress_gz::error): Ditto.
    (compress_gz::~compress_gz): Ditto.
    * io_stream_cygfile.cc (io_stream_cygfile::peek): Ditto.
    * io_stream_file.cc (io_stream_file::peek): Ditto.
    * io_stream.cc (io_stream::factory): Ditto.
    (io_stream::~io_stream): Ditto.
    Shortened log() message.


------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="io_stream_file.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io_stream_file.cc-patch"
Content-length: 450

--- winsup/cinstall/io_stream_file.cc-0	Mon Jan 21 10:39:01 2002=0A=
+++ winsup/cinstall/io_stream_file.cc	Sun Jan 27 01:24:02 2002=0A=
@@ -137,7 +137,7 @@ io_stream_file::write (const void *buffe=0A=
 ssize_t=0A=
 io_stream_file::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "io_stream_file::peek called");=0A=
+  log (LOG_BABBLE, "io_stream_file::peek called");=0A=
   if (fp)=0A=
     {=0A=
       int pos =3D ftell (fp);=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="archive.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="archive.cc-patch"
Content-length: 1510

--- winsup/cinstall/archive.cc-0	Thu Jan 24 16:43:57 2002=0A=
+++ winsup/cinstall/archive.cc	Sun Jan 27 01:14:25 2002=0A=
@@ -166,46 +166,46 @@ archive::extract_file (archive * source,=0A=
 #if 0=0A=
 ssize_t archive::read (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::read called");=0A=
+  log (LOG_BABBLE, "archive::read called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 ssize_t archive::write (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::write called");=0A=
+  log (LOG_BABBLE, "archive::write called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 ssize_t archive::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::peek called");=0A=
+  log (LOG_BABBLE, "archive::peek called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 long=0A=
 archive::tell ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "bz::tell called");=0A=
+  log (LOG_BABBLE, "bz::tell called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 int=0A=
 archive::error ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::error called");=0A=
+  log (LOG_BABBLE, "archive::error called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 const char *=0A=
 archive::next_file_name ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::next_file_name called");=0A=
+  log (LOG_BABBLE, "archive::next_file_name called");=0A=
   return NULL;=0A=
 }=0A=
=20=0A=
 archive::~archive ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "archive::~archive called");=0A=
+  log (LOG_BABBLE, "archive::~archive called");=0A=
   return;=0A=
 }=0A=
 #endif=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="compress.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="compress.cc-patch"
Content-length: 1354

--- winsup/cinstall/compress.cc-0	Mon Jan 21 10:38:58 2002=0A=
+++ winsup/cinstall/compress.cc	Sun Jan 27 01:16:14 2002=0A=
@@ -73,42 +73,42 @@ compress::decompress (io_stream * origin=0A=
 ssize_t=0A=
 compress::read (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress::read called");=0A=
+  log (LOG_BABBLE, "compress::read called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 ssize_t=0A=
 compress::write (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress::write called");=0A=
+  log (LOG_BABBLE, "compress::write called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 ssize_t=0A=
 compress::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress::peek called");=0A=
+  log (LOG_BABBLE, "compress::peek called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 long=0A=
 compress::tell ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "bz::tell called");=0A=
+  log (LOG_BABBLE, "bz::tell called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 int=0A=
 compress::error ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress::error called");=0A=
+  log (LOG_BABBLE, "compress::error called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 const char *=0A=
 compress::next_file_name ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress::next_file_name called");=0A=
+  log (LOG_BABBLE, "compress::next_file_name called");=0A=
   return NULL;=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="compress_bz.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="compress_bz.cc-patch"
Content-length: 1315

--- winsup/cinstall/compress_bz.cc-0	Mon Jan 21 10:38:59 2002=0A=
+++ winsup/cinstall/compress_bz.cc	Sun Jan 27 01:17:37 2002=0A=
@@ -131,13 +131,13 @@ ssize_t compress_bz::read (void *buffer,=0A=
=20=0A=
 ssize_t compress_bz::write (const void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_bz::write called");=0A=
+  log (LOG_BABBLE, "compress_bz::write called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 ssize_t compress_bz::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_bz::peek called");=0A=
+  log (LOG_BABBLE, "compress_bz::peek called");=0A=
   if (writing)=0A=
   {=0A=
     lasterr =3D EBADF;=0A=
@@ -171,21 +171,21 @@ ssize_t compress_bz::peek (void *buffer,=0A=
 long=0A=
 compress_bz::tell ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_bz::tell called");=0A=
+  log (LOG_BABBLE, "compress_bz::tell called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 int=0A=
 compress_bz::seek (long where, io_stream_seek_t whence)=0A=
 {=0A=
-    log (LOG_TIMESTAMP, "compress_bz::seek called");=0A=
+    log (LOG_BABBLE, "compress_bz::seek called");=0A=
       return -1;=0A=
 }=0A=
=20=0A=
 int=0A=
 compress_bz::error ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_bz::error called");=0A=
+  log (LOG_BABBLE, "compress_bz::error called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="compress_gz.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="compress_gz.cc-patch"
Content-length: 1422

--- winsup/cinstall/compress_gz.cc-0	Mon Jan 21 10:38:59 2002=0A=
+++ winsup/cinstall/compress_gz.cc	Sun Jan 27 01:19:15 2002=0A=
@@ -374,7 +374,7 @@ compress_gz::write (const void *buffer,=20=0A=
 ssize_t=0A=
 compress_gz::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::peek called");=0A=
+  log (LOG_BABBLE, "compress_gz::peek called");=0A=
   if (mode !=3D 'r')=0A=
     return Z_STREAM_ERROR;=0A=
   /* can only peek 512 bytes */=0A=
@@ -404,21 +404,21 @@ compress_gz::peek (void *buffer, size_t=20=0A=
 long=0A=
 compress_gz::tell ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::tell called");=0A=
+  log (LOG_BABBLE, "compress_gz::tell called");=0A=
   return 0;=0A=
 }=0A=
=20=0A=
 int=0A=
 compress_gz::seek (long where, io_stream_seek_t whence)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::seek called");=0A=
+  log (LOG_BABBLE, "compress_gz::seek called");=0A=
   return -1;=0A=
 }=0A=
=20=0A=
 int=0A=
 compress_gz::error ()=0A=
 {=0A=
-//  log (LOG_TIMESTAMP, "compress_gz::error called");=0A=
+//  log (LOG_BABBLE, "compress_gz::error called");=0A=
   return z_err;=0A=
 }=0A=
=20=0A=
@@ -466,7 +466,7 @@ compress_gz::destroy ()=0A=
=20=0A=
 compress_gz::~compress_gz ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::~gz called");=0A=
+  log (LOG_BABBLE, "compress_gz::~gz called");=0A=
   if (mode =3D=3D 'w')=0A=
     {=0A=
       z_err =3D do_flush (Z_FINISH);=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="io_stream.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io_stream.cc-patch"
Content-length: 743

--- winsup/cinstall/io_stream.cc-0	Thu Jan 24 16:44:00 2002=0A=
+++ winsup/cinstall/io_stream.cc	Sun Jan 27 01:27:33 2002=0A=
@@ -46,7 +46,7 @@ io_stream::factory (io_stream * parent)=0A=
    * case io_stream * foo =3D new bz2=0A=
    * return foo=0A=
    */=0A=
-  log (LOG_TIMESTAMP, "io_stream::factory has been called");=0A=
+  log (LOG_BABBLE, "io_stream::factory called");=0A=
   return NULL;=0A=
 }=0A=
=20=0A=
@@ -273,6 +273,6 @@ io_stream::exists (const char *name)=0A=
 io_stream::~io_stream ()=0A=
 {=0A=
   if (!destroyed)=0A=
-    log (LOG_TIMESTAMP, "io_stream::~io_stream: It looks like a class hasn=
't overriden the destructor!");=0A=
+    log (LOG_BABBLE, "io_stream::~io_stream: Not overridden!");=0A=
   return;=0A=
 }=0A=

------=_NextPart_000_0005_01C1A836.736035F0
Content-Type: application/octet-stream;
	name="io_stream_cygfile.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io_stream_cygfile.cc-patch"
Content-length: 465

--- winsup/cinstall/io_stream_cygfile.cc-0	Mon Jan 21 10:39:00 2002=0A=
+++ winsup/cinstall/io_stream_cygfile.cc	Sun Jan 27 01:23:02 2002=0A=
@@ -202,7 +202,7 @@ io_stream_cygfile::write (const void *bu=0A=
 ssize_t=0A=
 io_stream_cygfile::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "io_stream_cygfile::peek called");=0A=
+  log (LOG_BABBLE, "io_stream_cygfile::peek called");=0A=
   if (fp)=0A=
     {=0A=
       int pos =3D ftell (fp);=0A=

------=_NextPart_000_0005_01C1A836.736035F0--

