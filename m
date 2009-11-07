Return-Path: <cygwin-patches-return-6817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28710 invoked by alias); 7 Nov 2009 10:08:26 -0000
Received: (qmail 28697 invoked by uid 22791); 7 Nov 2009 10:08:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 07 Nov 2009 10:08:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 524E86D434D; Sat,  7 Nov 2009 11:08:07 +0100 (CET)
Date: Sat, 07 Nov 2009 10:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091107100807.GA14099@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <416096c60911061355vac592d4y4c76435689301aad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416096c60911061355vac592d4y4c76435689301aad@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00148.txt.bz2

On Nov  6 21:55, Andy Koppe wrote:
> 2009/11/6 Thomas Wolff:
> > * I would like to fix some key assignments:
> >  - Control-(Shift-)6 inputs Control-^ which is not proper on international
> >    keyboards if Shift-6 is not "^", Control-^ (the key) does not input
> >    Control-^ (the character) on the other hand; the same glitch
> >    occurs in the pure Windows console, however.
> >    Unfortunately, with the functions being used it is not possible to
> >    detect that shifted key "^" was hit together with Control; only
> >    keycodes/scancodes are available when Control/Shift/Alt are used. So
> >    I don't know whether this can easily be fixed. It works in mintty but
> >    I think mintty uses different Windows functions.
> 
> Mintty roughly does the following for Ctrl(+Shift)+symbol combinations:
> - obtain the keymap using GetKeyboardState()
> - set the state of the Ctrl key to released
> - invoke ToUnicode() to get the character code according to the keyboard layout
> - if the character code is one of [\]_^? send the corresponding control code
> - otherwise, set the state of both Ctrl and Alt to pressed (this is
> equivalent to AltGr), and try ToUnicode() again
> 
> The last step means that e.g. Ctrl+9 on a German keyboard will send
> ^]. The proper combination would be Ctrl+AltGr+9, but since
> AltGr==Ctrl+Alt, that can't be distinguished from AltGr+9 without
> Ctrl. (Well, not without somewhat dodgy trickery anyway.)

How does that work for ^^?  The ^ key is a deadkey on the german keyboard
layout, so the actual char value is only generated after pressing the key
twice.  Just curious.

> Btw, ^[, ^], and ^\ are actually available as Ctrl+ü, Ctrl+plus, and
> Ctrl+# in the German keyboard layout, but those combinations make no
> sense unless you're familiar with the US layout.

Indeed.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
