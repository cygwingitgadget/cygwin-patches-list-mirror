Return-Path: <cygwin-patches-return-4803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4468 invoked by alias); 2 Jun 2004 14:20:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4449 invoked from network); 2 Jun 2004 14:20:06 -0000
Date: Wed, 02 Jun 2004 14:20:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] To handle Win32 pipe names
Message-ID: <20040602142002.GB23455@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F32Fj3NAah6gz90005b96d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY9-F32Fj3NAah6gz90005b96d@hotmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00155.txt.bz2

On May 21 13:37, Stephen Cleary wrote:
> But, while //server/pipe/name may be a UNC path, it is not a path to a 
> file. And certain Win32 functions (including GetFileAttributes) do not work 
> on those paths. When I say "do not work", I mean the Win32 SDK actually 
> says not to call them on those paths, and when I do it on my XP Pro SP1 
> (with all updates), odd behavior ensues. This is undefined behavior. 
> Sometimes I can see weird stuff at the filesystem level using SysInternals' 
> FileMon.
> So, as it currently stands, stat() and the check for symlinks are fully 
> broken for Win32 pipes - they actually cause undefined behavior.

Shouldn't Pierre's observations from yesterday clear this up a bit?
Are the attributes set to 0x20 or -1 respectively?

> "\\.\" doesn't necessarily mean "open a device". It is possible to open a 
> normal file using that syntax - "\\.\c:\tmp.txt" works fine. "\\.\" is just 
> a placeholder for "\??\" when the call goes to the native level.

Yes, that's right.  However, what I'm trying to say is this:  Getting
Win32 pipes working "untranslated" is not exactly what Cygwin's main
job is.  It's enough if open/read/write/close work.  Stat doesn't
necessarily need to return something meaningful.  Actually a native
Win32 named pipe isn't a POSIX named pipe.  If stat returns that info
for a Win32 named pipe, it would even be misleading, since the behaviour
isn't POSIX like.  But that's what a POSIX application would expect from
such a named pipe.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
