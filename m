Return-Path: <cygwin-patches-return-2474-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13325 invoked by alias); 20 Jun 2002 21:11:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13251 invoked from network); 20 Jun 2002 21:11:29 -0000
Message-ID: <009b01c2189f$4bc45560$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
References: <004b01c21899$07845090$0200a8c0@lifelesswks>
Subject: Re: cygserver patch
Date: Thu, 20 Jun 2002 14:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00457.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> I'm short on time (still!).

I fully understand: it's the basic human condition this century :-)

> Can you generate a patch including the following changes:
> > * Conditionalize the security code so that cygserver works on
non-NT
> > platforms.
> > * Add definitions of the strace XXX_printf macros to allow code to
use
> > these whether it's compiled for the DLL or for the daemon.
> > * Several minor C++ related changes: for example, making some
methods
> > pure virtual, and adding virtual destructors throughout as
required.
> > * Add --version and --help options.
> > * Add checking for an existing instance of the daemon to avoid
having
> > multiple copies running.
> > * Some more error checking throughout.
>
> > * Refactor the client request classes for greater encapsulation
and to
> > support variable length requests.
>
> I need to review the last above change, as variable length requests
were
> already supported.

What I've done is to hold a buffer length and a message length
separate: the message length is in the header and is what is
transmitted back and forth; the buffer length is stored in the
client_request object. Thus when a request arrives, the base class can
check whether the message is too long for the buffer provided by the
base class. I've set things up so that the classes that have no out
parameters, e.g. the version query, set up a buffer big enough to
receive the reply but send a zero-sized body (i.e. no body is sent).
Also, the shmop CREATE request only sends as much of the security
descriptor buffer as necessary, using the length returned by sd_alloc
().

Previously client requests couldn't be of variable size since the code
checked whether they the message bodies were the same size as the
buffer provided for their receipt. Given your comment, maybe I'm
missing something here?

> I think that the ipcs preparation changes should stay
> on the branch for now.

Fair enough: when I've got any code that needs it, i.e. ipcs(8), I'll
bundle it up again.

> If you can generate such a patch, I will review
> it asap (ie a few days :[).

Coming along. Two questions:

*) I've got a better check for the duplicate servers on NT using a
special flag on CreateNamedPipe (introduced in NT5 SP2 and in XP for
security reasons). Would you accept this too?

*) I wasn't clear whether you wanted the client_request changes in the
patch? or, were you just saying to include them and you'd review them?
which is what I'd like you to have meant :-)

Thanks for the reply.

// Conrad


