Return-Path: <cygwin-patches-return-6967-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31156 invoked by alias); 14 Feb 2010 19:12:39 -0000
Received: (qmail 31146 invoked by uid 22791); 14 Feb 2010 19:12:39 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 19:12:35 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 2593C3B0002 	for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 14:12:26 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 19FAD2B35A; Sun, 14 Feb 2010 14:12:26 -0500 (EST)
Date: Sun, 14 Feb 2010 19:12:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100214191225.GC19242@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <20100214101834.GO5683@calimero.vinschen.de>  <4B7833D4.5090301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B7833D4.5090301@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00083.txt.bz2

On Sun, Feb 14, 2010 at 05:33:08PM +0000, Dave Korn wrote:
>On 14/02/2010 10:18, Corinna Vinschen wrote:
>>I don't know if that works, but it would be really cool if a single DLL
>>import lib like libcygwin.a could export symbols from different DLLs.
>>That way we could create a cygxdr1.dll which contains the XDR
>>functions, but which could be linked against by just the default
>>linking against libcygwin.a.
>
>Why would we do that?

Yeah, ditto.  It's an interesting idea but I was more thinking that this
would be something that was added to the command-line specifically, like,
e.g., a -lxdr .

However, on doing more research, I see that these functions are part of
the standard linux libc.so so, for my suggestion, it wouldn't make sense
to make it a separate library.

It would be kind of cool if we could keep, say, the pthread library in
a separate dll but, unfortunately, that boat has already sailed.

cgf
