Return-Path: <cygwin-patches-return-6506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23046 invoked by alias); 11 Apr 2009 19:38:17 -0000
Received: (qmail 23036 invoked by uid 22791); 11 Apr 2009 19:38:16 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from fk-out-0910.google.com (HELO fk-out-0910.google.com) (209.85.128.191)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 19:38:11 +0000
Received: by fk-out-0910.google.com with SMTP id z22so700912fkz.2         for <cygwin-patches@cygwin.com>; Sat, 11 Apr 2009 12:38:07 -0700 (PDT)
Received: by 10.103.49.12 with SMTP id b12mr2485139muk.65.1239478687743;         Sat, 11 Apr 2009 12:38:07 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id s11sm5885208mue.17.2009.04.11.12.38.06         (version=SSLv3 cipher=RC4-MD5);         Sat, 11 Apr 2009 12:38:07 -0700 (PDT)
Message-ID: <49E0F413.6090008@gmail.com>
Date: Sat, 11 Apr 2009 19:38:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com> <20090411080736.GA25426@calimero.vinschen.de> <20090411180023.GA3324@ednor.casa.cgf.cx> <49E0DED2.5020601@gmail.com> <20090411191717.GA10686@ednor.casa.cgf.cx>
In-Reply-To: <20090411191717.GA10686@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------030505010908000409010805"
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
X-SW-Source: 2009-q2/txt/msg00048.txt.bz2

This is a multi-part message in MIME format.
--------------030505010908000409010805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 356

Christopher Faylor wrote:

> 
> So the answer is "int".


  Oh, drat.  Yes, shoulda changed the type, not the constant.  Gah.  Like
this, you mean?


winsup/cygwin/ChangeLog

	* include/stdint.h (intptr_t):  Remove long from type.
	(uintptr_t):  Likewise.
	(INTPTR_MIN):  Remove 'L' suffix.
	(INTPTR_MAX, UINTPTR_MAX):  Likewise.


    cheers,
      DaveK

--------------030505010908000409010805
Content-Type: text/x-c;
 name="stdint-h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stdint-h.diff"
Content-length: 950

Index: stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.12
diff -p -u -r1.12 stdint.h
--- stdint.h	11 Apr 2009 08:07:30 -0000	1.12
+++ stdint.h	11 Apr 2009 19:35:11 -0000
@@ -57,9 +57,9 @@ typedef unsigned long long uint_fast64_t
 
 #ifndef __intptr_t_defined
 #define __intptr_t_defined
-typedef long intptr_t;
+typedef int intptr_t;
 #endif
-typedef unsigned long uintptr_t;
+typedef unsigned int uintptr_t;
 
 /* Greatest-width integer types */
 
@@ -119,9 +119,9 @@ typedef unsigned long long uintmax_t;
 
 /* Limits of integer types capable of holding object pointers */
 
-#define INTPTR_MIN (-2147483647L - 1L)
-#define INTPTR_MAX (2147483647L)
-#define UINTPTR_MAX (4294967295UL)
+#define INTPTR_MIN (-2147483647 - 1)
+#define INTPTR_MAX (2147483647)
+#define UINTPTR_MAX (4294967295U)
 
 /* Limits of greatest-width integer types */
 

--------------030505010908000409010805--
