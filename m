Return-Path: <cygwin-patches-return-1822-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23544 invoked by alias); 29 Jan 2002 07:39:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23526 invoked from network); 29 Jan 2002 07:39:35 -0000
Message-ID: <022301c1a898$077666e0$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq> <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks> <01c101c1a88a$ba3763f0$0d00a8c0@mchasecompaq> <066601c1a88c$43ae51b0$0200a8c0@lifelesswks>
Subject: [PATCH]Reduce messages in setup.log (Revision 1)
Date: Mon, 28 Jan 2002 23:39:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0218_01C1A854.74CB3C00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00179.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0218_01C1A854.74CB3C00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1012

I think this covers the changes we discussed.
-- 
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

2002-01-28  Michael A Chase <mchase@ix.netcom.com>

    * compress_bz.cc (compress_bz::peek): Remove log() call.
    (compress_bz::~compress_bz): Ditto.
    (compress_bz::seek): Only write log() message to setup.log.full.
    * compress_gz.cc (compress_gz::peek): Remove log() call.
    (compress_gz::error): Ditto.
    (compress_gz::~compress_gz): Ditto.
    (compress_gz::seek): Only write log() message to setup.log.full.
    * io_stream_cygfile.cc (io_stream_cygfile::peek): Remove log() call.
    * io_stream_file.cc: Remove #include "log.h".
    (io_stream_file::peek): Remove log() call.
    * io_stream.cc (io_stream::factory): Shortened log() message.
    (io_stream::~io_stream): Shortened log() message.


------=_NextPart_000_0218_01C1A854.74CB3C00
Content-Type: application/octet-stream;
	name="cinstall.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall.patch"
Content-length: 3654

--- cinstall/compress_bz.cc-0	Mon Jan 21 10:38:59 2002=0A=
+++ cinstall/compress_bz.cc	Mon Jan 28 23:04:14 2002=0A=
@@ -137,7 +137,6 @@ ssize_t compress_bz::write (const void *=0A=
=20=0A=
 ssize_t compress_bz::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_bz::peek called");=0A=
   if (writing)=0A=
   {=0A=
     lasterr =3D EBADF;=0A=
@@ -178,8 +177,8 @@ compress_bz::tell ()=0A=
 int=0A=
 compress_bz::seek (long where, io_stream_seek_t whence)=0A=
 {=0A=
-    log (LOG_TIMESTAMP, "compress_bz::seek called");=0A=
-      return -1;=0A=
+  log (LOG_BABBLE, "compress_bz::seek called");=0A=
+  return -1;=0A=
 }=0A=
=20=0A=
 int=0A=
@@ -207,7 +206,6 @@ compress_bz::get_mtime ()=0A=
=20=0A=
 compress_bz::~compress_bz ()=0A=
 {=0A=
-  log (LOG_BABBLE, "compress_bz::~bz called");=0A=
   if (initialisedOk)=0A=
     BZ2_bzDecompressEnd (&strm);=0A=
   destroyed =3D 1;=0A=
--- cinstall/compress_gz.cc-0	Mon Jan 21 10:38:59 2002=0A=
+++ cinstall/compress_gz.cc	Mon Jan 28 23:05:56 2002=0A=
@@ -374,7 +374,6 @@ compress_gz::write (const void *buffer,=20=0A=
 ssize_t=0A=
 compress_gz::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::peek called");=0A=
   if (mode !=3D 'r')=0A=
     return Z_STREAM_ERROR;=0A=
   /* can only peek 512 bytes */=0A=
@@ -411,14 +410,13 @@ compress_gz::tell ()=0A=
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
   return z_err;=0A=
 }=0A=
=20=0A=
@@ -466,7 +464,6 @@ compress_gz::destroy ()=0A=
=20=0A=
 compress_gz::~compress_gz ()=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "compress_gz::~gz called");=0A=
   if (mode =3D=3D 'w')=0A=
     {=0A=
       z_err =3D do_flush (Z_FINISH);=0A=
--- cinstall/io_stream.cc-0	Thu Jan 24 16:44:00 2002=0A=
+++ cinstall/io_stream.cc	Mon Jan 28 22:39:11 2002=0A=
@@ -46,7 +46,7 @@ io_stream::factory (io_stream * parent)=0A=
    * case io_stream * foo =3D new bz2=0A=
    * return foo=0A=
    */=0A=
-  log (LOG_TIMESTAMP, "io_stream::factory has been called");=0A=
+  log (LOG_TIMESTAMP, "io_stream::factory called");=0A=
   return NULL;=0A=
 }=0A=
=20=0A=
@@ -273,6 +273,6 @@ io_stream::exists (const char *name)=0A=
 io_stream::~io_stream ()=0A=
 {=0A=
   if (!destroyed)=0A=
-    log (LOG_TIMESTAMP, "io_stream::~io_stream: It looks like a class hasn=
't overriden the destructor!");=0A=
+    log (LOG_TIMESTAMP, "io_stream::~io_stream: not overriden!");=0A=
   return;=0A=
 }=0A=
--- cinstall/io_stream_cygfile.cc-0	Mon Jan 21 10:39:00 2002=0A=
+++ cinstall/io_stream_cygfile.cc	Mon Jan 28 23:00:40 2002=0A=
@@ -202,7 +202,6 @@ io_stream_cygfile::write (const void *bu=0A=
 ssize_t=0A=
 io_stream_cygfile::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "io_stream_cygfile::peek called");=0A=
   if (fp)=0A=
     {=0A=
       int pos =3D ftell (fp);=0A=
--- cinstall/io_stream_file.cc-0	Mon Jan 21 10:39:01 2002=0A=
+++ cinstall/io_stream_file.cc	Mon Jan 28 23:00:15 2002=0A=
@@ -23,7 +23,6 @@ static const char *cvsid =3D=0A=
 #include <stdlib.h>=0A=
 #include <errno.h>=0A=
 #include <unistd.h>=0A=
-#include "log.h"=0A=
 #include "port.h"=0A=
 #include "mklink2.h"=0A=
=20=0A=
@@ -137,7 +136,6 @@ io_stream_file::write (const void *buffe=0A=
 ssize_t=0A=
 io_stream_file::peek (void *buffer, size_t len)=0A=
 {=0A=
-  log (LOG_TIMESTAMP, "io_stream_file::peek called");=0A=
   if (fp)=0A=
     {=0A=
       int pos =3D ftell (fp);=0A=

------=_NextPart_000_0218_01C1A854.74CB3C00--

