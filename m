Return-Path: <cygwin-patches-return-2747-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9492 invoked by alias); 30 Jul 2002 01:19:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9478 invoked from network); 30 Jul 2002 01:19:58 -0000
Message-Id: <3.0.5.32.20020729211608.0081e380@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 29 Jul 2002 18:19:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: setgroups
In-Reply-To: <20020726105948.A30785@cygbert.vinschen.de>
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com>
 <3.0.5.32.20020726000410.00813de0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00195.txt.bz2

At 10:59 AM 7/26/2002 +0200, Corinna Vinschen wrote:
>> I still need to declare it in an .h file.
>> Should it be in src/newlib/libc/include/sys/unistd.h ?
>
>What about adding it to newlib/libc/sys/cygwin/include/unistd.h?

Corinna, 
here it is

2002-07-29  Pierre Humblet  <pierre.humblet@ieee.org>

	* libc/sys/cygwin/include/unistd.h: Declare setgroups.


--- unistd.h.orig       2001-12-17 16:32:26.000000000 -0500
+++ unistd.h    2002-07-29 21:01:50.000000000 -0400
@@ -4,6 +4,7 @@
 #define _UNISTD_H_
 
 # include <sys/unistd.h>
+int     _EXFUN(setgroups, (int ngroups, const gid_t *grouplist ));
 # define __UNISTD_GETOPT__
 # include <getopt.h>
 # undef __UNISTD_GETOPT__
