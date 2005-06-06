Return-Path: <cygwin-patches-return-5530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 853 invoked by alias); 6 Jun 2005 23:51:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 843 invoked by uid 22791); 6 Jun 2005 23:51:38 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 23:51:38 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 300C813C28E; Mon,  6 Jun 2005 19:51:37 -0400 (EDT)
Date: Mon, 06 Jun 2005 23:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Message-ID: <20050606235137.GE16960@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118084587.5031.128.camel@fulgurite> <20050606200639.GC13442@trixie.casa.cgf.cx> <1118091704.5031.144.camel@fulgurite> <20050606213339.GC16960@trixie.casa.cgf.cx> <1118098448.5031.157.camel@fulgurite> <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu> <1118099492.5031.160.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118099492.5031.160.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00126.txt.bz2

On Mon, Jun 06, 2005 at 04:11:32PM -0700, Max Kaehn wrote:
>On Mon, 2005-06-06 at 16:07, Igor Pechtchanski wrote:
>> I take it you meant
>> 
>> -       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
>> +       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) &&\
>
>Oh, right, this is the world of shell scripts, not C.  Thanks for
>catching that.

Actually neither is right.  The tests are supposed to run to
completion, not stop on a failure.

cgf
