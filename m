Return-Path: <cygwin-patches-return-3211-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3547 invoked by alias); 20 Nov 2002 16:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3489 invoked from network); 20 Nov 2002 16:28:46 -0000
Message-ID: <3DDBB854.3A5841EB@ieee.org>
Date: Wed, 20 Nov 2002 08:28:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch #4: passwd and group
References: <20021111174720.X10395@cygbert.vinschen.de> <3DCFE314.3B5B45AB@ieee.org> <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de> <3.0.5.32.20021117224418.0083ac70@mail.attbi.com> <20021120114009.E24928@cygbert.vinschen.de> <3DDBA495.C5A801A2@ieee.org> <20021120163542.L24928@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00162.txt.bz2

Corinna Vinschen wrote:

> The problem I'm talking about is beyond this patch.  Just reiterating
> (so we know that we're talking about the same):
> 
> We talked about the need to use a static buffer in the external
> getpwXXX and getgrXXX functions to allow apps to use the last return
> value (a pointer) even though the file is going to be reread which
> destroys all buffer space.  If Cygwin calls these functions internally,
> the static buffers would be overwritten and the application itself
> gets false data.
> 
> As you say, we need to substitute all internal calls to getpwXXX and
> getgrXXX funcs (except getXXsid, of course) by calling appropriate
> internal functions as internal_getpwuid().  Then we should be safe again.

...and we don't need to change anything to the external functions 
   (so we know that we're talking about the same).
  See below.

> Probably it would make sense to rename getXXsid() funcs to
> internal_getXXsid now to have a consistent naming scheme?

Yes.
 
> I patched your patch already slightly:

Thanks.
 
> How would you like to remove LookupAccountSidA?  Just remove it and
> debug_printf ("Failed to get primary group name.") ?

OK, the debug printf can be removed too, the result will be visible in the
other debug_printf below.
A more ambitious way is to see if the sid is local or not. If it is local we
can safely call LookupAccountSidA.
 
> Rewriting the external funcs and creating and using the internal funcs
> is ok for another patch.

Glad we talk! The external non multithread functions are already OK (i.e. POSIX), 
as long as we have the new internal functions.
In other words, if the internal functions don't reread the files, then there
is no need for new static buffers. The existing buffers can only be wiped out
on the next external call, which is OK.

The multithread issues are still outside the next patch.

Pierre
