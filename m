Return-Path: <cygwin-patches-return-4914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5032 invoked by alias); 23 Aug 2004 11:00:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5022 invoked from network); 23 Aug 2004 11:00:15 -0000
Date: Mon, 23 Aug 2004 11:00:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Truncate
Message-ID: <20040823110043.GW27978@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00066.txt.bz2

On Aug 22 17:09, Pierre A. Humblet wrote:
> In that case we can't reuse the code already present in ::write
> because when ::write calls GetFileSize it will get the length
> already updated by SetEndOfFile.

That's true.

> The way ::write is written, it will restore the FilePointer at
> the beginning of the 0 filled region if the disk gets full. But

Erm... it restores to current_position, which is the position of the
last lseek.  That's the same position which ftruncate64 would set the
EOF to.

> 2004-08-23  Pierre Humblet <pierre.humblet@ieee.org>
>  
>  	* syscalls.cc (ftruncate64): On 9x, call write with a zero length
>  	to zero fill when the file is extended.
> 
> Index: syscalls.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
> retrieving revision 1.342
> diff -u -p -r1.342 syscalls.cc
> --- syscalls.cc 3 Aug 2004 14:37:26 -0000       1.342
> +++ syscalls.cc 22 Aug 2004 21:00:49 -0000
> @@ -1675,7 +1675,7 @@ setmode (int fd, int mode)
> [...]
> +             /* In the lseek_bug case, this may restore the file to
> +                its initial length */

Except for this comment, which isn't valid (see above), please check it in.

>               if (!SetEndOfFile (h))
>                 __seterrno ();
>               else
> -               res = 0;
> +               res = res_bug;
>  
>               /* restore original file pointer location */
>               cfd->lseek (prev_loc, SEEK_SET);

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
