Return-Path: <cygwin-patches-return-6100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24709 invoked by alias); 21 May 2007 17:15:54 -0000
Received: (qmail 24671 invoked by uid 22791); 21 May 2007 17:15:48 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout06.sul.t-online.com (HELO mailout06.sul.t-online.com) (194.25.134.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 May 2007 17:15:42 +0000
Received: from fwd31.aul.t-online.de  	by mailout06.sul.t-online.com with smtp  	id 1HqBTv-0003h4-02; Mon, 21 May 2007 19:15:39 +0200
Received: from [10.3.2.2] (SrcxCkZVgezg7yRDappNLyavWiEf+6ulLPB1nJF8KPoc33+K-9fg8q@[217.235.232.143]) by fwd31.sul.t-online.de 	with esmtp id 1HqBTl-1ggxSS0; Mon, 21 May 2007 19:15:29 +0200
Message-ID: <4651D3B1.3030908@t-online.de>
Date: Mon, 21 May 2007 17:15:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  ddrescue 1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de> <465062E9.4030003@t-online.de> <20070521092201.GA6003@calimero.vinschen.de>
In-Reply-To: <20070521092201.GA6003@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SrcxCkZVgezg7yRDappNLyavWiEf+6ulLPB1nJF8KPoc33+K-9fg8q
X-TOI-MSGID: a9881f9b-fcd0-4ebd-900c-55dc6e12466b
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00046.txt.bz2

Corinna Vinschen wrote:
> As for the devbuf part of the patch, it's missing a ChangeLog entry.
> Can you please send one, possibly in present tense?  (Your first
> ChangeLog was incorrectly written in past tense)
>
>   


2007-05-21  Christian Franke <franke@computer.org>

	* fhandler_floppy.cc (fhandler_dev_floppy::lseek): Don't invalidate
	devbuf if new position is within buffered range.



Christian
