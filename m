Return-Path: <cygwin-patches-return-4733-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30826 invoked by alias); 8 May 2004 18:15:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30811 invoked from network); 8 May 2004 18:15:16 -0000
Message-Id: <3.0.5.32.20040508141216.00803820@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 08 May 2004 18:15:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Improving the anonymous ftp environment. 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00085.txt.bz2

On Fri, 7 May 2004 22:55:29 -0400, Christopher Faylor  wrote:

> The memory leak is a good point (and has mildly bothered me since
> implemented this) but aren't you essentially opening a mechanism to
> access things outside of the chrooted environment with this patch?

I don't think so. spawn uses path_conv::check, which will bomb if the
program is outside the chroot area, no matter the Windows PATH.
One has to be careful not to put any Windows program in that area, 
as it won't honor the changeroot.
DLLs may open files outside of the chroot area, but that's
independent of the DLLs locations. 

> I wonder if, these days, all of the environment cache should be in
> the cygheap.

That would be reasonable, and would avoid quite a few translations.
Things can perhaps be reworked a little to remove the posix member from the
win_env, as it should always be equal to the value in the Cygwin environment.
Also the native member is updated every time its mate changes in the Cygwin
environment, so it can be blindly copied to the Windows environment
by build_env (no need to check if its has changed).

> Btw, in chroot should you be calling "set_errno (path.error)" rather
> than "__seterrno ()"?
Of course, what was I thinking?

> Anyway, I've check this in with the errno modification.  I'm not sure
> what the best way to deal with the problem of multiple cygwin's might
> be.  As you note it is ok to just copy the same cygwin into two
> locations but, boy, that's going to be a pain to maintain.
The issue is gone, so there is no need to escalate to the setup team :)

Pierre


