Return-Path: <cygwin-patches-return-6516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7165 invoked by alias); 18 Apr 2009 17:31:54 -0000
Received: (qmail 7148 invoked by uid 22791); 18 Apr 2009 17:31:53 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 18 Apr 2009 17:31:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 2009313C023 	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2009 13:31:38 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 124472B4A2; Sat, 18 Apr 2009 13:31:37 -0400 (EDT)
Date: Sat, 18 Apr 2009 17:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: The Return of Revenge of Son of the Speclib Strikes Back :)
Message-ID: <20090418173137.GA23840@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49E9DB61.2040506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E9DB61.2040506@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00058.txt.bz2

On Sat, Apr 18, 2009 at 02:53:37PM +0100, Dave Korn wrote:
>[ Let's try again in the right place, shall we? ]

Now more tempest with even less teapot!

>The new speclibs libraries work great, but there's one piece of
>unanticipated fallout: the libtool func_win32_libid() tests can no
>longer identify them as import libraries.  Which is fair enough, since
>they aren't, they are now indirect references to import libraries; but
>we want it to treat them the same anyway.

I can guess why that is, but it would be nice if you didn't jump right
to a solution and provided more details.

>As usual, I don't speak perl good,

So, please don't bother sending perl patches.  I can get enough out of
the description of what is wrong and what your possible solution might
be to figure out what needs to be done without seeing your
proof-of-concept.

I checked something in which adds a dummy object custom-tailored to the
each library.

Thanks for the report.

cgf
