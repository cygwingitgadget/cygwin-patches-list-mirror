Return-Path: <cygwin-patches-return-5867-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18881 invoked by alias); 24 May 2006 00:55:43 -0000
Received: (qmail 18868 invoked by uid 22791); 24 May 2006 00:55:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 00:55:41 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 5CFF913C01F; Tue, 23 May 2006 20:55:39 -0400 (EDT)
Date: Wed, 24 May 2006 00:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: select.cc exitsock error cleanup
Message-ID: <20060524005539.GA14893@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605231704u29b8860ayd6d30fab02602c70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605231704u29b8860ayd6d30fab02602c70@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00055.txt.bz2

On Tue, May 23, 2006 at 08:04:31PM -0400, Lev Bishop wrote:
>2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>
>
>	* select.cc (start_thread_socket): Clean up exitsock in case of 
>	error.

>Index: select.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
>retrieving revision 1.124
>diff -u -p -r1.124 select.cc
>--- select.cc	21 May 2006 17:27:14 -0000	1.124
>+++ select.cc	23 May 2006 23:32:47 -0000
>@@ -1446,6 +1446,7 @@ start_thread_socket (select_record *me, 
> err:
>   set_winsock_errno ();
>   closesocket (si->exitsock);
>+  _my_tls.locals.exitsock = INVALID_SOCKET;
>   return -1;
> }

I've checked in a variation of this patch but I've used si->exitsock
for consistency.

Thanks.

cgf
