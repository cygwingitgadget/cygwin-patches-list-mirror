Return-Path: <cygwin-patches-return-3198-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2083 invoked by alias); 16 Nov 2002 13:01:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2069 invoked from network); 16 Nov 2002 13:01:42 -0000
From: "Ronald Landheer-Cieslak" <info@rlsystems.net>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: FW: path to /etc/profile.default
Date: Sat, 16 Nov 2002 05:01:00 -0000
Message-ID: <NFBBLOMHALONCDMPGBLFKEONECAA.info@rlsystems.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q4/txt/msg00149.txt.bz2

Hi y'all,

After brushing up on my C++, getting married, etc. etc. I decided to=20
check out the source of cygwin to see if there's anything I can do on=20
the work I kinda promised a while ago. Had to apply a little "patch" to=20
the CVSROOT though, so to help you incite others to help you, here's the=20
"patch"

Bye,

Ronald

--- profile.default~    2002-07-30 16:20:08.000000000 +0200
+++ profile.default     2002-11-16 13:38:38.000000000 +0100
@@ -40,7 +40,7 @@
 export CVS_RSH=3D/bin/ssh

 # Patches to Cygwin always appreciated ;)
-#export CVSROOT=3D:pserver:anoncvs@anoncvs.cygnus.com:/cvs/src
+#export CVSROOT=3D:pserver:anoncvs@sources.redhat.com:/cvs/src

 # Set a HOSTNAME variable to the host name in lower case letters
 export HOSTNAME=3D`hostname | tr '[A-Z]' '[a-z]'`
