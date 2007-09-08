Return-Path: <cygwin-patches-return-6146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17767 invoked by alias); 8 Sep 2007 02:57:30 -0000
Received: (qmail 17754 invoked by uid 22791); 8 Sep 2007 02:57:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-174-251-188.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (71.174.251.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Sep 2007 02:57:21 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 269DB2B353; Fri,  7 Sep 2007 22:57:20 -0400 (EDT)
Date: Sat, 08 Sep 2007 02:57:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] inline __getreent in newlib
Message-ID: <20070908025720.GA10008@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46E08F5C.D534F44E@dessent.net> <20070907001523.GA27234@ednor.casa.cgf.cx> <46E0A004.2BA35626@dessent.net> <46E1DC70.57961D04@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E1DC70.57961D04@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00021.txt.bz2

On Fri, Sep 07, 2007 at 04:19:12PM -0700, Brian Dessent wrote:
>Brian Dessent wrote:
>
>> Done.  I added the following comment to config.h to hopefully clarify
>> the situation:
>> 
>> /* The following provides an inline version of __getreent() for newlib,
>>    which will be used throughout the library whereever there is a _r
>>    version of a function that takes _REENT.  This saves the overhead
>>    of a function call for what amounts to a simple computation.
>> 
>>    The definition below is essentially equivalent to the one in cygtls.h
>>    (&_my_tls.local_clib) however it uses a fixed precomputed
>>    offset rather than dereferencing a field of a structure.
>> 
>>    Including tlsoffets.h here in order to get this constant offset
>>    tls_local_clib is a bit of a hack, but the alternative would require
>>    dragging the entire definition of struct _cygtls (a large and complex
>>    Cygwin internal data structure) into newlib.  The machinery to
>>    compute these offsets already exists for the sake of gendef so
>>    we might as well just use it here.  */
>
>Turns out that <sys/config.h> includes <cygwin/config.h>, which leads to
>this breakage when the winsup headers are installed in the system
>location:
>
>$ echo "#include <math.h>" | gcc -x c -
>In file included from /usr/include/sys/config.h:180,
>                 from /usr/include/_ansi.h:16,
>                 from /usr/include/sys/reent.h:13,
>                 from /usr/include/math.h:5,
>                 from <stdin>:1:
>/usr/include/cygwin/config.h:22:27: ../tlsoffsets.h: No such file or
>directory
>
>Attached patch fixes the situation by only exposing this when
>_COMPILING_NEWLIB.  Ok?

Yes.

Thanks.

cgf
