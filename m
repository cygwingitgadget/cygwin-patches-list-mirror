Return-Path: <cygwin-patches-return-7098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12111 invoked by alias); 11 Sep 2010 11:00:12 -0000
Received: (qmail 12094 invoked by uid 22791); 11 Sep 2010 11:00:11 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f45.google.com (HELO mail-ww0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Sep 2010 11:00:05 +0000
Received: by wwi18 with SMTP id 18so3417573wwi.2        for <cygwin-patches@cygwin.com>; Sat, 11 Sep 2010 04:00:03 -0700 (PDT)
Received: by 10.227.144.18 with SMTP id x18mr1132370wbu.190.1284202803688;        Sat, 11 Sep 2010 04:00:03 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id m25sm3179860wbc.1.2010.09.11.04.00.02        (version=SSLv3 cipher=RC4-MD5);        Sat, 11 Sep 2010 04:00:03 -0700 (PDT)
Message-ID: <4C8B6671.6000200@gmail.com>
Date: Sat, 11 Sep 2010 11:00:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com> <20100911051009.GA25209@ednor.casa.cgf.cx> <4C8B2B9B.8060801@gmail.com> <20100911080929.GL16534@calimero.vinschen.de>
In-Reply-To: <20100911080929.GL16534@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------060502070008070307000602"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.
--------------060502070008070307000602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-length: 321

On 11/09/2010 09:09, Corinna Vinschen wrote:
> Hi Dave,

  Morning!

> On Sep 11 08:11, Dave Korn wrote:
>> So, I ended up committing it like so:
> 
> Can you please add some words to doc/new-features.sgml?

  How's this look?

winsup/doc/ChangeLog:

	* new-features.sgml: Mention fenv support.

    cheers,
      DaveK


--------------060502070008070307000602
Content-Type: text/x-c;
 name="fenv-new-features.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fenv-new-features.diff"
Content-length: 1184

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.56
diff -p -u -r1.56 new-features.sgml
--- new-features.sgml	6 Sep 2010 14:42:30 -0000	1.56
+++ new-features.sgml	11 Sep 2010 10:57:56 -0000
@@ -5,6 +5,19 @@
 <itemizedlist mark="bullet">
 
 <listitem><para>
+Cygwin now ships the C standard library fenv.h header file, and implements the
+related APIs (including GNU/glibc extensions): feclearexcept, fedisableexcept,
+feenableexcept, fegetenv, fegetexcept, fegetexceptflag, fegetprec, fegetround,
+feholdexcept, feraiseexcept, fesetenv, fesetexceptflag, fesetprec, fesetround,
+fetestexcept, feupdateenv, and predefines both default and no-mask FP
+environments.  See the 
+<ulink url="http://www.opengroup.org/onlinepubs/000095399/basedefs/fenv.h.html">
+Single Unix Specification</ulink> and the
+<ulink url="http://www.gnu.org/software/libc/manual/html_node/Arithmetic.html">
+GNU C Library manual</ulink> for full details of this functionality.
+</para></listitem>
+
+<listitem><para>
 /proc/sys allows to access the native NT namespace.
 </para></listitem>
 

--------------060502070008070307000602--
