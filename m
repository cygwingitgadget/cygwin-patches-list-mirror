Return-Path: <cygwin-patches-return-2120-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12866 invoked by alias); 28 Apr 2002 19:56:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12852 invoked from network); 28 Apr 2002 19:56:43 -0000
From: "Norbert Schulze" <Norbert.Schulze@web.de>
To: <cygwin-patches@cygwin.com>
Subject: automatic TZ in non-english windows
Date: Sun, 28 Apr 2002 12:56:00 -0000
Message-ID: <000001c1eeee$bf3e8fe0$010115ac@NEXUS>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C1EEFF.82C8E680"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00104.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C1EEFF.82C8E680
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 306

In some non-english windows versions tzsetwall generates an invalid
timezone name for the TZ variable. The name length must be at least
3 characters.

ChangeLog:

2002-04-28  Norbert Schulze  <norbert.schulze@web.de>

        * localtime.cc (tzsetwall): use wildabbr if generated timezone name
length < 3


------=_NextPart_000_0001_01C1EEFF.82C8E680
Content-Type: application/octet-stream;
	name="loacaltime.cc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="loacaltime.cc.patch"
Content-length: 1220

--- ../localtime.cc	Thu Dec 20 02:33:50 2001=0A=
+++ localtime.cc	Sun Apr 28 21:28:29 2002=0A=
@@ -1396,10 +1396,10 @@ tzsetwall P((void))=0A=
 	    dst =3D cp =3D buf;=0A=
 	    for (src =3D tz.StandardName; *src; src++)=0A=
 	      if (is_upper(*src)) *dst++ =3D *src;=0A=
-	    if (cp =3D=3D dst)=0A=
+	    if ((dst - cp) < 3)=0A=
 	      {=0A=
-		/* In Asian Windows, tz.StandardName may not contain=0A=
-		   the timezone name. */=0A=
+		/* In non-english Windows, converted tz.StandardName=0A=
+		   may not contain a valid standard timezone name. */=0A=
 		strcpy(cp, wildabbr);=0A=
 		cp +=3D strlen(wildabbr);=0A=
 	      }=0A=
@@ -1414,11 +1414,11 @@ tzsetwall P((void))=0A=
 		dst =3D cp;=0A=
 		for (src =3D tz.DaylightName; *src; src++)=0A=
 		  if (is_upper(*src)) *dst++ =3D *src;=0A=
-		if (cp =3D=3D dst)=0A=
+		if ((dst - cp) < 3)=0A=
 		  {=0A=
-		    /* In Asian Windows, tz.StandardName may not contain=0A=
-		       the daylight name. */=0A=
-		    strcpy(buf, wildabbr);=0A=
+		    /* In non-english Windows, converted tz.DaylightName=0A=
+		       may not contain a valid daylight timezone name. */=0A=
+		    strcpy(cp, wildabbr);=0A=
 		    cp +=3D strlen(wildabbr);=0A=
 		  }=0A=
 		else=0A=

------=_NextPart_000_0001_01C1EEFF.82C8E680--

