Return-Path: <cygwin-patches-return-3921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1039 invoked by alias); 3 Jun 2003 16:40:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 995 invoked from network); 3 Jun 2003 16:40:27 -0000
Message-ID: <3EDCCE5F.70509@ford.com>
Date: Tue, 03 Jun 2003 16:40:00 -0000
From: Kelley Cook <kcook34@ford.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] One liner to allow i786 in cygwin
Content-Type: multipart/mixed;
 boundary="------------050000090503010700010904"
X-MW-BTID: 090125000020031546002000000
X-MW-CTIME: 1054658420
HOP-COUNT: 1
X-MAILWATCH-INSTANCEID: 0102001e09f5e24f-5e46-418b-a42b-aa8cd07f1467
X-OriginalArrivalTime: 03 Jun 2003 16:40:20.0615 (UTC) FILETIME=[D2720970:01C329EE]
X-SW-Source: 2003-q2/txt/msg00148.txt.bz2

This is a multi-part message in MIME format.
--------------050000090503010700010904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 811

This patch allows the Cygwin DLL to be configured and compiled for
--{host,build,target}=i786-pc-cygwin.

After applying a pending patch to the toplevel config.sub as well as the
hand changing the questionable old copies of config.sub that need to be
in the mingw and w32api directories,  I have configured, compiled and
installed the DLL for --{host,build,target}=pentium4-pc-cygwin.  A make
check showed zero unexpected failures and one unexpected pass:
ltp/gethostid01.c.

Similar patches have already been installed for the toplevel, binutils,
libiberty, and newlib.

I also have a simple autoconf/automake patch pending which corrects the
need for the (IMO bogus) mingw/w32api config.{sub,guess}.  Should I also
post that patch here for inclusion in the Cygwin versions of
autoconf/automake.

Kelley Cook


--------------050000090503010700010904
Content-Type: text/plain;
 name="cygwini786.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwini786.diff"
Content-length: 468

2003-06-03  Kelley Cook  <kelleycook@wideopenwest.com>

	* configure.in: Allow i786 variant.
	* configure: Regenerate.

--- cygwin/configure.in.orig	2003-06-03 10:43:30.000000000 -0400
+++ cygwin/configure.in	2003-06-03 10:27:26.000000000 -0400
@@ -205,7 +205,7 @@
 dnl fi
 
 case "$target_cpu" in
-   i386|i486|i586|i686) DLL_ENTRY="_dll_entry@12"
+   i[[3-7]]86)	DLL_ENTRY="_dll_entry@12"
 		DEF_DLL_ENTRY="dll_entry@12"
 		ALLOCA="_alloca"
 		CONFIG_DIR="i386"  ;;

--------------050000090503010700010904--
