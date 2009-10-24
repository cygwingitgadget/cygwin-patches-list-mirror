Return-Path: <cygwin-patches-return-6795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22070 invoked by alias); 24 Oct 2009 15:31:53 -0000
Received: (qmail 22054 invoked by uid 22791); 24 Oct 2009 15:31:50 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 24 Oct 2009 15:31:46 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 8978E3B0002 	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2009 11:31:36 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 453742B352; Sat, 24 Oct 2009 11:31:36 -0400 (EDT)
Date: Sat, 24 Oct 2009 15:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
Message-ID: <20091024153135.GA18003@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AD78C5B.2080107@cwilson.fastmail.fm>  <4AE0DE77.3090300@cwilson.fastmail.fm>  <4AE0E614.4030305@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AE0E614.4030305@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00126.txt.bz2

On Thu, Oct 22, 2009 at 07:09:08PM -0400, Charles Wilson wrote:
>Charles Wilson wrote:
>> Latest rev, based on feedback @ mingw-dvlpr.  Avoid gmake conditionals
>> and use explicit rules, instead. Detect problems in all applicable
>> installation paths, not just $(prefix).
>> 
>> 2009-10-22  Charles Wilson  <...>
>
>Attached in .gz form, so that the web archive doesn't inline it.

I just waded through this thread and I'm confused about why it is being
actively discussed here since it's obviously a purely mingw issue.

Anyway, the mingw developers have indicated that they would be ok with
moving mingw and w32api out of the winsup directory at some point.  I
think that's the ultimate solution.  This was something that I was going
to pursue after 1.7 is finally released.

cgf
