Return-Path: <cygwin-patches-return-5323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8311 invoked by alias); 28 Jan 2005 09:47:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6210 invoked from network); 28 Jan 2005 09:45:25 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.100.105)
  by sourceware.org with SMTP; 28 Jan 2005 09:45:25 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 79CD457D6E; Fri, 28 Jan 2005 10:45:24 +0100 (CET)
Date: Fri, 28 Jan 2005 09:47:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fs_info::update
Message-ID: <20050128094524.GY31117@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00026.txt.bz2

On Jan 27 21:58, Pierre A. Humblet wrote:
> 
> When a user has no read access to the root of a drive, GetVolumeInformation
> fails and has_acls is left unset. Consequently ntsec is off on that drive.
> If a user "chmod -r" the root of a drive, ntsec is turned off and "chmod +r"
> has no effect.
> The patch does its best to set has_acls even in case of failure.
> 
> 2005-01-28  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* path.cc (fs_info::update) Set has_acls even in case of failure.
> 
> 
> Index: path.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
> retrieving revision 1.340
> diff -u -p -r1.340 path.cc
> --- path.cc     26 Jan 2005 04:34:19 -0000      1.340
> +++ path.cc     28 Jan 2005 02:48:54 -0000
> @@ -381,6 +381,8 @@ fs_info::update (const char *win32_path)
>        debug_printf ("Cannot get volume information (%s), %E", root_dir);
>        has_buggy_open (false);
>        has_ea (false);
> +      has_acls (GetLastError () == ERROR_ACCESS_DENIED
> +                && (allow_smbntsec || !is_remote_drive ()));
>        flags () = serial () = 0;
>        return false;
>      }

This looks pretty much like a band-aid.  I can see the use for checking
the last error code, but shouldn't Cygwin opt for safety and not assume
ACLs?  Also, if there's no right to read a remote drive, there might be
a good reason for that, which doesn't necessarily mean the drive has acls.

After all, the effect of chmod -r can be reverted with Windows own means.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
