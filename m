Return-Path: <cygwin-patches-return-2723-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20748 invoked by alias); 25 Jul 2002 22:00:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20734 invoked from network); 25 Jul 2002 22:00:58 -0000
X-WM-Posted-At: avacado.atomice.net; Thu, 25 Jul 02 23:00:58 +0100
Message-ID: <00e701c23426$c1f1dc10$0100a8c0@atomice.net>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <015301c23413$8551d1b0$cd6007d5@BRAMSCHE>
Subject: Re: qt patch for winnt.h
Date: Thu, 25 Jul 2002 15:00:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00171.txt.bz2

> > >Perhaps you would prefer this better.  I changed the ifdef to be
> > >feature-centric as opposed to project-centric.  Perhaps this is a
little
> > >more to your liking?
> >
> <snip>
>
> > I don't understand why the project needs a non-standard definition for
> > HANDLE unless they are using it in some other context than the Windows
> > one.  It is defined as a void * in my MSVC headers so why would
> > anyone try to use anything else?
> >
> qt is a multiplatform framework and they defines HANDLE different on
different
> platforms.
> (the sample code is from qt-3, but qt-2 uses the same strategy).
> In short the windows, mac, and qt embedded releases uses "void *" the x11
> release uses "ulong"
>
> qt-2/src/kernel/qwindowdefs.h
>
>
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/kde-cygwin/qt-2/src/kernel/qw
indo
> wdefs.h?rev=1.1.1.1&content-type=text/vnd.viewcvs-markup
>
>
> qt-3/src/kernel/qnamespace.h
>
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/kde-cygwin/qt-3/src/kernel/qn
ames
> pace.h?rev=1.1.1.1&content-type=text/vnd.viewcvs-markup
>
> <snip>
>     // "handle" type for system objects. Documented as \internal in
>     // qapplication.cpp
> #if defined(Q_WS_MAC)
>     typedef void * HANDLE;
> #elif defined(Q_WS_WIN)
>     typedef void *HANDLE;
> #elif defined(Q_WS_X11)
>     typedef unsigned long HANDLE;
> // qt embedded
> #elif defined(Q_WS_QWS)
>     typedef void * HANDLE;
> #endif
>
> The problem is now, that we are compiling under Q_WS_X11, which defines
HANDLE
> as ulong, but we are using the w32api too, which defines HANDLE as void *
> (because we are using some native win32 functions), so we have the choose.
I've
> tried the void * definition, but in the X11 context this results many
casting
> problems, which produces very bad compatibility problems with the original
> source, so I've choosed the x11 handle context, which causes the know
trouble
> with the w32api winnt.h header. So we patched the winnt header, which
gives us
> much less headache :-)
>
> > I do prefer feature-centric ifdefs, but I don't think that adding this
> > particular definition of HANDLE to the windows headers makes sense.
>
> I think too, but you have another solution yet. :-)

I would suggest adding the patch for winnt.h to the source distribution for
qt and let the user apply it themselves if they wish to compile KDE on their
systems. If necessary we can add a configure check to ensure the patch has
been applied (and remind the user to do it if it hasn't been). This step
should be documented in the appropriate README, of course. There is
currently a similar check in place to ensure the user is using  a compatible
version of libtool.

Chris asked the question why are we using a mixed Cygwin/X and native
Windows environment. One example of where this is necessary is in a Cygwin
specific extension to KDE which shows the Windows drives in the KDE file
dialog and Konqueror. This code needs to get a list of drives on the system,
however a readdir on /cygdrive only shows the list of drives with disks
currently in them (i.e. removable drives without disks don't show up).
Therefore we use GetLogicalDriveStrings in the code and include the
windows.h header, as well as various KDE headers, which in turn include Qt
headers with the conflicting definition of HANDLE. There are other instances
as well, where we have written native implementations for certain Qt
classes.

Chris

