Return-Path: <cygwin-patches-return-4726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5177 invoked by alias); 7 May 2004 03:28:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5155 invoked from network); 7 May 2004 03:28:45 -0000
Date: Fri, 07 May 2004 03:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mount_info::conv_to_posix_path
Message-ID: <20040507032845.GA6297@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040506195101.008064e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040506195101.008064e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00078.txt.bz2

On Thu, May 06, 2004 at 07:51:01PM -0400, Pierre A. Humblet wrote:
>A missing return causes trouble when chroot is in effect.
>
>Pierre 
>
>2004-05-07  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (mount_info::conv_to_posix_path): Add return.
>
>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.309
>diff -u -p -r1.309 path.cc
>--- path.cc     6 May 2004 16:26:10 -0000       1.309
>+++ path.cc     6 May 2004 23:27:31 -0000
>@@ -1703,6 +1703,7 @@ mount_info::conv_to_posix_path (const ch
>          posix_path[0] = '/';
>          posix_path[1] = '\0';
>        }
>+      return 0;
>     }
>   else
>     return ENOENT;

Thanks.  I took the opportunity to reorganize this code slightly and
used a goto to jump out of the function so that the same debugging
info was recorded for strace.

So, I've applied your patch with hopefully minor tweaks.

cgf
