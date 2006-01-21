Return-Path: <cygwin-patches-return-5718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6592 invoked by alias); 21 Jan 2006 12:14:31 -0000
Received: (qmail 6581 invoked by uid 22791); 21 Jan 2006 12:14:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sat, 21 Jan 2006 12:14:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5EA2C544001; Sat, 21 Jan 2006 13:14:27 +0100 (CET)
Date: Sat, 21 Jan 2006 12:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: full .lnk support
Message-ID: <20060121121427.GA20745@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY103-F10482309B205ED1887658FD31E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F10482309B205ED1887658FD31E0@phx.gbl>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00027.txt.bz2

On Jan 20 23:10, Devin Teske wrote:
> Hey there,
> 
> first time poster, but I'm not a member of the list, so please reply 
> directly.
> 
> After 8 long months, I have fully reverse-engineered the Windows `.lnk' 
> (shortcut) file format and have a core function set for creating/resolving 
> them. I know that cygwin ALREADY understands Windows shortcuts, but not 
> only barely. Cygwin does not resolve shortcuts created by windows.
> 
> It is worth noting that there are multiple versions of the shortcut file 
> format (binary fields were added in Windows NT/2000/XP that differ from Win 
> 9x). Also, when cygwin creates a shortcut, it does not have the icon of the 
> source file when viewed in explorer (not going to explain why exactly, I'll 
> keep it short for now) because cygwin (to be blunt) creates crappy shortcut 
> files.

The format used is compatible to the format used by U/Win.  Plus, we're
adding an ITEMIDLIST which helps newer Windows versions to identify the
target type correctly.

The interesting feature of our and U/Win's symlinks is that they can be
identified as Cygwin resp. U/Win symlinks.  This is especially important
to *not* identify natively generated shortcuts as symlinks.

Windows native shortcuts contain a lot of information which isn't
contained in normal symlinks, for instance icons, dial-up information
and more weird stuff.  When we started using shortcuts as symlinks, we
treated every shortcut as symlink.  But we had to drop this very soon
again.  Archivers like tar or cpio treat symlinks specially.  They don;t
try to save a file but only a path to the symlink target.  If you treat
all shortcuts as symlinks, they are packed as symlinks by archivers.
When you unpack them, all the extra information contained in a shortcut
is lost.  That's the reason we differ between shortcuts and
symlink-shortcuts.

So, sorry, but no, we're not interested in changing the code to treat
all shortcuts as symlinks or to create symlink-shortcuts in a way which
disallows us to differ they from native shortcuts.  Been there, done
that.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
