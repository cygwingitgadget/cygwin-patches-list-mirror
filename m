Return-Path: <cygwin-patches-return-6268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6336 invoked by alias); 9 Mar 2008 10:36:47 -0000
Received: (qmail 6324 invoked by uid 22791); 9 Mar 2008 10:36:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 10:36:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 1DA646D430A; Sun,  9 Mar 2008 11:36:18 +0100 (CET)
Date: Sun, 09 Mar 2008 10:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309103618.GZ18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de> <47D3BCAC.98C49164@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D3BCAC.98C49164@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00042.txt.bz2

On Mar  9 03:32, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > > > I'm wondering if you would like to tweak the readlink functions, too.
> > > > Cygwin shortcuts can now have the path name appended to the actual
> > > > shortcut data.  This hack was necessary to support pathnames longer than
> > > > 2000 chars.  See the comment and code in cygwin/path.cc, line 3139ff.
> > >
> > > Oh, I didn't know that.  I'll add that to the list.
> > 
> > Thanks again.  I'm finally seeing light at the end of the long path
> > name tunnel :)
> 
> Actually I'm a little confused now.  It seems like the code in
> utils/path.cc:readlink() reads the Win32 path out of shortcut symlinks
> but the POSIX path out of old-style symlinks -- not that it has any
> choice since they don't contain the win32 path.  If that is the case
> (and assuming I'm reading the new long filename symlink code correctly)
> then it doesn't need any chaging since the [path too long] workaround
> only applies to the POSIX link target stored in the 'description' field,
> right?

Now that you mention it... did you see the comment in path.cc, line 3112ff?
There's a good chance that Windows shortcuts are not capable of long path
names.  I didn't test it so far, but it would be certainly better for
readlink to use the POSIX path in the symlink either way.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
