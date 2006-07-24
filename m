Return-Path: <cygwin-patches-return-5939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25236 invoked by alias); 24 Jul 2006 11:14:09 -0000
Received: (qmail 25225 invoked by uid 22791); 24 Jul 2006 11:14:08 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 24 Jul 2006 11:14:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 42BD86D42F4; Mon, 24 Jul 2006 13:14:02 +0200 (CEST)
Date: Mon, 24 Jul 2006 11:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
Message-ID: <20060724111402.GG11991@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu> <20060216160637.GQ26541@calimero.vinschen.de> <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu> <20060217113100.GT26541@calimero.vinschen.de> <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu> <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu> <20060223112956.GF4294@calimero.vinschen.de> <Pine.GSO.4.63.0602230913440.13565@access1.cims.nyu.edu> <Pine.GSO.4.63.0607191036580.13093@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0607191036580.13093@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00034.txt.bz2

On Jul 21 20:52, Igor Peshansky wrote:
> In any case, here's the latest incarnation, with get_word and get_dword
> folded into path.cc, and display_error returned to cygcheck.cc, where it
> belongs.  Tested reasonably well (with symlinks pointing to symlinks,
> etc).  I'll let you judge the neatness of the ChangeLog entry.  If I'm
> lucky, this might just get into 1.5.21[*].
> 	Igor
> [*] Corinna, I'm guessing this is sufficiently different that you can't
> accept it without "the fax" -- I'll keep pinging the guy who's holding
> this up, but this message is also supposed to confirm that there is a
> working patch, and the delay is simply bureaucratic.  Oh, the
> frustration...  If you judge the changes from the previous incarnation
> to not be significant, just go ahead and apply this, given the previous
> approval.

The latest fax was about this change, so I think this should still be
covered, shouldn't it?  Ping the guy nevertheless.  We should stay on
the safe side in legal questions.

I'd be happy to apply the patch, but it would be nice if you could tweak
the formatting somewhat:

> +  if (GetLastError () != NO_ERROR) display_error ("get_dword");

The display_error call should be on its own line, as usual.  This
happens multiple times in your patch.

> +  if (is_exe (fh))
> +    dll_info (path, fh, lvl, 1);
> +  else if (is_symlink (fh))
> +    display_error ("track_down: Huh?  Got a symlink!");

Is that really the supposed message here?

> +      printf (" - Not a DLL: magic number %x (%d) '%s'\n", magic, magic, (char *)&magic);

Please split the printf so that it's not longer than 80 chars.

> +      /* TODO: check for invalid path contents (see ../cygwin/path.cc:3313 */

Since source code lines are most volatile, I'd not refer to a line number
in another source code.  Just mention the function name. */

> +      if (got != sizeof (buf) || memcmp (buf, SYMLINK_COOKIE, sizeof (buf)) != 0)

Split the line, please.

> +      if (SetFilePointer (fh, 0x4c + offset + 4, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER

Same here.

> +	{
> +	  return false;
> +	}

I'd rather not have these one liners in curly brackets.  It's a bit
irritating since sometimes you put them in curly brackets, sometimes you
don't.


The code looks ok, otherwise.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
