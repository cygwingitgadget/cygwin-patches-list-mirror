Return-Path: <cygwin-patches-return-5372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23845 invoked by alias); 7 Mar 2005 16:21:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23793 invoked from network); 7 Mar 2005 16:21:17 -0000
Received: from unknown (HELO vms046pub.verizon.net) (206.46.252.46)
  by sourceware.org with SMTP; 7 Mar 2005 16:21:17 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0ICZ001LLPEVBJ80@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Mon, 07 Mar 2005 10:21:12 -0600 (CST)
Date: Mon, 07 Mar 2005 16:21:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Timer functions
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <003401c52331$a412c3b0$ac05a8c0@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
 <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
 <3.0.5.32.20050306234015.00b5a598@incoming.verizon.net>
X-SW-Source: 2005-q1/txt/msg00075.txt.bz2


----- Original Message ----- 
From: "Pierre A. Humblet" 
Sent: Sunday, March 06, 2005 11:40 PM
Subject: Re: [Patch]: Timer functions


> At 11:00 PM 3/6/2005 -0500, Christopher Faylor wrote:
> >I am puzzled by a couple of things.
> >
> >Why did you decide to forego using th->detach in favor of (apparently)
> >a:
> >
> >      while (running)
> > low_priority_sleep (0);
> 
> These are not directly related. I got into this issue because of the bug
> where cygthreads were not reused. I replaced th->detach by self_release
> because that seemed to be the most natural and efficient way
> to fix the problem. 

Also that frees the cygthread when the timer expires, not when it's 
rearmed (if ever).

Pierre
