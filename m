Return-Path: <cygwin-patches-return-3210-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8742 invoked by alias); 20 Nov 2002 15:37:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8377 invoked from network); 20 Nov 2002 15:35:49 -0000
Date: Wed, 20 Nov 2002 07:37:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch #4: passwd and group
Message-ID: <20021120163542.L24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021111174720.X10395@cygbert.vinschen.de> <3DCFE314.3B5B45AB@ieee.org> <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de> <3.0.5.32.20021117224418.0083ac70@mail.attbi.com> <20021120114009.E24928@cygbert.vinschen.de> <3DDBA495.C5A801A2@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDBA495.C5A801A2@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00161.txt.bz2

On Wed, Nov 20, 2002 at 10:04:53AM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > Ahem, I thought we agreed that we don't call external functions from
> > inside Cygwin?  Never mind, there are still some of them which we have
> > to eliminate, anyway.
> 
> I didn't know about that policy but it suits me fine. As we discussed,
> internal calls to passwd/group functions should never reread the files,
> so new entry points are called for. I was going to do that in a second
> step, it wasn't a goal when I started.

The problem I'm talking about is beyond this patch.  Just reiterating
(so we know that we're talking about the same):

We talked about the need to use a static buffer in the external
getpwXXX and getgrXXX functions to allow apps to use the last return
value (a pointer) even though the file is going to be reread which
destroys all buffer space.  If Cygwin calls these functions internally,
the static buffers would be overwritten and the application itself
gets false data.

As you say, we need to substitute all internal calls to getpwXXX and
getgrXXX funcs (except getXXsid, of course) by calling appropriate
internal functions as internal_getpwuid().  Then we should be safe again.

Probably it would make sense to rename getXXsid() funcs to 
internal_getXXsid now to have a consistent naming scheme?

> How do you want to proceed? Apply this patch and undeclare internal_getpwent,
> remove LookupAccountSidA(), apply your "I'd better like" and introduce
> internal lookup functions in a few days, or prepare a single all-encompassing
> patch in a few days?

I patched your patch already slightly:

- Undeclare internal_getpwent
- "I'd better like"
- Avoid a compiler warning by using %lu instead of %u in sprintf'ing
  uids and gids.
- A few minor formatting issues.

How would you like to remove LookupAccountSidA?  Just remove it and
debug_printf ("Failed to get primary group name.") ?

Rewriting the external funcs and creating and using the internal funcs
is ok for another patch.

Corinna
