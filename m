Return-Path: <cygwin-patches-return-7188-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23441 invoked by alias); 10 Feb 2011 15:30:08 -0000
Received: (qmail 23166 invoked by uid 22791); 10 Feb 2011 15:30:06 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm27-vm0.bullet.mail.ne1.yahoo.com (HELO nm27-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.63)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 10 Feb 2011 15:30:01 +0000
Received: from [98.138.90.56] by nm27.bullet.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 15:29:59 -0000
Received: from [98.138.84.41] by tm9.bullet.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 15:29:59 -0000
Received: from [127.0.0.1] by smtp109.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 15:29:59 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp109.mail.ne1.yahoo.com with SMTP; 10 Feb 2011 07:29:58 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E973413C0CA	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 10:29:57 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id E35FC2B352; Thu, 10 Feb 2011 10:29:57 -0500 (EST)
Date: Thu, 10 Feb 2011 15:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
Message-ID: <20110210152957.GB26842@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com> <20110210141515.GB25992@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110210141515.GB25992@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00043.txt.bz2

On Thu, Feb 10, 2011 at 03:15:15PM +0100, Corinna Vinschen wrote:
>On Feb 10 21:47, jojelino wrote:
>> On 2011-02-10 19:02, Corinna Vinschen wrote:
>> 
>> >Also, it would be nice if you would add more words to explain what your
>> >patch is doing.  Just a patch with no explanation is not very inviting
>> >to take a look at it at all.
>> 
>> this patch deals with only "two" problem. and this is "first" one.
>> 
>> static char * (*findenv_func)(const char *, int *) = (char *
>> (*)(const char *, int *)) getearly;
>> findenv_func is declared without __stdcall convention, and it is
>> casting getearly having __stdcall convention with function type
>> without __stdcall convention. to fix this problem, add __stdcall to
>> findenv_func.
>> 
>> and this is "another" one.
>> 
>> this one deals with compilation error that gcc 4.6 complained. so i
>> just copy & paste __attribute__((regparm (x))) from function
>> declaration to function definition, so i must admit that this one
>> was derived from original cygwin source code. that is, you can fix
>> it without this patch.
>
>Ok, I have just a problem.  Your patch doesn't apply because your
>mail client appears to insert line breaks if the lines get too long.
>Please send the patch again without the line breaks.  Maybe you could
>just attach it to your mail rather than inlining it.

Please don't just apply it.  Some of the changes suffered from a cut/paste
mentality, where the right solution was not always to just add a __stdcall.

The patch needs to actually be studied and probably applied piecemeal.

I'm also not sure why gcc changed its behavior in this way for 4.6.  I
wonder if it is intended.  Dave, can you confirm or deny?

cgf
