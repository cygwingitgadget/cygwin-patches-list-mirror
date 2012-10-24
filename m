Return-Path: <cygwin-patches-return-7757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1164 invoked by alias); 24 Oct 2012 13:43:40 -0000
Received: (qmail 32374 invoked by uid 22791); 24 Oct 2012 13:43:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 24 Oct 2012 13:42:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A0DE32C00AF; Wed, 24 Oct 2012 15:42:55 +0200 (CEST)
Date: Wed, 24 Oct 2012 13:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: gcc-patches@gcc.gnu.org, cygwin-patches@cygwin.com,	gdb-patches@sourceware.org, binutils@sourceware.org
Subject: [toplevel patch] Simplify FLAGS_FOR_TARGET for Cygwin
Message-ID: <20121024134255.GC31527@calimero.vinschen.de>
Reply-To: gcc-patches@gcc.gnu.org, cygwin-patches@cygwin.com,	gdb-patches@sourceware.org, binutils@sourceware.org
Mail-Followup-To: gcc-patches@gcc.gnu.org, cygwin-patches@cygwin.com,	gdb-patches@sourceware.org, binutils@sourceware.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00034.txt.bz2

Hi guys,

I just applied the below patch to the sourceware src repo.  The reason
for the patch is that Cygwin won't be using the in-tree mingw and w32api
any longer, but instead it requires an external installation of a
Mingw64 based w32api, and a Mingw64 build environment to build the
native Windows utilities.  Additionally the FLAGS_FOR_TARGET contains
one dir which doesn't contain any libs (winsup) and one dir which doesn't
exist (winsup/include).  The below patch only changes FLAGS_FOR_TARGET
accordingly.

Could somebody with toplevel checkin rights in the gcc repo please apply
this patch there, too?


Thanks,
Corinna


2012-10-24  Corinna Vinschen  <corinna AT vinschen DOT de>

	* configure.ac (FLAGS_FOR_TARGET,target=cygwin): Fix for building
	against Mingw64 w32api.
	* configure: Regenerate.


Index: configure.ac
===================================================================
RCS file: /cvs/src/src/configure.ac,v
retrieving revision 1.176
diff -u -p -r1.176 configure.ac
--- configure.ac	23 Oct 2012 23:02:33 -0000	1.176
+++ configure.ac	24 Oct 2012 13:39:56 -0000
@@ -2827,7 +2827,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 
Index: configure
===================================================================
RCS file: /cvs/src/src/configure,v
retrieving revision 1.432
diff -u -p -r1.432 configure
--- configure	23 Oct 2012 23:02:33 -0000	1.432
+++ configure	24 Oct 2012 13:39:55 -0000
@@ -7301,7 +7301,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
