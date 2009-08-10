Return-Path: <cygwin-patches-return-6594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27464 invoked by alias); 10 Aug 2009 16:38:09 -0000
Received: (qmail 27356 invoked by uid 22791); 10 Aug 2009 16:38:08 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-170.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.170)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 16:37:58 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 464E713C0C5 	for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2009 12:37:48 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 404DF2B352; Mon, 10 Aug 2009 12:37:48 -0400 (EDT)
Date: Mon, 10 Aug 2009 16:38:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
Message-ID: <20090810163748.GA7571@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A7F8FF5.5060701@gmail.com>  <20090810040452.GB610@ednor.casa.cgf.cx>  <4A7FA1E0.7070209@gmail.com>  <20090810152209.GB2564@ednor.casa.cgf.cx>  <4A804CA6.902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A804CA6.902@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00048.txt.bz2

On Mon, Aug 10, 2009 at 05:36:54PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>>On Mon, Aug 10, 2009 at 05:28:16AM +0100, Dave Korn wrote:
>>>My turn to say "ugh"! The wrapper function would translate down to a
>>>single 'jmp' if -fno-omit-frame-pointer was in effect, but as things
>>>stand it's a bit ugly.  So maybe we should let both of these rest for a
>>>while and see how things pan out upstream.
>>
>>Yes, sometimes we do ugly things in Cygwin to avoid slowdowns, even if
>>it is to avoid a simple "jmp".
>
>Sure.  So, let's leave this one out and wait for the bug to get fixed
>in GCC.

Sounds good.  Thanks, as always, for spending so much time dealing with
this stuff.

cgf
