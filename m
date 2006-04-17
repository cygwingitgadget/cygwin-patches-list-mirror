Return-Path: <cygwin-patches-return-5826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30130 invoked by alias); 17 Apr 2006 15:10:25 -0000
Received: (qmail 30118 invoked by uid 22791); 17 Apr 2006 15:10:24 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 17 Apr 2006 15:10:20 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id F02FA13C01E; Mon, 17 Apr 2006 11:10:18 -0400 (EDT)
Date: Mon, 17 Apr 2006 15:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkstemp vs. text mode
Message-ID: <20060417151018.GB28972@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4443879E.1000406@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4443879E.1000406@byu.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00014.txt.bz2

On Mon, Apr 17, 2006 at 06:18:38AM -0600, Eric Blake wrote:
>Should we change mkstemp to always open in binary mode, regardless of
>the mount mode of the directory of the template name?  Arguments for
>this is that mkstemp is often used by programs for binary data, where a
>text-mode /tmp mount point would corrupt that data if we defer to the
>mount point.  Also, a temp file is an intermediate data storage
>location, similar to pipes, and we currently treat pipes as binary by
>default; a program copying data to a temp file, then from there to a
>final destination, only needs text mode on the final destination.
>Programs that really want a text-mode temp file can do setmode after
>the fact, but this is probably less common.
>
>This should still be a trivial patch.  Meanwhile, I will start the
>process of getting an employee disclaimer for Red Hat (it took me
>almost a year to get one signed for FSF).
>
>2006-04-17 Eric Blake <ebb9@byu.net>
>
>	* mktemp.cc (_gettemp): Open temp files in binary mode.

Yes, I think it makes sense to open temp files in binary but I'll bet
that someone is relying on textmode behavior.  Nevertheless, I've
applied the patch.

Let the cygwin ML whines begin...

cgf
