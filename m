Return-Path: <cygwin-patches-return-4734-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2836 invoked by alias); 8 May 2004 18:26:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2823 invoked from network); 8 May 2004 18:26:51 -0000
Date: Sat, 08 May 2004 18:26:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Improving the anonymous ftp environment.
Message-ID: <20040508182651.GA28834@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040508141216.00803820@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040508141216.00803820@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00086.txt.bz2

On Sat, May 08, 2004 at 02:12:16PM -0400, Pierre A. Humblet wrote:
>On Fri, 7 May 2004 22:55:29 -0400, Christopher Faylor  wrote:
>>The memory leak is a good point (and has mildly bothered me since
>>implemented this) but aren't you essentially opening a mechanism to
>>access things outside of the chrooted environment with this patch?
>
>I don't think so.  spawn uses path_conv::check, which will bomb if the
>program is outside the chroot area, no matter the Windows PATH.  One
>has to be careful not to put any Windows program in that area, as it
>won't honor the changeroot.  DLLs may open files outside of the chroot
>area, but that's independent of the DLLs locations.

Ok.

>> I wonder if, these days, all of the environment cache should be in
>> the cygheap.
>
>That would be reasonable, and would avoid quite a few translations.
>Things can perhaps be reworked a little to remove the posix member from the
>win_env, as it should always be equal to the value in the Cygwin environment.
>Also the native member is updated every time its mate changes in the Cygwin
>environment, so it can be blindly copied to the Windows environment
>by build_env (no need to check if its has changed).

Unless the user manipulates the environment directly, which a few programs
do.  But, maybe that's already a problem with the current scheme.  It's been 
a while since I've tried to wrap my head around this.  We're still suffering
from some bad design decisions made early on in cygwin development.

cgf
