Return-Path: <cygwin-patches-return-3120-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22220 invoked by alias); 5 Nov 2002 13:52:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22205 invoked from network); 5 Nov 2002 13:52:21 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 05 Nov 2002 05:52:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Patch for MTinterface
In-Reply-To: <1036502950.17049.51.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0211051439230.365-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q4/txt/msg00071.txt.bz2



On Tue, 5 Nov 2002, Robert Collins wrote:

> On Wed, 2002-11-06 at 00:14, Thomas Pfaff wrote:
> >
> > I have discovered some problems with the current MTinterface
> > implementation. Here are 2 test cases:
>
> > Even if the handles would be valid the pthread_join call would try to
> > delete a thread object that is created static which would result in a
> > corrupted heap.
>
> Ouch. Good catch.
>
> > 2: fork related
>
> > The forked child will not get the same thread handle as its parent, it
> > will get the thread handle from the main thread instead. The child will
> > not terminate because the threadcount is still 2 after the fork (it is
> > set to 1 in MTinterface::Init and then set back to 2 after the childs
> > memory gets overwritten by the parent).
>
> For memory that should not be copied, mark it with NO_COPY in the
> declaration. MTinterface is set thusly IIRC.

dcrt0.cc:72:MTinterface _mtinterf;
If the MTinterface would be NO_COPY than all fixup_after_fork calls would
not work.

>
> > And i do not agree with the the current pthread_self code where the
> > threadcount is incremented if a new thread handle has been created but
> > never gets decremented (i do not expect that threads that are not created
> > by pthread_created will terminate via pthread_exit). And the newly created
> > object never gets freed.
>
> The dllinit routine will take care of this when we get that implemented
> again. I don't

I agree with Chris that calling code that might block on a mutex on
thread detach would lead to a deadlock situation. Since you have no
control what code will run in key desctructor functions i better would not
run the destructors on thread detach (which would happen if you call
pthread_exit on thread detach).

>
> > To avoid these errors i have made changes that will create the mainthread
> > object dynamic and store the reents and thread self pointer via fork safe
> > keys.
>
> Overall this looks good. What happens to non-cygwinapi created threads
> now though? You mention you don't agree with the code, but I can't see
> (from a brief look) how you correct it.

They will get a pthreadNull object in the pthread_self call. No memory
leaks, no lost handles and of course no chance to call any pthread
function (But since the are not created via pthread_create i do no not
expect that they make a call other than pthread_testcancel).

Thomas
