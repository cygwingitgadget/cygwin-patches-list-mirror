Return-Path: <cygwin-patches-return-5702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8386 invoked by alias); 5 Jan 2006 21:53:02 -0000
Received: (qmail 8377 invoked by uid 22791); 5 Jan 2006 21:53:02 -0000
X-Spam-Check-By: sourceware.org
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Jan 2006 21:53:01 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.160]) 	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id k05LqxTF025103 	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO) 	for <cygwin-patches@cygwin.com>; Thu, 5 Jan 2006 13:52:59 -0800
Subject: Re: sigproc_init() handling CreateThread() failures
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20060105211752.GE26305@trixie.casa.cgf.cx>
References: <1136494247.6371.16.camel@fulgurite> 	 <20060105211752.GE26305@trixie.casa.cgf.cx>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 21:53:00 -0000
Message-Id: <1136497979.6371.31.camel@fulgurite>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00011.txt.bz2

On Thu, 2006-01-05 at 16:17 -0500, Christopher Faylor wrote:
> But, that is the whole point of setting my_sendsig to
> INVALID_HANDLE_VALUE.

Which I would've picked up if I had read the change log (RTFCL). :-P

> >       * sigproc.cc (no_signals_available):  test for my_sendsig ==
> >       INVALID_HANDLE_VALUE.

> This seems like it should work.  Does it have the same effect?

It looks good; I'll put it on the test machine and fire it up.  I
can usually get the problem to reproduce by leaving a cycle of
repeated builds running overnight, and I'll post the result
to this thread tomorrow.



