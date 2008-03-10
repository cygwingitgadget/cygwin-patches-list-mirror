Return-Path: <cygwin-patches-return-6279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18634 invoked by alias); 10 Mar 2008 10:35:05 -0000
Received: (qmail 18621 invoked by uid 22791); 10 Mar 2008 10:35:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 10 Mar 2008 10:34:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6E08E6D430A; Mon, 10 Mar 2008 11:34:44 +0100 (CET)
Date: Mon, 10 Mar 2008 10:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080310103444.GF18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net> <20080309195509.GD18407@calimero.vinschen.de> <20080309232000.GC14815@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080309232000.GC14815@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00053.txt.bz2

On Mar  9 19:20, Christopher Faylor wrote:
> On Sun, Mar 09, 2008 at 08:55:09PM +0100, Corinna Vinschen wrote:
> >On Mar  9 11:03, Brian Dessent wrote:
> >> Christopher Faylor wrote:
> >> 
> >> > I guess I misunderstood.  I thought that the current working directory
> >> > could be derived through some complicated combination of Nt*() calls.
> >> 
> >> I could be wrong here but the way I understood it, there is no concept
> >> of a working directory at the NT level, that is something that is
> >> maintained by the Win32 layer.
> >
> >That's right.  NT doesn't have a notion what a cwd is.  It only has the
> >OBJECT_ATTRIBUTES structure which defines an object by an absolute path,
> >or by a path relative to a directory handle.
> >
> >The cwd is maintained by kernel32.dll in a per-process structure called
> >RTL_USER_PROCESS_PARAMETERS.  The cwd is stored as path (always with
> >trailing backslash) and as handle.
> 
> Duh, right.  I knew that.  I've seen the code.
> 
> So, maybe we could make sure the handle was inherited and pass it along
> in a _CYGWIN_PWD=0x239487 format to the child?

Well, sure, we could do that.  But here's still a small problem.

The Win32 functions like CreateFileW don't have a way to use the
directory handle together with the relative path name as the native NT
functions have.  So, to be able to create an absolute path name, the
application would have to find out the path the handle refers to using
the native NT function ZwQueryObject.  What it gets, however, is not
directly usable with Win32 functions:

  Input path:                  c:\home\cgf
  Equivalent Win32 long path:  \\?\c:\home\cgf

  ZwQueryObject returns:       \Device\HarddiskVolume1\home\cgf

By iterating through the DOS device list returned by QueryDosDevice the
application could now find out that C: is a NT symlink to
\Device\HarddiskVolume1 and then in turn create the path \\?\C:\home\cgf
from that.  Sounds rather too complicated to me.

The alternative would be to open files always with NtOpenFile/
NtCreateFile.  I had this vague idea that we should avoid that for the
MingW tools in utils. 

If you really think this is the better approach, ok with me, but if we
create an environment variable anyway, why not use $PWD or create
$_CYGWIN_PWD as *path* when starting a native application?  It would
allow to use standard Win32 functions without much hassle.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
