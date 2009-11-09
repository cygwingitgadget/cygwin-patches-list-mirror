Return-Path: <cygwin-patches-return-6820-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24822 invoked by alias); 9 Nov 2009 07:46:32 -0000
Received: (qmail 24812 invoked by uid 22791); 9 Nov 2009 07:46:31 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.149)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Nov 2009 07:46:25 +0000
Received: by qw-out-1920.google.com with SMTP id 4so419629qwk.20         for <cygwin-patches@cygwin.com>; Sun, 08 Nov 2009 23:46:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.36.195 with SMTP id u3mr1045294qcd.61.1257752783671; Sun,  	08 Nov 2009 23:46:23 -0800 (PST)
In-Reply-To: <4AF73FEC.2050300@towo.net>
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de> 	 <20091106101448.GA2568@calimero.vinschen.de> 	 <4AF73FEC.2050300@towo.net>
Date: Mon, 09 Nov 2009 07:46:00 -0000
Message-ID: <416096c60911082346q539b94a3w6fb7fd8774df2cb8@mail.gmail.com>
Subject: Re: console enhancements: mouse events
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00151.txt.bz2

Thomas Wolff:
>>> =C2=A0Note: This works on my home PC (Windows XP Home) but it's not eff=
ective
>>> =C2=A0on my work PC (Windows XP Professional) where the mouse wheel scr=
olls the
>>> =C2=A0Windows console (which it doesn't on the other machine); I don't =
know =C2=A0how
>>> to disable or configure this.

I've come across a similar issue in mintty: on some machines, if the
scrollbar is enabled, mousewheel events never reach the window's event
loop. I never really got to the bottom of it, but I think it's to do
with mouse drivers: some appear to send mousewheel events straight to
a window's scrollbar if there is one, no matter where in the window
the mouse is positioned.

>> [Ctrl+AltGr+key stuff]

> Thanks Andy for pointing to the part of mintty code handling this. Howeve=
r,
> the whole function there looks too complex for a quick copy-paste-patch.

Nested functions, big switches, and even a couple of gotos, that
function has it all. ;)

> Maybe later... or Andy might like to factor out the mapping part in a way
> directly reusable for the cygwin console?

Erm, no. The crucial subfunction there is undead_keycode().

> It
> does not work however, even for ASCII characters, for characters produced
> with AltGr, e.g. Alt-AltGr-Q where AltGr-Q is @ (German keyboard). Andy g=
ot
> this to work in mintty (I think with some other subtle trick after I
> challenged him for it IIRC); it does not work in xterm either.

You can tell whether both Alt and AltGr are down by checking VK_LMENU
and VK_RMENU.

Andy
