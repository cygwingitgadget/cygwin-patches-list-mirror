Return-Path: <cygwin-patches-return-5207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22579 invoked by alias); 16 Dec 2004 02:31:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22533 invoked from network); 16 Dec 2004 02:31:41 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Dec 2004 02:31:41 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 8C0D51B401; Wed, 15 Dec 2004 21:32:47 -0500 (EST)
Date: Thu, 16 Dec 2004 02:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216023247.GA17763@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <0I8S00MOZDF18J@pmismtp01.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0I8S00MOZDF18J@pmismtp01.mcilink.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00208.txt.bz2

On Wed, Dec 15, 2004 at 04:04:13PM -0700, Mark Paulus wrote:
>This patch is as trivial as I could get to allow trailing
>dots to be used on a managed file system.
>
>Unfortunately, my company will not sign the waiver,
>so I cannot sign up for any significant changes to
>the cygwin sources.  So, hopefully, this patch is
>small enough to squeek under the limit, or it can be a
>starting point for discussions on how to fix the original
>problem.
>
>    * path.cc (path_conv::check):  retain trailing dots and 
>      spaces for managed mounts.

Er, this patch apparently just leaves the trailing dots in the
"converted" path, bypassing the loop which attempts to remove them.
That's not the way to do this.  Sorry.

cgf
