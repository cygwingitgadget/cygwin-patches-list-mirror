Return-Path: <cygwin-patches-return-6095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22478 invoked by alias); 19 May 2007 17:18:54 -0000
Received: (qmail 22467 invoked by uid 22791); 19 May 2007 17:18:53 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout03.sul.t-online.com (HELO mailout03.sul.t-online.com) (194.25.134.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 19 May 2007 17:18:50 +0000
Received: from fwd31.aul.t-online.de  	by mailout03.sul.t-online.com with smtp  	id 1HpSZr-0001fQ-06; Sat, 19 May 2007 19:18:47 +0200
Received: from [10.3.2.2] (bHfpW-Z-geGKSPJitqj6H1B0TU4BUBmQD5VF6fqB66HrQnyLVwNY8C@[217.235.221.250]) by fwd31.sul.t-online.de 	with esmtp id 1HpSZi-0g4kz20; Sat, 19 May 2007 19:18:38 +0200
Message-ID: <464F3174.6030306@t-online.de>
Date: Sat, 19 May 2007 17:18:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]   ddrescue  1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de> <464F25DB.3030105@portugalmail.pt>
In-Reply-To: <464F25DB.3030105@portugalmail.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bHfpW-Z-geGKSPJitqj6H1B0TU4BUBmQD5VF6fqB66HrQnyLVwNY8C
X-TOI-MSGID: 4b2e156c-0efc-4863-8b0e-03a4ec7df681
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00041.txt.bz2

Pedro Alves wrote:
> ...
> I'm just looking at fhandler_floopy.cc for the first time,
> but, isn't there the possibility that bytes_left can be a bit too big
> for alloca?  

AFAIK not: bytes_left is always less than bytes_per_sector.
The _dev_floppy class is only used for Floppy (512), HD (usually 512) 
and CD (2048) devices.


> It looks like that the raw_read call is there to
> advance the position by the needed amount (moving back is forbidden
> a bit above).  Perhaps it would be better to read in a loop with
> read amount limited by the size of the buffer:
>
> while more bytes
> do
>     read minimum of bytes left or size of buffer
>     if couldn't read, bail out. (oooops internal state broken now).
> done
>

BTW: This "oooops" may be an issue in the current code.
The lseek() call returns success if raw_read() fails.
This may possibly lead to undetected read errors in very rare cases.

Christian
