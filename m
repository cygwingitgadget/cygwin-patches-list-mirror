Return-Path: <cygwin-patches-return-7499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20935 invoked by alias); 29 Aug 2011 20:24:04 -0000
Received: (qmail 20923 invoked by uid 22791); 29 Aug 2011 20:24:03 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_CG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm21-vm3.bullet.mail.ne1.yahoo.com (HELO nm21-vm3.bullet.mail.ne1.yahoo.com) (98.138.91.151)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 29 Aug 2011 20:23:49 +0000
Received: from [98.138.90.55] by nm21.bullet.mail.ne1.yahoo.com with NNFMP; 29 Aug 2011 20:23:48 -0000
Received: from [98.138.226.60] by tm8.bullet.mail.ne1.yahoo.com with NNFMP; 29 Aug 2011 20:23:48 -0000
Received: from [127.0.0.1] by smtp211.mail.ne1.yahoo.com with NNFMP; 29 Aug 2011 20:23:48 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.51.40 with login)        by smtp211.mail.ne1.yahoo.com with SMTP; 29 Aug 2011 13:23:47 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E0F1B428012	for <cygwin-patches@cygwin.com>; Mon, 29 Aug 2011 16:23:46 -0400 (EDT)
Date: Mon, 29 Aug 2011 20:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] profile support
Message-ID: <20110829202346.GA26708@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CADEiHqLZAuJkDJKh4pJ4AOJ1JwUwV06RSkq3GdNihSKhiUswGw@mail.gmail.com> <20110820084946.GA30978@calimero.vinschen.de> <4E533502.4060207@gmail.com> <20110823054003.GA10003@ednor.casa.cgf.cx> <4E5BF23F.8060806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5BF23F.8060806@gmail.com>
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
X-SW-Source: 2011-q3/txt/msg00075.txt.bz2

On Tue, Aug 30, 2011 at 05:10:39AM +0900, jojelino wrote:
>On 2011-08-23 PM 2:40, Christopher Faylor wrote:
>> On Tue, Aug 23, 2011 at 02:05:06PM +0900, jojelino wrote:
>>> Index: winsup/cygwin/Makefile.in
>>> ===================================================================
>>> RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>>> retrieving revision 1.248
>>> diff -u -p -r1.248 Makefile.in
>>> --- winsup/cygwin/Makefile.in	2 May 2011 19:14:39 -0000	1.248
>>> +++ winsup/cygwin/Makefile.in	22 Aug 2011 20:27:57 -0000
>>> @@ -233,7 +233,7 @@ EXTRALIBS:=libautomode.a libbinmode.a li
>>> INSTOBJS:=automode.o binmode.o textmode.o textreadmode.o
>>> TARGET_LIBS:=$(LIB_NAME) $(CYGWIN_START) $(GMON_START) $(LIBGMON_A) $(SUBLIBS) $(INSTOBJS) $(EXTRALIBS)
>>>
>>> -ifneq "${filter -O%,$(CFLAGS)}" ""
>>> +ifneq "" ""
>>>
>>> -    void *rv = malloc(size);
>>> +    void *rv = LocalAlloc(0x40,size);
>>
>> There are a few things in your patch which make no sense.  The above are
>> two of them.  I am not going to look further.  The patch certainly can't
>> go in as is.
>>
>> cgf
>>
>The two of them is now
>
>  ifneq "${filter -O%,$(CFLAGS)}" ""
>+ifneq '$(profile)' '1'

That would be an 'ifdef'.

>  endif
>...
>...
>+endif
>
>+#if !defined(PROFILE)
>      void *rv = malloc(size);
>+#else
>+    void *rv = LocalAlloc(LMEM_FIXED,size);
>+#endif

Since the code is in gmon.c then I don't see a reason to #ifdef it but I
still don't understand the motivation for the change.  This is a major
amount of code and it is desperately missing comments.

Maybe Corinna will disagree but I think there is way too much code
change here for me to be comfortable with including it.  It looks like
it would be an ongoing maintenance issue, requiring constant vigilance
to avoid code rot.  And, it would have to be very carefully studied to
make sure there aren't more gotchas like 'if "" ""'.

Sorry, but I don't see us including this.

cgf
