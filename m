Return-Path: <cygwin-patches-return-5529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2174 invoked by alias); 6 Jun 2005 23:11:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2163 invoked by uid 22791); 6 Jun 2005 23:11:34 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 23:11:34 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j56NBWM2025305
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 16:11:32 -0700
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
	3
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu>
References: <1118084587.5031.128.camel@fulgurite>
	 <20050606200639.GC13442@trixie.casa.cgf.cx>
	 <1118091704.5031.144.camel@fulgurite>
	 <20050606213339.GC16960@trixie.casa.cgf.cx>
	 <1118098448.5031.157.camel@fulgurite>
	 <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu>
Content-Type: text/plain
Message-Id: <1118099492.5031.160.camel@fulgurite>
Mime-Version: 1.0
Date: Mon, 06 Jun 2005 23:11:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00125.txt.bz2

On Mon, 2005-06-06 at 16:07, Igor Pechtchanski wrote:
> I take it you meant
> 
> -       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
> +       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) &&\

Oh, right, this is the world of shell scripts, not C.  Thanks for
catching that.

