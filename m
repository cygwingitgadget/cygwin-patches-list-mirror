Return-Path: <cygwin-patches-return-3805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10029 invoked by alias); 14 Apr 2003 01:58:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10020 invoked from network); 14 Apr 2003 01:58:19 -0000
Message-Id: <3.0.5.32.20030413215851.007fb560@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Mon, 14 Apr 2003 01:58:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: date from mkvers.sh
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00032.txt.bz2

CYGWIN_ME-4.90 hpn5170x 1.3.23(0.82/3/2) 2003-04-010 21:49 i686 unknown
unknown Cygwin

Note the weird day in the date field.
There is a fix below but why not simply use  date "+%F %R" ? 

Pierre

2003-04-13  Pierre Humblet  <pierre.humblet@ieee.org>

	* mkvers.sh: Prefix day with 0 in date only when day < 10.


Index: mkvers.sh
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mkvers.sh,v
retrieving revision 1.14
diff -u -p -r1.14 mkvers.sh
--- mkvers.sh   13 Jan 2002 20:03:03 -0000      1.14
+++ mkvers.sh   13 Apr 2003 21:34:34 -0000
@@ -45,7 +45,7 @@ case "$2" in
     Dec) m=12 ;;
 esac
 
-if [ "$3" -le 10 ]; then
+if [ "$3" -lt 10 ]; then
     d=0$3
 else
     d=$3
 
