Return-Path: <cygwin-patches-return-4912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6408 invoked by alias); 22 Aug 2004 15:55:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6399 invoked from network); 22 Aug 2004 15:55:07 -0000
Date: Sun, 22 Aug 2004 15:55:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Truncate
Message-ID: <20040822155534.GA17449@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00064.txt.bz2

Hi Pierre,

Looks good to me.  But wouldn't it be better to fill in the zeros only
if SetEndOfFile succeeded?  That would avoid a lengthy write operation
if the application was, say, too optimistic about the space left on disk.


Corinna


On Aug 21 18:36, Pierre A. Humblet wrote:
> This fixes ftruncate64 on 9x.
> It now passes all truncate tests in the testsuite.
> 
> Pierre
> 
> 2004-08-22  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* syscalls.cc (ftruncate64): On 9x, call write with a zero length
> 	to zero fill when the file is extended.
> 
> Index: syscalls.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
> retrieving revision 1.342
> diff -u -p -r1.342 syscalls.cc
> --- syscalls.cc 3 Aug 2004 14:37:26 -0000       1.342
> +++ syscalls.cc 21 Aug 2004 22:28:28 -0000
> @@ -1692,6 +1692,9 @@ ftruncate64 (int fd, _off64_t length)
>               _off64_t prev_loc = cfd->lseek (0, SEEK_CUR);
>  
>               cfd->lseek (length, SEEK_SET);
> +             /* Fill the space with 0, if needed */
> +             if (wincap.has_lseek_bug ())
> +               cfd->write (&res, 0);
>               if (!SetEndOfFile (h))
>                 __seterrno ();
>               else

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
