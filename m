Return-Path: <cygwin-patches-return-4732-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14692 invoked by alias); 8 May 2004 02:55:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14682 invoked from network); 8 May 2004 02:55:29 -0000
Date: Sat, 08 May 2004 02:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Improving the anonymous ftp environment.
Message-ID: <20040508025529.GC517@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040507210208.008081c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040507210208.008081c0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00084.txt.bz2

On Fri, May 07, 2004 at 09:02:08PM -0400, Pierre A. Humblet wrote:
>The background of this patch is that in order to test the chdir
>patch under chroot condition I setup an anonymous ftp account.
>
>I realized that to be able to ls (under anonymous) I had to
>copy /bin/ls.exe to /home/ftp/bin, but also the cygwin1.dll and
>all other dll's used by ls.exe. That flies in the face of our
>recommendation to have only one cygwin1.dll, and it's a pain to
>maintain (Sure, we could add smarts to setup).
>
>So it was obvious that the Windows PATH did not contain 
>c:\cygwin\bin  (for the uninitiated, the Windows and the Cygwin
>environments are not identical).
>
>Looking into it, the Cygwin PATH seen by ls had its standard
>pre-chroot value, but the Windows PATH was NULL. The conversion
>from Posix paths to Win32 paths fails because some paths are 
>outside of the chroot area.
>
>The solution uses the fact that the Posix and Win32 values of PATH
>are cached into a win_env structure. It initializes that structure
>before changing the root, so that there is no conversion issue. 
>Also the NO_COPY attribute of the cache is removed, so that it 
>propagates across forks (also avoiding a small memory leak, as it 
>points to malloced areas).
>
>There are other solutions, but I couldn't think of anything
>simpler.

The memory leak is a good point (and has mildly bothered me since I
implemented this) but aren't you essentially opening a mechanism to
access things outside of the chrooted environment with this patch?

I wonder if, these days, all of the environment cache should be in
the cygheap.

Btw, in chroot should you be calling "set_errno (path.error)" rather
than "__seterrno ()"?

Anyway, I've check this in with the errno modification.  I'm not sure
what the best way to deal with the problem of multiple cygwin's might
be.  As you note it is ok to just copy the same cygwin into two
locations but, boy, that's going to be a pain to maintain.

cgf
