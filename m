Return-Path: <cygwin-patches-return-4549-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26931 invoked by alias); 2 Feb 2004 09:45:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26904 invoked from network); 2 Feb 2004 09:45:11 -0000
Date: Mon, 02 Feb 2004 09:45:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: ciresrv.parent
Message-ID: <20040202094509.GA16291@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net> <3.0.5.32.20040131141848.008138b0@incoming.verizon.net> <3.0.5.32.20040201165730.007f5b30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040201165730.007f5b30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00039.txt.bz2

On Feb  1 16:57, Pierre A. Humblet wrote:
> At 01:39 PM 2/1/2004 -0500, Christopher Faylor wrote:
> >On Sat, Jan 31, 2004 at 02:18:48PM -0500, Pierre A. Humblet wrote:
> >>Fortunately it is never used in the case of spawn: all handles are
> >>inherited, or the parent does the work (sockets). 
> >
> >The one placed the handle is actually used is in
> >fhandler_socket::fixup_after_exec.  I'd like Corinna's confirmation
> >before this patch is checked in.
> 
> Good idea. FWIW, I checked that one carefully. That's why I found
> the secret_event bug a while back. I also tested on Win95 with an
> old winsock. 
> It looks like the handle might be used, but the tests for close
> on exec always block the paths where it is actually used. 

AFAICS, you're right.  fhandler_socket::fixup_after_exec calls
fhandler_socket::fixup_after_fork only if !close_on_exec.
fhandler_socket::fixup_after_fork in turn calls fork_fixup which only
uses the parent handle if close_on_exec.  So the parent handle is never
used in this scenario.  So I think it's ok to drop the parent handle.

As a side note, it took me a while to understand that it's the same
situation for the secret_event handle.  The problem is the name of the
function set_inheritance().  The second parameter is the *negation*
of the inheritance.  IMHO this is rather confusing.  Either we should
rename the function to set_no_inheritance or we should revert the
meaning of the second parameter.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
