Return-Path: <cygwin-patches-return-4045-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13959 invoked by alias); 8 Aug 2003 11:32:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13950 invoked from network); 8 Aug 2003 11:32:31 -0000
X-AuthUser: gerrit:koeln.convey.de
Date: Fri, 08 Aug 2003 11:32:00 -0000
From: "Gerrit P. Haase" <gp@familiehaase.de>
Organization: Esse keine toten Tiere
X-Priority: 3 (Normal)
Message-ID: <1231817066743.20030808133751@familiehaase.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] stdint.h define of INT32_MIN
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00061.txt.bz2

Hallo ,

The Open Group Base Specifications Issue 6 says here:
http://www.opengroup.org/onlinepubs/007904975/basedefs/stdint.h.html

"An N-bit signed type has values in the range -2**(N-1) or 1-2**(N-1)
to 2**(N-1)-1, while an N-bit unsigned type has values in the range 0
to 2**(N-1)."

Which is in this case:
 -2**31  = -2147483648
OR
 1-2**31 = -2147483647

Using #define INT32_MIN (-21474836478) breaks the perl build on
Cygwin because this constant is used in some typecasts, and it also
gives my this warning everytime INT32_MIN is used: 

xyz.c:2: warning: this decimal constant is unsigned only in ISO C90

Both of the below patches are ok. for me to build perl and also there
are no warnings issued, the first is the way it is defined on Linux
too, the second seems to be alright according to the SUS specs:

$ diff -udp stdint.h~ stdint.h
--- stdint.h~   2003-08-08 13:14:19.248036800 +0200
+++ stdint.h    2003-08-08 13:14:36.452776000 +0200
@@ -70,7 +70,7 @@ typedef unsigned long long uintmax_t;
 
 #define INT8_MIN (-128)
 #define INT16_MIN (-32768)
-#define INT32_MIN (-2147483648)
+#define INT32_MIN (-2147483647-1)
 #define INT64_MIN (-9223372036854775808)
 
 #define INT8_MAX (127)

# END

$ diff -udp stdint.h~ stdint.h
--- stdint.h~   2003-08-08 13:14:19.248036800 +0200
+++ stdint.h    2003-08-08 13:15:12.775004800 +0200
@@ -70,7 +70,7 @@ typedef unsigned long long uintmax_t;
 
 #define INT8_MIN (-128)
 #define INT16_MIN (-32768)
-#define INT32_MIN (-2147483648)
+#define INT32_MIN (-2147483647)
 #define INT64_MIN (-9223372036854775808)
 
 #define INT8_MAX (127)

# END

Gerrit
-- 
=^..^=
