Return-Path: <cygwin-patches-return-2379-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2401 invoked by alias); 10 Jun 2002 09:14:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2367 invoked from network); 10 Jun 2002 09:14:00 -0000
Date: Mon, 10 Jun 2002 02:14:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020610111359.R30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020610035228.GC6201@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00362.txt.bz2

On Sun, Jun 09, 2002 at 11:52:28PM -0400, Chris Faylor wrote:
> On Sun, Jun 09, 2002 at 11:12:53PM -0400, Pierre A. Humblet wrote:
> >2002-06-09  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >	* environ.cc (addWinDefEnv): New.
> >	(inWinDefEnv): New.
> >	(writeWinDefEnv): New.
> >	* spawn.cc (spawn_guts): Call functions above to set
> >	traditional Windows environment variables when copying the
> >	environment to the cygheap, before CreateProcessAsUser().
> >	Define sec_attribs and call sec_user_nih() only once.
> >	* environ.h: Declare inWinDefEnv() and addWinDefEnv(), and 
> >	define WINDEFENVC.
> 
> I don't know about the sexec question.  Anyone know if there are (or
> were) any actual applications out there which use sexecve?  Isn't this
> just a cygwin invention?  I wonder if we should just nuke it from cygwin
> and see if anyone complains.  It would certainly simplify spawn.cc.

AFAICS, there should only be old applications left using sexec,
perhaps the original SSH.com port from Sergey, years ago.  I'm
even not sure if it still works with current Cygwin.  login(1)
was originally ported by using sexec but neither login(1) nor
any other application in the distro are using any sexecXX call.
I'd guess it's existance is in limbo.  We *would* obviously 
break backward compatibility by removing that functionality
but it's a backward compatibility to applications build at least
two years ago.

> Other minor nits: You made at least one gratuitous formatting change
> (moving a '&&' to a previous line) and your choice of function names is
> not really in tune with most of the other cygwin function names.  The
> function names should at least be consistent with the other function
> names in the file.  These are both extremely minor issues, of course.

However, they are valid.  What also concernes me is the
implementation of inWinDefEnv.  It checks the 5th character
in the input string w/o knowing the string length.  This
could result in access violation (what happens if a string
in the environment is e.g. "A="?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
