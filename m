Return-Path: <cygwin-patches-return-1557-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24924 invoked by alias); 4 Dec 2001 02:25:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24741 invoked from network); 4 Dec 2001 02:24:58 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2827@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Thu, 01 Nov 2001 05:36:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C17C6A.D804B7D0"
X-SW-Source: 2001-q4/txt/msg00089.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C17C6A.D804B7D0
Content-Type: text/plain
Content-length: 1124

It just occurred to me that the patch I submitted for mkpasswd.c causes one
of its error messages to be a bit misleading.  If you ask mkpasswd for a
user that doesn't exist it will say:
"NetUserEnum() failed with error 2221.
That user doesn't exist."

While the error number is correct, and the explanation on the second line is
right, it's not actually NetUserEnum that's been called to determine that.
I don't know if you care about this, but maybe the following patch could be
thrown in to make that error a bit more generic (and correct).

===============================

2001-12-03  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* mkpasswd.c: (enum_users): Fix an error message.

===============================

--- mkpasswd.c	Wed Nov 21 20:55:41 2001
+++ mkpasswd.c.new	Mon Dec  3 21:17:14 2001
@@ -147,7 +147,7 @@ enum_users (LPWSTR servername, int print
 	  break;
 
 	default:
-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
+	  fprintf (stderr, "Mkpasswd failed with error %ld.\n", rc);
 	  if (rc == NERR_UserNotFound) 
 	    fprintf (stderr, "That user doesn't exist.\n");
 	  exit (1);


------_=_NextPart_000_01C17C6A.D804B7D0
Content-Type: application/octet-stream;
	name="mkpasswd.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mkpasswd.c.diff"
Content-length: 454

--- mkpasswd.c	Wed Nov 21 20:55:41 2001=0A=
+++ mkpasswd.c.new	Mon Dec  3 21:17:14 2001=0A=
@@ -147,7 +147,7 @@ enum_users (LPWSTR servername, int print=0A=
 	  break;=0A=
=20=0A=
 	default:=0A=
-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);=0A=
+	  fprintf (stderr, "Mkpasswd failed with error %ld.\n", rc);=0A=
 	  if (rc =3D=3D NERR_UserNotFound)=20=0A=
 	    fprintf (stderr, "That user doesn't exist.\n");=0A=
 	  exit (1);=0A=

------_=_NextPart_000_01C17C6A.D804B7D0--
