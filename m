Return-Path: <cygwin-patches-return-3868-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26567 invoked by alias); 21 May 2003 16:22:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26520 invoked from network); 21 May 2003 16:22:45 -0000
Date: Wed, 21 May 2003 16:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
Message-ID: <20030521162232.GC3096@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00095.txt.bz2

On Wed, May 21, 2003 at 05:32:33PM +0200, Micha Nelissen wrote:
>Hi,
>
>Several problems encountered and tried to fix:
>
>1) line draw characters not showing up in combination Command Prompt with
>bash.
>2) screen scrolling fixed for termcap entry 'cs' -> screen split is very
>fast and cool.
>3) end-of-buffer cursor out of range; see changelog for more details.
>
>This is my first patch, so please don't flame ;). I am open to suggestions.
>
>Regards,

>2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>
>
>* fhandler.h (dev_console): add title state variables.
>* fhandler_console.cc (get_tty_stuff): save old console title.

Why?  This wasn't mentioned in your description of the patch.

>* fhandler_console.cc (macro: srTop, srBottom; char_command): scroll_region is
>not relative to window top.

I'm not 100% sure what you're saying here, but if you set a scroll
region and then send a "goto line 1" escape sequence, I believe that, by
default, you go to actual line one on the screen, not the first line of
the scroll region.  This behavior is controlled by some escape sequence.
rustle, rustle.  <ESC>[?6h and <ESC>[?6l

>* fhandler_console.cc (scroll_screen): renamed variables sr1, sr2 to srScroll,
>srClip respectively which is clearer.

That's a gratuitous change, the bane of patch receivers everywhere.

>* fhandler_console.cc (scroll_screen, char_command, write_normal): more debug
>info.

Your debug output is in a different format than the rest of the debug
output in that file.  Granted, this is flexible, but your patch seems to
be extremely wordy.

>* fhandler_console.cc (write_normal): end of buffer check enables cursor to be
>out of range; it better emulates *nix terminal behaviour; ie. it is now
>possible to write a single character at right bottom of console buffer without
>the console scrolling the buffer.

How is this similar to UNIX?  If I do a:

sleep 5; echo hello

and then scroll my xterm up, xterm scrolls down when hello is printed.  It
sounds like your patch would not cause this to happen.

>* fhandler_console.cc (write_normal): cancelled premature optimization, do
>always use scroll_screen instead of '\n' sometimes

No.  This section of code has been hacked back and forth for years.  This
one is not going to happen.

>* fhandler_write.cc (write): if `user' clears title, then don't add `|'

I must be missing something.  Why is "|" being added to the title at all?

General comments about the rest of the patch:

1) Please break it up into smaller sets for approval.  Large patches like
this which attempt multiple things are difficult to review.

2) There is occasional deviation from GNU coding standards in your patch.
Specifically, there are missing spaces after commas and coercions.

3) You comment out some code rather than deleting it outright.  There's
no reason to leave old code around.

4) As Corinna mentioned, you need to send in an assignment.  The contributing
page has details.

Thanks for all of your hard work on this patch.

cgf
