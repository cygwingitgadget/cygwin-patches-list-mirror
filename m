Return-Path: <cygwin-patches-return-3083-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8046 invoked by alias); 23 Oct 2002 13:52:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8033 invoked from network); 23 Oct 2002 13:52:49 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 23 Oct 2002 06:52:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Steve O <bub@io.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty deadlock patch + console + eof
In-Reply-To: <20021023002947.A537@hagbard.io.com>
Message-ID: <Pine.GSO.4.44.0210230902150.8025-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0210230902152.8025@slinky.cs.nyu.edu>
Content-Disposition: INLINE
X-SW-Source: 2002-q4/txt/msg00034.txt.bz2

Steve,

On Wed, 23 Oct 2002, Steve O wrote:

> On Tue, Oct 22, 2002 at 02:06:17PM -0400, Igor Pechtchanski wrote:
> > One more thing I noticed when using this patch is that pasting now seems
> > really slow, as if it's sending one character at a time...  Did you turn
> > off the buffering somewhere by any chance?
>
> Not that I know of.  In large pastes, say larger than 2k, the buffers
> fill up and the app stops being able to write the paste buffer in large
> chunks.  This could contribute to a character-at-a-time feel.

Yeah, that is probably it.  The pastes that exhibit this behavior are the
ones that used to freeze xterms, so the size is quite large.  I just
verified that small pastes are fine.

> While trying to reproduce this I noticed that pasting a selection with
> tab characters into bash causes delays due to bash trying to do command
> completion.  Also note that bash bypasses termios processing and so
> a paste into bash will result in a series of 1 character writes to the
> pipe.  The pipe seems to have a 4k buffer, but depending on the timing
> bash may get to read each character out individually.

Nah, not in my case - I'm pasting into vi...  But good to know about
bash, thanks.

> Though, I could of broke something.  If you want to persue this, you're
> welcome to send me a test case off-list, and I'll see if anything unusual
> is happening.

I think the above quite adequately explained this.  If you think it's
potentially fixable, let me know if you still want a test case.  And
thanks again for the patch.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Water molecules expand as they grow warmer" (C) Popular Science, Oct'02, p.51
