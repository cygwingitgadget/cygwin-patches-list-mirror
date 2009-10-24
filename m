Return-Path: <cygwin-patches-return-6796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27203 invoked by alias); 24 Oct 2009 15:41:04 -0000
Received: (qmail 27190 invoked by uid 22791); 24 Oct 2009 15:41:03 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 24 Oct 2009 15:41:00 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id AFC0FB46DB 	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2009 11:40:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Sat, 24 Oct 2009 11:40:59 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 39C1159530; 	Sat, 24 Oct 2009 11:40:58 -0400 (EDT)
Message-ID: <4AE31FD6.5070705@cwilson.fastmail.fm>
Date: Sat, 24 Oct 2009 15:41:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm>  <4AE0DE77.3090300@cwilson.fastmail.fm>  <4AE0E614.4030305@cwilson.fastmail.fm> <20091024153135.GA18003@ednor.casa.cgf.cx>
In-Reply-To: <20091024153135.GA18003@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00127.txt.bz2

Christopher Faylor wrote:
> I just waded through this thread and I'm confused about why it is being
> actively discussed here since it's obviously a purely mingw issue.

Because it affects the cygwin build process, and my motivation was to
support DESTDIR which really only helps *cygwin*.  I'm basically asking
the mingw guys for a favor -- but wanted to keep the cygwin community in
the loop, since it's a favor for *us*.

Besides, we discussed Corinna's cross-compile improvements, which also
were specific to winsup/mingw/, here...

> Anyway, the mingw developers have indicated that they would be ok with
> moving mingw and w32api out of the winsup directory at some point.  I
> think that's the ultimate solution.  This was something that I was going
> to pursue after 1.7 is finally released.

I knew the point had been raised, but in my brief searches I couldn't
find any indication that they were ok with that -- or that we (e.g.
really, that you, Corinna -- and Chris Sutcliff) were. Good to know, and
I agree...eventually <g>.

BTW, welcome back.

--
Chuck
