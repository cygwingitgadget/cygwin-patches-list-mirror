Return-Path: <cygwin-patches-return-2726-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9487 invoked by alias); 26 Jul 2002 08:15:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9459 invoked from network); 26 Jul 2002 08:15:16 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: qt patch for winnt.h
Date: Fri, 26 Jul 2002 01:15:00 -0000
Message-ID: <016801c2347c$91f1b0c0$cd6007d5@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20020725212633.90069.qmail@web14504.mail.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00174.txt.bz2

> What I don't like is the precedent.  Featuritis is catching.
>
> > I'm sure that Danny will comment on this.  He's probably doing something
> > selfish like sleeping or eating breakfast right now.
>
> And typing on a keyboard -- all at the same time.
>
> I do not like this patch, because it means more work for me when YA typedef
> conflict arises and someone else submits a patch (followed by YA long-winded
> discussion) to fix that one, and that one breaks someone else's idea of what
> the typedef should be and ...
>
> The "standard" for the w32api is MSDN docs. Why can't projects that use the
> w32api follow those standards?

trolltech, who has written this framework, follows the standard, if qt is
compiled as pure win 32app.
That they use uint HANDLE on X11 system may have historical reasons, I don't
know, but fact is we have currently this problem.

>
> Now I'd better unlock the garage and let the kids out.
>
> Danny
>
> > >I'm not sure, how this would look in real code, do you have an example ?
> >
> > #define HANDLE foo_handle
> > #include <winnt.h>
> > #undef HANDLE
> >
> >
> > cgf
>
>
> http://digital.yahoo.com.au - Yahoo! Digital How To
> - Get the best out of your PC!
>
