Return-Path: <cygwin-patches-return-2720-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16655 invoked by alias); 25 Jul 2002 19:43:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16641 invoked from network); 25 Jul 2002 19:43:23 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: qt patch for winnt.h
Date: Thu, 25 Jul 2002 12:43:00 -0000
Message-ID: <015301c23413$8551d1b0$cd6007d5@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20020725174050.GE2281@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00168.txt.bz2

> >Perhaps you would prefer this better.  I changed the ifdef to be
> >feature-centric as opposed to project-centric.  Perhaps this is a little
> >more to your liking?
>
<snip>

> I don't understand why the project needs a non-standard definition for
> HANDLE unless they are using it in some other context than the Windows
> one.  It is defined as a void * in my MSVC headers so why would
> anyone try to use anything else?
>
qt is a multiplatform framework and they defines HANDLE different on different
platforms.
(the sample code is from qt-3, but qt-2 uses the same strategy).
In short the windows, mac, and qt embedded releases uses "void *" the x11
release uses "ulong"

qt-2/src/kernel/qwindowdefs.h

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/kde-cygwin/qt-2/src/kernel/qwindo
wdefs.h?rev=1.1.1.1&content-type=text/vnd.viewcvs-markup


qt-3/src/kernel/qnamespace.h
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/kde-cygwin/qt-3/src/kernel/qnames
pace.h?rev=1.1.1.1&content-type=text/vnd.viewcvs-markup

<snip>
    // "handle" type for system objects. Documented as \internal in
    // qapplication.cpp
#if defined(Q_WS_MAC)
    typedef void * HANDLE;
#elif defined(Q_WS_WIN)
    typedef void *HANDLE;
#elif defined(Q_WS_X11)
    typedef unsigned long HANDLE;
// qt embedded
#elif defined(Q_WS_QWS)
    typedef void * HANDLE;
#endif

The problem is now, that we are compiling under Q_WS_X11, which defines HANDLE
as ulong, but we are using the w32api too, which defines HANDLE as void *
(because we are using some native win32 functions), so we have the choose. I've
tried the void * definition, but in the X11 context this results many casting
problems, which produces very bad compatibility problems with the original
source, so I've choosed the x11 handle context, which causes the know trouble
with the w32api winnt.h header. So we patched the winnt header, which gives us
much less headache :-)

> I do prefer feature-centric ifdefs, but I don't think that adding this
> particular definition of HANDLE to the windows headers makes sense.

I think too, but you have another solution yet. :-)

> I'd rather see something like a "DONT_DEFINE_HANDLE" define and have
> the handle defined elsewhere.

This seems good, what about the opposite handling .

qtxxx.h
typedef unlong HANDLE;
#define HANDLE_IS_DEFINED
...

winnt.h defines only HANDLE if it isn't defined before, like

#ifndef HANDLE_IS_DEFINED
#define HANDLE_IS_DEFINED
+ typedef void *HANDLE;
#endif

> Isn't it possible to protect the handle with a define somewhere prior
> to calling winnt.h and then undefine it after the includes?
>

I'm not sure, how this would look in real code, do you have an example ?

Ralf
