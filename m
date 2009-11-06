Return-Path: <cygwin-patches-return-6814-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13535 invoked by alias); 6 Nov 2009 10:15:06 -0000
Received: (qmail 13522 invoked by uid 22791); 6 Nov 2009 10:15:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Nov 2009 10:14:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3327A6D4195; Fri,  6 Nov 2009 11:14:48 +0100 (CET)
Date: Fri, 06 Nov 2009 10:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091106101448.GA2568@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>
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
X-SW-Source: 2009-q4/txt/msg00145.txt.bz2

On Nov  6 09:20, Thomas Wolff wrote:
> Hi,
> About enhancements of cygwin console features, I've now worked out a 
> patch which does the following:

Thanks for the patch, it looks like a nice addition.

However, there's the problem of the copyright assignment.  As described
on the http://cygwin.com/contrib.html page, in the "Before you get
started" section, we can't take non-trivial patches without have a
signed copyright assignment form (http://cygwin.com/assign.txt) in place.

Usually it takes the time to snail-mail the assignment to California,
plus 3 or 4 days.  Sorry for the hassle, but it's legally necessary.

A few comments:

> * Implement additional mouse reporting modes 1002 and 1003 as known 
>   from xterm and mintty; they report mouse move events.
> * Add detection and reporting of mouse scroll events to mouse reporting 
>   mode 1000.
>   Note: This works on my home PC (Windows XP Home) but it's not effective 
>   on my work PC (Windows XP Professional) where the mouse wheel scrolls the 
>   Windows console (which it doesn't on the other machine); I don't know 
>   how to disable or configure this.

Open the console properties dialog and disable QuickEdit.

> * Enforce consistence between select() and read() about whether mouse 
>   reporting input is available by moving all checks into the common 
>   function mouse_aware.
> * Add mouse focus reporting mode 1004 as known from xterm and mintty.
> * As a separate change, where I added the initialization of the additional 
>   reporting modes, I also added and fixed some screen attribute modes as 
>   known from the Linux console (and xterm):
>   - ESC[22m disable bold, ESC[28m disable invisible, ESC[25m disable blinking
>   - ESC[2m dim as usual on other terminals, instead of ESC[9m

For backward compatibility, I'd prefer if ESC[9m would still do the same.
As long as ESC[9m isn't desparately needed for something else...

> Some other console issues (not covered by this patch) are probably better 
> discussed on cygwin-developers but maybe I can mention them here already:
> * Maybe the escape sequences of shifted function keys should be modified 
>   to comply with those of the Linux console?

Aren't they compatible with xterm?  I don't think it's a terrible good
idea to change that.

> * I would like to fix some key assignments:
>   - Control-(Shift-)6 inputs Control-^ which is not proper on international 
>     keyboards if Shift-6 is not "^", Control-^ (the key) does not input 
>     Control-^ (the character) on the other hand; the same glitch 
>     occurs in the pure Windows console, however.
>     Unfortunately, with the functions being used it is not possible to 
>     detect that shifted key "^" was hit together with Control; only 
>     keycodes/scancodes are available when Control/Shift/Alt are used. So 
>     I don't know whether this can easily be fixed. It works in mintty but 
>     I think mintty uses different Windows functions.

How do you enter any of the control chars ^^, ^\, ^[, ^], ^_ anyway?
In a CMD window using an english keyboard I can just enter any of them
using the control char,  C+S+6 = ^^, C+\ = ^\, C+[ = ^[, C+] = ^],
and C+S+- = ^_.  Same in a cygwin console.  The reason is that these
sequences return their ASCII value in the INPUT_RECORD in
Event.KeyEvent.uChar.

Except for one of them, this doesn't work with a german keyboard and
german keyboard layout.  In this case, the respective keysequences
C+^, C+AltGr+sz, C+AG+8, C+AG+9 return nothing at all.  Only the
C+S+- key returns ^_, as expected.

>   - Pressing something like Alt-ö on a German keyboard leaves an illegal UTF-8 
>     sequence (the second byte of the respective sequence) in input, apparently 
>     because Alt-0xC3 is handled somehow. Don't know, though, whether this is 
>     a cygwin console issue or maybe a readline issue.

Alt is converted to a leading ESC.  I don't know how to fix that for
non-ASCII chars, yet.

> * I intended to implement cursor position reports and noticed that their 
>   request ESC[6n is already handled in the code; it does not work, however, 
>   so I started to debug it:

This needs some more debugging, I guess.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
