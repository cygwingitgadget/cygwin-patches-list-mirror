Return-Path: <cygwin-patches-return-4101-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21878 invoked by alias); 17 Aug 2003 17:18:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21869 invoked from network); 17 Aug 2003 17:18:37 -0000
Date: Sun, 17 Aug 2003 17:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Questions and a RFC [was Re: Assignment from Nicholas Wourms arrived]
Message-ID: <20030817171835.GK3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030812191411.GH17051@cygbert.vinschen.de> <3F39704F.6030001@netscape.net> <20030813113509.GA24855@cygbert.vinschen.de> <3F3A5CE4.10004@netscape.net> <20030813170416.GG3101@cygbert.vinschen.de> <20030817164304.GB9059@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817164304.GB9059@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00117.txt.bz2

On Sun, Aug 17, 2003 at 12:43:04PM -0400, Christopher Faylor wrote:
> On Wed, Aug 13, 2003 at 07:04:16PM +0200, Corinna Vinschen wrote:
> >>For future contributions, what is the official policy on doing it now?
> >
> >Basically don't add an underscore alias.  Create an underscore alias if
> >the function is used by newlib.  Or, create an underscore alias if it's
> >e.g.  available in Linux or BSD, which might happen (mempcpy comes to
> >mind).
> 
> I don't think this is right.  The underscore aliases were put there,
> IIRC, in a misplaced desire to emulate MSFT's version of such things as
> _open, _close, etc.  There is no reason to add underscores to any new
> functions.  The use of functions with leading underscores should be
> considred deprecated.

That's what I was trying to explain.  It's just that sometimes there are
functions additionally defined with leading underscores even under Linux,
see mempcpy() and __mempcpy() and that's the only situation, IMHO, in
which both would be ok for Cygwin as well.  It was a bumpy example,
probably.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
