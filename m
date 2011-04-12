Return-Path: <cygwin-patches-return-7281-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28186 invoked by alias); 12 Apr 2011 19:24:52 -0000
Received: (qmail 28176 invoked by uid 22791); 12 Apr 2011 19:24:52 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm14-vm0.bullet.mail.sp2.yahoo.com (HELO nm14-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.246)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 12 Apr 2011 19:24:47 +0000
Received: from [98.139.91.61] by nm14.bullet.mail.sp2.yahoo.com with NNFMP; 12 Apr 2011 19:24:47 -0000
Received: from [98.136.185.28] by tm1.bullet.mail.sp2.yahoo.com with NNFMP; 12 Apr 2011 19:24:47 -0000
Received: from [127.0.0.1] by smtp109.mail.gq1.yahoo.com with NNFMP; 12 Apr 2011 19:24:47 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp109.mail.gq1.yahoo.com with SMTP; 12 Apr 2011 12:24:46 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 64CFC4A801A	for <cygwin-patches@cygwin.com>; Tue, 12 Apr 2011 15:24:45 -0400 (EDT)
Date: Tue, 12 Apr 2011 19:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix for strace manpage
Message-ID: <20110412192444.GA9665@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DA4A55F.8040407@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA4A55F.8040407@dronecode.org.uk>
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
X-SW-Source: 2011-q2/txt/msg00047.txt.bz2

On Tue, Apr 12, 2011 at 08:17:51PM +0100, Jon TURNEY wrote:
>
>'man strace' contains the rather confusing text:
>
>>        -T, --toggle
>>               toggle tracing in a process already being
>> 
>>        -u, --usecs
>>               toggle printing of microseconds timestamp traced. Requires -p <pid>
>
>This seems to be due to the description of -u being added in between the two
>lines which describe -T in utils.sgml revision 1.56.  Attached patch puts them
>in the right order:
>
>>        -T, --toggle
>>               toggle tracing in a process already being traced. Requires -p <pid>
>> 
>>        -u, --usecs
>>               toggle printing of microseconds timestamp 
>
>2011-04-12  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>        * utils.sgml (strace): Fix a pair of exchanged lines in usage text.

Thanks for catching.

Please check in.

cgf
