Return-Path: <cygwin-patches-return-3347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14896 invoked by alias); 20 Dec 2002 02:01:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14885 invoked from network); 20 Dec 2002 02:01:57 -0000
Message-Id: <3.0.5.32.20021219210102.0080d840@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 19 Dec 2002 18:01:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: localtime.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00298.txt.bz2

While I am at it, there is also this one. It's an improvement, not
a bug fix, cutting down on tzset trashing around as visible in strace.

Pierre

2002-12-19  Pierre Humblet <pierre.humblet@ieee.org>

	* localtime.cc (tzsetwall): Set lcl_is_set and lcl_TZname
	in the Cygwin specific part of the routine.

Index: localtime.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/localtime.cc,v
retrieving revision 1.7
diff -u -p -r1.7 localtime.cc
--- localtime.cc        23 Sep 2002 00:31:30 -0000      1.7
+++ localtime.cc        20 Dec 2002 01:53:34 -0000
@@ -1451,7 +1451,9 @@ tzsetwall P((void))
            /* printf("TZ deduced as `%s'\n", buf); */
            if (tzparse(buf, lclptr, FALSE) == 0) {
                settzname();
-               setenv("TZ", buf, 1);
+               lcl_is_set = 1;
+               strlcpy(lcl_TZname, buf, sizeof (lcl_TZname));
+               setenv("TZ", lcl_TZname, 1);
                return;
            }
        }
