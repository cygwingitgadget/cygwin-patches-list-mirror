Return-Path: <cygwin-patches-return-1931-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16038 invoked by alias); 28 Feb 2002 14:37:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15993 invoked from network); 28 Feb 2002 14:37:44 -0000
content-class: urn:content-classes:message
Subject: Thread.h failure on 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Feb 2002 06:53:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AADA@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Thread.h failure on 
Thread-Index: AcHAZXsxUosRJtQvR0ORwKNMy+zhjQ==
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00288.txt.bz2

Is this patch needed to solve

In file included from ../../../../../src/winsup/cygwin/dtable.h:14,
                 from ../../../../../src/winsup/cygwin/cygheap.cc:19:
../../../../../src/winsup/cygwin/thread.h:57: field `_grp' has incomplete t=
ype
make: *** [cygheap.o] Error 1

or is something else wrong?

Index: thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.33
diff -u -p -r1.33 thread.h
--- thread.h    2002/02/10 13:50:13     1.33
+++ thread.h    2002/02/28 14:37:02
@@ -42,7 +42,7 @@ extern "C"
 #include <pthread.h>
 #include <signal.h>
 #include <pwd.h>
-#include <grp.h>
+#include <cygwin/grp.h>
 #define _NOMNTENT_FUNCS
 #include <mntent.h>

Rob
