Return-Path: <cygwin-patches-return-2472-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6817 invoked by alias); 20 Jun 2002 20:28:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6775 invoked from network); 20 Jun 2002 20:28:20 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: cygserver patch
Date: Thu, 20 Jun 2002 13:28:00 -0000
Message-ID: <004b01c21899$07845090$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <018801c2171f$0a68f1b0$6132bc3e@BABEL>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q2/txt/msg00455.txt.bz2

I'm short on time (still!).

Can you generate a patch including the following changes:
> * Conditionalize the security code so that cygserver works on non-NT
> platforms.
> * Add definitions of the strace XXX_printf macros to allow code to use
> these whether it's compiled for the DLL or for the daemon.
> * Several minor C++ related changes: for example, making some methods
> pure virtual, and adding virtual destructors throughout as required.
> * Add --version and --help options.
> * Add checking for an existing instance of the daemon to avoid having
> multiple copies running.
> * Some more error checking throughout.

> * Refactor the client request classes for greater encapsulation and to
> support variable length requests.

I need to review the last above change, as variable length requests were
already supported. I think that the ipcs preparation changes should stay
on the branch for now. If you can generate such a patch, I will review
it asap (ie a few days :[).

Cheers,
Rob


> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Conrad Scott
> Sent: Wednesday, 19 June 2002 9:23 AM
> To: cygwin-patches@cygwin.com
> Subject: cygserver patch
> 
> 
> I've been committing a sequence of patches for cygserver on the
> cygwin_daemon branch over the last few days and I was thinking it was
> about time to submit the current batch for consideration for the
> mainline. I've attached a cumulative ChangeLog for the individual
> patches and a bzip'ed patch file. (I've not appended the entire
> ChangeLog here as it's rather long.) This patch is against the current
> HEAD version, which I merged into the branch yesterday. Nicholas
> Wourms has kindly downloaded the branch version and confirmed that it
> works on a non-NT platform. I've also successfully run the ipctests
> and has the server running continually while I've been developing. In
> other words, I don't seem to have broken anything :-)
> 
> Which is all well and good, but what have I actually done? Summary:
> 
> * Conditionalize the security code so that cygserver works on non-NT
> platforms.
> * Refactor the client request classes for greater encapsulation and to
> support variable length requests.
> * Add new interfaces for the (eventual) implementation of ipcs(8).
> * Add definitions of the strace XXX_printf macros to allow code to use
> these whether it's compiled for the DLL or for the daemon.
> * Several minor C++ related changes: for example, making some methods
> pure virtual, and adding virtual destructors throughout as required.
> * Add --version and --help options.
> * Add checking for an existing instance of the daemon to avoid having
> multiple copies running.
> * Some more error checking throughout.
> 
> In other words, almost nothing shm related as it's not quite finished,
> so I've not checked any of that into the branch as yet. This is all
> just groundwork :-)
> 
> [One thing to note about this patch is that it includes a new file,
> "woutsup.h". I only mention this in case anything special needs to be
> done in cvs if/when the patch is committed.]
> 
> I hope this is all fine and that someone has a chance to look it over
> sometime soon-ish.
> 
> Thanks.
> 
> // Conrad
> 
> 
