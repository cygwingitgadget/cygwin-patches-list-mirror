Return-Path: <cygwin-patches-return-5445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27929 invoked by alias); 11 May 2005 08:53:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27890 invoked from network); 11 May 2005 08:53:02 -0000
Received: from unknown (HELO calimero.vinschen.de) (84.148.32.211)
  by sourceware.org with SMTP; 11 May 2005 08:53:02 -0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DA0086D41F5; Wed, 11 May 2005 10:53:07 +0200 (CEST)
Date: Wed, 11 May 2005 08:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050511085307.GA2805@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00041.txt.bz2

On May 10 20:53, Pierre A. Humblet wrote:
> 	* dir.cc (isrofs): New function.
> 	(mkdir): Check for FH_FS and use isrofs.
> 	(rmdir): Use isrofs.
> 
> Index: dir.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
> retrieving revision 1.84
> diff -u -p -r1.84 dir.cc
> --- dir.cc      16 Mar 2005 21:20:56 -0000      1.84
> +++ dir.cc      11 May 2005 00:38:11 -0000
> @@ -216,6 +216,13 @@ closedir (DIR *dir)
>    return res;
>  }
>  
> +inline bool 
> +isrofs(DWORD devn) 
> +{
> +  return devn == FH_PROC || devn == FH_REGISTRY 
> +    || devn == FH_PROCESS || devn == FH_NETDRIVE;
> +}
> +
>  /* mkdir: POSIX 5.4.1.1 */
>  extern "C" int
>  mkdir (const char *dir, mode_t mode)

I don't like the idea of isrofs being an inline function in dir.cc.
Wouldn't that be better a method in path_conv?  It would be helpful
for other functions, too.  For instance, unlink and symlink_worker.
In the (not so) long run we should really move all of these functions
into the fhandlers, though.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
