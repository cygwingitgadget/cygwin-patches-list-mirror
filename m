Return-Path: <cygwin-patches-return-5872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 635 invoked by alias); 24 May 2006 03:39:25 -0000
Received: (qmail 604 invoked by uid 22791); 24 May 2006 03:39:24 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 03:38:59 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 72F0A13C020; Tue, 23 May 2006 23:38:57 -0400 (EDT)
Date: Wed, 24 May 2006 03:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: select.cc exitsock error cleanup
Message-ID: <20060524033857.GB14207@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605231704u29b8860ayd6d30fab02602c70@mail.gmail.com> <20060524005539.GA14893@trixie.casa.cgf.cx> <ba40711f0605231928hb15b1b2s35a9dfde87092f2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605231928hb15b1b2s35a9dfde87092f2a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00060.txt.bz2

On Tue, May 23, 2006 at 10:28:51PM -0400, Lev Bishop wrote:
>On 5/23/06, Christopher Faylor wrote:
>>I've checked in a variation of this patch but I've used si->exitsock
>>for consistency.
>
>I'm sure that's wrong. With your version, the next time select() is
>called, the thread-local socket will still look like a valid socket,
>even though it has been closed and can't be used. Thus, no further
>select()ing may be done on sockets from that thread.
>
>Hmm. Also, the proper error return value appears to be 0, not -1.
>
>So try this version. (I kept si->exitsock in there for good measure --
>maybe it'll help someone stepping through with a debugger one day,
>etc).
>
>2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>
>
>	* select.cc (start_thread_socket): Really clean up exitsock in
>	case of error. Return correct error return value.

You're right.  Stupid mistake on my part.

I don't see any patch here but I will make the appropriate changes
to this function.

cgf
