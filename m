Return-Path: <cygwin-patches-return-5514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23722 invoked by alias); 6 Jun 2005 19:38:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22677 invoked by uid 22791); 6 Jun 2005 19:38:35 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 19:38:35 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j56JcXM2011758
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 12:38:33 -0700
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050606193232.GA12606@trixie.casa.cgf.cx>
References: <20050606193232.GA12606@trixie.casa.cgf.cx>
Content-Type: text/plain
Message-Id: <1118086713.5031.139.camel@fulgurite>
Mime-Version: 1.0
Date: Mon, 06 Jun 2005 19:38:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00110.txt.bz2

Resending to the cygwin list this time...

On Fri, 2005-06-03 at 19:30, Christopher Faylor wrote:
> Wow! That's great! Thanks for doing this.  It is much appreciated.  This
> is something that I had been meaning to do and you did a better job than
> I would have.  This truly deserves a gold star.  I know that understanding
> the cygtls stuff could not have been easy.
> 
> Can I get a gold star over here for this truly heroic effort?

*blush*

> I have checked in everything but the test suite stuff.  I would like to
> see some changes there:
> 
> 1) Use '.cc' rather than '.cpp' for the extension to be consistent with
> the rest of winsup.

Oops.  All the other things I was trying to get right and that one
was staring me in the face. :-)

> 2) Use the same formatting that is used throughout cygwin for brace
> placement, etc.

Sure.  I tried looking for the appropriate emacs settings for
the canonical cygwin style, but I can't find out how to get my
password for access to the cygwin-developers archive to see if
anyone has already answered that one.  Another couple of good
things for the cygwin-developers FAQ or maybe a README.coding-style
in winsup could be:
        * How do I access the cygwin-developers archives through
             the Web interface?
        * What parameters should I set in my source code editor
          so it automatically does the proper indentation for the
          canonicaly cygwin style?

Meanwhile, cygload isn't that large, so I just set c-basic-offset
to 2 and hand-tweaked the braces.  I'll be submitting the revised
patch for cygload today.

> 3) Submit the new files as diffs against /dev/null so that I can apply
> like a normal patch.

Aha!  I'd been wondering how that would look in a patch.  That might
be a good one for the "contributing" page.

You may have noticed that I'm a compulsive documenter.  If you
want to leave the effort of turning a brief E-mail reply into a
FAQ entry or README to me, I'll be happy to submit the patch. :-)

> Did you consider other ways of dealing with the need for space at the
> bottom of the stack?

That's a tricky one.  The first thing I tried was to just declare
char padding[4096] as the first thing in main(), but that trashed
argv and argc and the context that mainCRTStartup() uses for
getting the return value from main().  Even the entry point hack I 
used doesn't take care of *everything*: turn on the -v option 
in cygload and you'll see that even the entry point comes in (IIRC) 
64 or 100 bytes up the stack, depending on whether you're in MinGW 
or MSVC.

If you just declare cygwin::padding as the first thing in
main function, it'll *work*, but you then you need to follow
it up with something like
        std::vector<const char *> args(argv, argv+argc);
so argv gets backed up on the heap and won't get trashed
when cygwin initializes.  (The actual strings of argv are
malloc'ed, at least in the MSVC crt0.c; I didn't check MinGW.)

> This has the downside of maybe causing more code disruption, though...

Yeah.  My goal with cygload was to provide an example that could
be added to an existing tool with minimal redesign.  If I were
doing something as thorough as "you have to redesign your main()
function", I'd also have it spawn a thread to run the main()
function, have the actual main thread just loop on nanosleep()
or one of the appropriate pthread functions so it can receive 
signals, and then have the thread running main() pass the return value
back for proper cleanup at the end.

It might be worth creating an alternate version of cygload as
an example of that technique.

