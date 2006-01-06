Return-Path: <cygwin-patches-return-5704-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28050 invoked by alias); 6 Jan 2006 18:21:53 -0000
Received: (qmail 28041 invoked by uid 22791); 6 Jan 2006 18:21:53 -0000
X-Spam-Check-By: sourceware.org
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 06 Jan 2006 18:21:52 +0000
Received: from fulgurite.electric-cloud.com (FULGURITE.electric-cloud.com [192.168.1.160]) 	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id k06ILoV1022067 	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO) 	for <cygwin-patches@cygwin.com>; Fri, 6 Jan 2006 10:21:50 -0800
Subject: Re: sigproc_init() handling CreateThread() failures
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <1136497979.6371.31.camel@fulgurite>
References: <1136494247.6371.16.camel@fulgurite> 	 <20060105211752.GE26305@trixie.casa.cgf.cx> 	 <1136497979.6371.31.camel@fulgurite>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 18:21:00 -0000
Message-Id: <1136571707.4111.0.camel@fulgurite>
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
X-SW-Source: 2006-q1/txt/msg00013.txt.bz2

On Thu, 2006-01-05 at 13:52 -0800, Max Kaehn wrote:
> On Thu, 2006-01-05 at 16:17 -0500, Christopher Faylor wrote:
> > But, that is the whole point of setting my_sendsig to
> > INVALID_HANDLE_VALUE.
> 
> Which I would've picked up if I had read the change log (RTFCL). :-P
> 
> > >       * sigproc.cc (no_signals_available):  test for my_sendsig ==
> > >       INVALID_HANDLE_VALUE.
> 
> > This seems like it should work.  Does it have the same effect?
> 
> It looks good; I'll put it on the test machine and fire it up.  I
> can usually get the problem to reproduce by leaving a cycle of
> repeated builds running overnight, and I'll post the result
> to this thread tomorrow.

20 builds haven't reproduced the problem.  Thanks!


