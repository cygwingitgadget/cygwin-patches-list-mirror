Return-Path: <cygwin-patches-return-3959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24094 invoked by alias); 13 Jun 2003 12:11:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24012 invoked from network); 13 Jun 2003 12:11:38 -0000
Message-ID: <3EE9BF64.2060204@ford.com>
Date: Fri, 13 Jun 2003 12:11:00 -0000
From: Kelley Cook <kcook34@ford.com>
Reply-To: Kelley Cook <kelleycook@wideopenwest.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Ping:  [PATCH] One liner to allow i786 (aka pentium4) in cygwin
References: <3EDCCE5F.70509@ford.com>
In-Reply-To: <3EDCCE5F.70509@ford.com>
Content-Type: multipart/mixed;
 boundary="------------020105010004060104050706"
X-MW-BTID: 090425000020031644389700010
X-MW-CTIME: 1055506297
HOP-COUNT: 1
X-MAILWATCH-INSTANCEID: 0102001ff5dc8b83-7f71-475a-84ff-9b7f3ea7206a
X-OriginalArrivalTime: 13 Jun 2003 12:11:37.0757 (UTC) FILETIME=[F09AA4D0:01C331A4]
X-SW-Source: 2003-q2/txt/msg00186.txt.bz2

This is a multi-part message in MIME format.
--------------020105010004060104050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1409

A ping of this simple patch from ten days ago.  In the meantime, the 
sources.redhat.com
toplevel config.sub has pulled in the code to bless the 
pentium4-pc-cygwin target triple
as an alias for i786-pc-cygwin.

Note that as mentioned below either {mingw,w32api}/config.{guess,sub} 
should also
be updated to match the toplevel, or I have a really simple autoconf 
patch that will let you
delete those bogus copies and properly use the toplevel versions.

Let me know if you want to use that autoconf patch, for a cygwin 
specific patch.

KC

Kelley Cook wrote:

> This patch allows the Cygwin DLL to be configured and compiled for
> --{host,build,target}=i786-pc-cygwin.
>
> After applying a pending patch to the toplevel config.sub as well as the
> hand changing the questionable old copies of config.sub that need to be
> in the mingw and w32api directories,  I have configured, compiled and
> installed the DLL for --{host,build,target}=pentium4-pc-cygwin.  A make
> check showed zero unexpected failures and one unexpected pass:
> ltp/gethostid01.c.
>
> Similar patches have already been installed for the toplevel, binutils,
> libiberty, and newlib.
>
> I also have a simple autoconf/automake patch pending which corrects the
> need for the (IMO bogus) mingw/w32api config.{sub,guess}.  Should I also
> post that patch here for inclusion in the Cygwin versions of
> autoconf/automake.
>
> Kelley Cook



--------------020105010004060104050706
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

--------------020105010004060104050706--
