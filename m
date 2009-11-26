Return-Path: <cygwin-patches-return-6858-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2366 invoked by alias); 26 Nov 2009 16:54:00 -0000
Received: (qmail 2349 invoked by uid 22791); 26 Nov 2009 16:53:58 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 16:53:54 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 376C23B0002 	for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2009 11:53:44 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 38B2C2B352; Thu, 26 Nov 2009 11:53:44 -0500 (EST)
Date: Thu, 26 Nov 2009 16:54:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
Message-ID: <20091126165344.GB18148@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net>  <4B0D2CE5.4000000@byu.net>  <20091126112121.GP29173@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091126112121.GP29173@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00189.txt.bz2

On Thu, Nov 26, 2009 at 12:21:21PM +0100, Corinna Vinschen wrote:
>On Nov 25 06:11, Eric Blake wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> According to Eric Blake on 11/20/2009 7:15 AM:
>> >>> 	* signal.cc (nanosleep): Support 'infinite' sleep times.
>> >>> 	(sleep): Avoid uninitialized memory.
>> >> Sorry but, while I agree with the basic idea, this seems like
>> >> unnecessary use of recursion.  It seems like you could accomplish the
>> >> same thing by just putting the cancelable_wait in a for loop.  I think
>> >> adding recursion here obfuscates the function unnecesarily.
>> > 
>> > How about the following, then?  Same changelog.
>> 
>> Ping.
>
>Do you think we need it in 1.7.1?

No, I don't think so.  I'll get to this after Thanksgiving.

cgf
