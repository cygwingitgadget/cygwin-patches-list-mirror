Return-Path: <cygwin-patches-return-5520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4423 invoked by alias); 6 Jun 2005 20:42:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4359 invoked by uid 22791); 6 Jun 2005 20:42:31 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 20:42:31 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 894B213C28E; Mon,  6 Jun 2005 16:42:30 -0400 (EDT)
Date: Mon, 06 Jun 2005 20:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
Message-ID: <20050606204230.GA14555@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050606193232.GA12606@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061536381.15703@slinky.cs.nyu.edu> <20050606195234.GA13442@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061556260.15703@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0506061556260.15703@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00116.txt.bz2

On Mon, Jun 06, 2005 at 04:09:13PM -0400, Igor Pechtchanski wrote:
>I wonder if this could, perhaps, be made more transparent to the
>programmer, by introducing a static marker, for example.  Something like
>(again, modulo typos):
>
>  void
>  initialize_cygwin (int (*main) (int argc, char **argv), int argc, char **argv)
>  {
>    static int was_here = 0;
>    if (was_here) return;
>    was_here = 1;
>    struct _cygtls dummy_tls;
>    char *newargv = alloca (argc * sizeof (argv[0]));
>    for (char **av = newargv; *av; av++)
>      *av = *argv++;
>    *av = NULL;
>    initialize_main_tls (&dummy_tls);
>    cygwin_dll_init ();
>    exit (main (argc, newargv));
>  }
>
>Then main() could look like this:
>
>  int
>  main (int argc, char **argv)
>  {
>    initialize_cygwin (main, argc, argv);  /* could return */
>
>    /* do main stuff */
>    .
>    .
>    .
>    exit or return here
>  }
>
>Or is there a reason for main() to be thread-safe or for
>initialize_cygwin() to be called twice?

I guess you could do it that way.  It would look more transparent to the
end user if you did.  You'd still have to make it clear that this has to
happen first thing in the main() function or you could suffer problems
with automatic initialization or constructors.

cgf
