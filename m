Return-Path: <cygwin-patches-return-6816-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20454 invoked by alias); 6 Nov 2009 21:55:57 -0000
Received: (qmail 20442 invoked by uid 22791); 6 Nov 2009 21:55:57 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.145)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Nov 2009 21:55:53 +0000
Received: by qw-out-1920.google.com with SMTP id 4so221050qwk.20         for <cygwin-patches@cygwin.com>; Fri, 06 Nov 2009 13:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.2.23 with SMTP id 23mr666217qch.87.1257544551914; Fri, 06  	Nov 2009 13:55:51 -0800 (PST)
In-Reply-To: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>
Date: Fri, 06 Nov 2009 21:55:00 -0000
Message-ID: <416096c60911061355vac592d4y4c76435689301aad@mail.gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00147.txt.bz2

2009/11/6 Thomas Wolff:
> * I would like to fix some key assignments:
> =C2=A0- Control-(Shift-)6 inputs Control-^ which is not proper on interna=
tional
> =C2=A0 =C2=A0keyboards if Shift-6 is not "^", Control-^ (the key) does no=
t input
> =C2=A0 =C2=A0Control-^ (the character) on the other hand; the same glitch
> =C2=A0 =C2=A0occurs in the pure Windows console, however.
> =C2=A0 =C2=A0Unfortunately, with the functions being used it is not possi=
ble to
> =C2=A0 =C2=A0detect that shifted key "^" was hit together with Control; o=
nly
> =C2=A0 =C2=A0keycodes/scancodes are available when Control/Shift/Alt are =
used. So
> =C2=A0 =C2=A0I don't know whether this can easily be fixed. It works in m=
intty but
> =C2=A0 =C2=A0I think mintty uses different Windows functions.

Mintty roughly does the following for Ctrl(+Shift)+symbol combinations:
- obtain the keymap using GetKeyboardState()
- set the state of the Ctrl key to released
- invoke ToUnicode() to get the character code according to the keyboard la=
yout
- if the character code is one of [\]_^? send the corresponding control code
- otherwise, set the state of both Ctrl and Alt to pressed (this is
equivalent to AltGr), and try ToUnicode() again

The last step means that e.g. Ctrl+9 on a German keyboard will send
^]. The proper combination would be Ctrl+AltGr+9, but since
AltGr=3D=3DCtrl+Alt, that can't be distinguished from AltGr+9 without
Ctrl. (Well, not without somewhat dodgy trickery anyway.)

Btw, ^[, ^], and ^\ are actually available as Ctrl+=C3=BC, Ctrl+plus, and
Ctrl+# in the German keyboard layout, but those combinations make no
sense unless you're familiar with the US layout. It's similar with
many, but by no means all, other layouts. (Microsoft's Keyboard Layout
Creator is a good way to inspect different layouts.)

> =C2=A0- Pressing something like Alt-=C3=B6 on a German keyboard leaves an=
 illegal UTF-8
> =C2=A0 =C2=A0sequence (the second byte of the respective sequence) in inp=
ut, apparently
> =C2=A0 =C2=A0because Alt-0xC3 is handled somehow. Don't know, though, whe=
ther this is
> =C2=A0 =C2=A0a cygwin console issue or maybe a readline issue.

Readline issue. It's fine in zsh.

Andy
