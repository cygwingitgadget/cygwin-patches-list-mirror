Return-Path: <cygwin-patches-return-5625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9804 invoked by alias); 17 Aug 2005 01:13:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9239 invoked by uid 22791); 17 Aug 2005 01:13:00 -0000
Received: from dessent.net (HELO dessent.net) (69.60.119.225)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 17 Aug 2005 01:13:00 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.52)
	id 1E5CUE-0000F6-KK
	for cygwin-patches@cygwin.com; Wed, 17 Aug 2005 01:12:58 +0000
Message-ID: <43028FCF.E134BB01@dessent.net>
Date: Wed, 17 Aug 2005 01:13:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu> <4302715C.528696C3@dessent.net> <430274CC.FA870D37@dessent.net> <4302850A.A3AC4F4E@dessent.net> <20050817003013.GA22307@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00080.txt.bz2

Christopher Faylor wrote:

> Go ahead and check this in.  Thanks.

Ok.

> Thanks, Igor, for bringing this up (again).

Thanks Igor, I had meant to bring this up but forgot.

> There's no need to ping anybody.  I do read this list and I haven't
> forgotten about the patch.  If it didn't require changs to a file
> on sourceware.org, I'd have checked it in by now.

I can rework the patch if there are parts of it that are objectionable. 
I figured that parsing html in C without external libraries was kind of
silly when we have control of the cgi script on the other end.

Brian
