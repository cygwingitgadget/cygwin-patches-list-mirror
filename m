Return-Path: <cygwin-patches-return-2393-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8622 invoked by alias); 12 Jun 2002 05:32:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8574 invoked from network); 12 Jun 2002 05:32:14 -0000
Date: Tue, 11 Jun 2002 22:32:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020612053233.GA21398@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com> <3D04C62B.E7804DC0@ieee.org> <20020611022812.GA30113@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020611022812.GA30113@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00376.txt.bz2

On Mon, Jun 10, 2002 at 10:28:12PM -0400, Christopher Faylor wrote:
>On Mon, Jun 10, 2002 at 11:30:51AM -0400, Pierre A. Humblet wrote:
>>Christopher Faylor wrote:
>>> 
>>> 
>>> Ok.  I'm in favor of getting rid of sexec in 1.3.11, then.
>>> 
>>> I'll do that sometime today.
>>> 
>>Then you can also junk the first argument (token) in _spawnve()
>>and spawn_guts() (FYI).
>
>Yes, this was one of the things that I've wanted to do for a while.

After a chat with Corinna, I have taken a stab at cleaning up some
of the environment manipulation in internal_getlogin.  I've done this
without bothering spawn_guts too much.

I tried to keep most of the logic the same but a couple of things
bothered me in internal_getlogin.  They were probably there for a
good reason, but I changed them anyway.

One thing that I changed was to not query for a user name if you've
already gotten the user name from GetUserName.  I also changed the HOME
and HOMEPATH manipulation slightly.  If there were reasons for the way
things were, then please revert my changes and check in a comment
explaining why you have to call GetUserName and then overwrite what it
has discovered a few lines later.

I probably introduced other gratuitous formatting changes as I careened
around uinfo.cc, too.  Hopefully Corinna will tell me if I did anything
wrong.

The bottom line is that all (most?) user-related environment variables
are only set when they need to be set and are not calculated or set at
all when a known cygwin process is about to be run.  UNIX doesn't know
about HOMEPATH or HOMEDRIVE so there is no reason to assume that a
"native" cygwin process needs this updated info, either.

There's probably more cleanup that can be done.  If so, let's discuss
them.

<time passes>

Oops!  I just realized that I screwed up posix conversion in the new
code.  Oh well.  That something to fix tomorrow.  Until then CVS is
officially broken.

cgf
