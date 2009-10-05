Return-Path: <cygwin-patches-return-6693-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16269 invoked by alias); 5 Oct 2009 04:56:27 -0000
Received: (qmail 16257 invoked by uid 22791); 5 Oct 2009 04:56:26 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 04:56:22 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 37B1C13C002 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 00:56:11 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 2E6762B352; Mon,  5 Oct 2009 00:56:11 -0400 (EDT)
Date: Mon, 05 Oct 2009 04:56:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091005045611.GB10682@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com>  <20091002221933.GB12372@ednor.casa.cgf.cx>  <20091003120854.GA22019@calimero.vinschen.de>  <4AC74BB5.9060503@gmail.com>  <20091003130644.GJ7193@calimero.vinschen.de>  <4AC75235.1070403@gmail.com>  <4AC84E5A.7040203@gmail.com>  <20091004112648.GE4563@calimero.vinschen.de>  <4AC8AC37.4050306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC8AC37.4050306@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00024.txt.bz2

On Sun, Oct 04, 2009 at 03:07:51PM +0100, Dave Korn wrote:
>Corinna Vinschen wrote:
>>Since I have a running gcc-4.34 now, do you still want me to do that?
>>Please keep in mind that I'm a lazy cow...
>
>Efficient use of resources != laziness.  No, I wouldn't suggest doing
>that, what you ended up with by hacking the header files should (in
>theory, anyway) be the same as what you would get if the autoconf tests
>had done it for you.
>
>Now that all the related mysteries are solved, I'll go ahead and commit
>that patch to the build flags.  (I just thought it would be kind of
>wrong of me to leave HEAD in a state where the one and only actual
>RedHat staffer working on the project couldn't compile it!)

FWIW, I have a running cross-compiled version of 4.34 too.  And I also
updated my binutils while I was at it.

The latest snapshot has been built with that combination.

Thanks for all of your hard gcc work, Dave.

cgf
