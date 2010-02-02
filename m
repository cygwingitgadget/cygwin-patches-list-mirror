Return-Path: <cygwin-patches-return-6944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25629 invoked by alias); 2 Feb 2010 02:05:03 -0000
Received: (qmail 25617 invoked by uid 22791); 2 Feb 2010 02:05:02 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Feb 2010 02:04:59 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 4394213C0C8 	for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2010 21:04:49 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 401A52B35A; Mon,  1 Feb 2010 21:04:49 -0500 (EST)
Date: Tue, 02 Feb 2010 02:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add some notes about process startup/shutdown.
Message-ID: <20100202020449.GD31126@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B677EAA.9050304@gmail.com>  <20100202013901.GB31126@ednor.casa.cgf.cx>  <4B678911.7050300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B678911.7050300@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00060.txt.bz2

On Tue, Feb 02, 2010 at 02:08:17AM +0000, Dave Korn wrote:
>On 02/02/2010 01:39, Christopher Faylor wrote:
>
>>> winsup/cygwin/ChangeLog:
>>>
>>> 	* how-crt-and-initfini.txt: Add new document.
>>>
>>>  OK?
>> 
>> Yes, very nice except I don't think the name is descriptive enough and
>> in keeping with the other stuff in the series.
>> 
>> Maybe how-startup-shutdown-work.txt ?
>
>  Okeydokey, will check it in with that name (well, modulo "-works").

That wasn't a typo.  I actually chose "work" specifically because I was
thinking it was "how startup and shutdown work".

But nevermind.

cgf
