Return-Path: <cygwin-patches-return-2848-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30661 invoked by alias); 21 Aug 2002 11:23:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30644 invoked from network); 21 Aug 2002 11:23:22 -0000
Message-ID: <004d01c24905$442b55b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Joshua Daniel Franklin" <joshuadfranklin@yahoo.com>
Cc: <cygwin-patches@cygwin.com>
References: <Pine.CYG.4.44.0208202020220.1628-200000@joshua.iocc.com>
Subject: Re: patch for cygserver
Date: Wed, 21 Aug 2002 04:23:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00296.txt.bz2

"Joshua Daniel Franklin" <joshua@iocc.com> wrote:
>
> In my personal opinion, all of the exe's in the cygwin package
> should support (at a minimum) the GNU --help and --version
options.
> With that in mind, here is a patch for cygserver.cc that
shoehorns them
> in.

Thanks for the heads up Joshua, but your good work in this area
had already prompted me into action: the relevant changelog entry
reads:

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

 (print_usage): New function.
 (print_version): Ditto (tip of the hat to Joshua Daniel Franklin
 for inspiration here).
 (main): More argument checking.  Add --help and --version
options.

Note: all the current work on cygserver is happening on the
cygwin_daemon branch (and it's not really happening just now since
I've been fiddling around with the socket code for the last couple
of weeks) so this has yet to reach the real world.

> AFAIK there is absolutely
> no documentation (other than the mailing list) for cygserver. I
would be
> happy to create some if someone could give me a good rundown of
what
> all is/is not supported at this time. Unfortunately my limited
understanding
> of IPC might make this more trouble than it is worth.

You're right about the documentation for cygserver: all I've seen
is from the mailing list.  I'd imagine that there won't need to be
much documentation written for it (at least, not for the IPC
services) since the basic idea will be that if it is running, then
you get the SysV IPC services, and otherwise not.  And it will
need to run under a privileged account and probably as a service
eventually for those who want it.  Other than that, unless some
configuration is required, that is all there will be to it.

The cygipc package from Chuck Wilson is equivalent to the
cygserver (at least as far as IPC is concerned) and there is a
pretty full README file provided with that, so it might be a place
to look.  For documentation of the IPC calls themselves, the
package includes a chunk of Linux documentation, which is close
enough (I use the SUSv3 documentation mostly) for all the msg*,
sem* and shm* system calls.  There are also the ipcs and ipcrm
utilities that would need to be documented: the current (long
term) plan is for these to end up in the cygutils package.

My current idea is that the next merge of the cygserver code into
the mainline should be sufficient to replace the cygipc server; I
don't see any reason to take any half-steps before that.  This
will require a full implementation of the SysV IPC services
sufficient to get all the current cygwin users of cygipc working
(i.e., postgresql).  So sometime before that, documentation will
be needed along with a few other things.

Cheers,

// Conrad


