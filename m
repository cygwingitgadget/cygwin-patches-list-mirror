Return-Path: <cygwin-patches-return-4035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12970 invoked by alias); 3 Aug 2003 22:19:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12961 invoked from network); 3 Aug 2003 22:19:30 -0000
Resent-Date: Sun,  3 Aug 2003 23:19:27 +0100
Resent-Message-Id: <3291-Sun03Aug2003231927+0100-david@starks-browning.com>
X-Resent-Mailer: emacs 21.2.1 (via feedmail 8 I)
Resent-From: David Starks-Browning <david@starks-browning.com>
Resent-To: cygwin-patches@cygwin.com
Message-Id: <5835-Sun03Aug2003230604+0100-david@starks-browning.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20030213024144.1284.qmail@sources.redhat.com>
References: <20030213024144.1284.qmail@sources.redhat.com>
From: David Starks-Browning <david@starks-browning.com>
To: cygwin-patches@cygwin.com
Subject: winsup MAINTAINERS
Date: Sun, 03 Aug 2003 22:19:00 -0000
X-SW-Source: 2003-q3/txt/msg00051.txt.bz2

Sorry for this blast from the past:

On  13 Feb 03, cgf@.... writes:
> CVSROOT:	/cvs/uberbaum
> Module name:	winsup
> Changes by:	cgf@....	2003-02-13 02:41:44
> 
> Modified files:
> 	.              : ChangeLog 
> Removed files:
> 	.              : MAINTAINERS 
> 
> Log message:
> 	* MAINTAINERS: Remove out-of-date file.

In that case you might wish to apply this patch to /src/MAINTAINERS,
or instruct me to do it.

Regards,
David

diff -u -r1.19 MAINTAINERS
--- MAINTAINERS 3 May 2003 00:44:23 -0000       1.19
+++ MAINTAINERS 3 Aug 2003 22:02:12 -0000
@@ -98,7 +98,6 @@
        cygwin: http://sources.redhat.com/cygwin
        Patches to cygwin-patches@sources.redhat.com.
        General discussion cygwin@sources.redhat.com.
-       See also winsup/MAINTAINERS.
 
 expect/; config-ml.in; mpw-README; mpw-build.in; mpw-config.in;
 mpw-configure; mpw-install; setup.com; missing; makefile.vms; utils/;


