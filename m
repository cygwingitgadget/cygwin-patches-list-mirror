Return-Path: <cygwin-patches-return-7267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16264 invoked by alias); 4 Apr 2011 14:55:03 -0000
Received: (qmail 16244 invoked by uid 22791); 4 Apr 2011 14:55:02 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm26.bullet.mail.bf1.yahoo.com (HELO nm26.bullet.mail.bf1.yahoo.com) (98.139.212.185)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 14:54:58 +0000
Received: from [98.139.212.151] by nm26.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:54:57 -0000
Received: from [98.139.213.7] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:54:57 -0000
Received: from [127.0.0.1] by smtp107.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:54:57 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp107.mail.bf1.yahoo.com with SMTP; 04 Apr 2011 07:54:57 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C86CB428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 10:54:56 -0400 (EDT)
Date: Mon, 04 Apr 2011 14:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
Message-ID: <20110404145456.GC1140@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301873845.3104.26.camel@YAAKOV04> <20110403235557.GA15529@ednor.casa.cgf.cx> <1301875911.3104.39.camel@YAAKOV04> <20110404051942.GA30475@ednor.casa.cgf.cx> <20110404105430.GN3669@calimero.vinschen.de> <1301916432.3104.76.camel@YAAKOV04> <20110404122647.GQ3669@calimero.vinschen.de> <1301920876.3104.78.camel@YAAKOV04> <20110404144226.GR3669@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110404144226.GR3669@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00033.txt.bz2

On Mon, Apr 04, 2011 at 04:42:26PM +0200, Corinna Vinschen wrote:
>On Apr  4 07:41, Yaakov (Cygwin/X) wrote:
>> 	* include/cygwin/types.h: Move #include <sys/sysmacros.h> to
>> 	end of header so the latter get the dev_t typedef.
>> 	* include/sys/sysmacros.h (gnu_dev_major, gnu_dev_minor,
>> 	gnu_dev_makedev): Prototype and define as inline functions.
>> 	(major, minor, makedev): Redefine in terms of gnu_dev_*.
>
>Looks good to me, except for a minor tweak...
>
>> Index: include/cygwin/types.h
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/types.h,v
>> retrieving revision 1.33
>> diff -u -r1.33 types.h
>> --- include/cygwin/types.h	29 Mar 2011 10:32:40 -0000	1.33
>> +++ include/cygwin/types.h	3 Apr 2011 20:43:20 -0000
>> @@ -17,7 +17,6 @@
>>  #ifndef _CYGWIN_TYPES_H
>>  #define _CYGWIN_TYPES_H
>>  
>> -#include <sys/sysmacros.h>
>>  #include <stdint.h>
>>  #include <endian.h>
>>  
>> @@ -220,6 +219,8 @@
>>  #endif /* __INSIDE_CYGWIN__ */
>>  #endif /* _CYGWIN_TYPES_H */
>>  
>> +#include <sys/sysmacros.h>
>> +
>
>...I would move this #include into the _CYGWIN_TYPES_H guarded area,
>two lines above.
>
>Oh, btw., while you're at it, would you mind to move the
>
> #ifdef __cplusplus
> extern "C"
> {
> #endif
>
>and 
>
> #ifdef __cplusplus
> }
> #endif
>
>into the _CYGWIN_TYPES_H guarded area as well?  I just noticed that for
>the first time.  Just a matter of taste I guess, but somehow this looks
>upside down to me.

Ditto * 2.

cgf
