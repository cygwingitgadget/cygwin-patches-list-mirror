Return-Path: <cygwin-patches-return-2727-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10075 invoked by alias); 26 Jul 2002 08:16:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10042 invoked from network); 26 Jul 2002 08:16:09 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: qt patch for winnt.h
Date: Fri, 26 Jul 2002 01:16:00 -0000
Message-ID: <016901c2347c$b19f2060$cd6007d5@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20020725201524.GA6611@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00175.txt.bz2

> On Thu, Jul 25, 2002 at 09:43:16PM +0200, Ralf Habacker wrote:
> >> I do prefer feature-centric ifdefs, but I don't think that adding this
> >> particular definition of HANDLE to the windows headers makes sense.
> >
> >I think too, but you have another solution yet. :-)
>
> Not my yob.
>
Why not, you have rich experience in progamming and so on

> Although this is an open source project and you do have the advantage of
> being able to talk to the people who own the system headers, I really think
> that making changes like this in system headers should be done very very
> sparingly.
>
I agree and this this the reason why this thread was started

> >I'm not sure, how this would look in real code, do you have an example ?
>
> #define HANDLE foo_handle
> #include <winnt.h>
> #undef HANDLE
>

The problem with the current implemantation is, that there is no way to hide the
HANDLE definition and I can't see why an implementation in the following manner

winnt.h

#ifndef DONT_DEFINE_HANDLE
typedef void * HANDLE
#endif

makes such big problems as Danny stated.

It is compatible to the current header, but pave the way for an official qt/x11
release (or do you expect that trolltech would change their definitions of the
x11 HANDLE type only based on the fact that this is a precedent ?)

> Another thing I have to wonder is why you are using a mixture of the
> Windows API and the X API rather than X + cygwin.  That seems strange,
> too.

Chris January has told some issue of this, another topics are performance
(using native FindFirstFile/FindNextfile instead of cygwin's opendir/readdir)
and missing dns code (fortunately the qt x11 release contains already code for
accessing native win32 dns code)

I hear you saying, that this would not be the right way to do things, it would
be better to optimize the cygwin dll or to add needed functions, but
unfortunally I haven't the knowledge for doing so and I could only deal with
what I have and that is the way to use function which are available.

Okay, in the abstract there is a way to change the qt sources to use void *, but
this produces incompatible qt libraries (because of the c++ abi) and this
implicate a recompile of all available kde 2 packages, which result in much
support traffic like "why does my kde package can't load the qt dll" and for
this I have no additional time, sorry.

Any comments ?


