Return-Path: <cygwin-patches-return-5092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32546 invoked by alias); 28 Oct 2004 01:34:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32531 invoked from network); 28 Oct 2004 01:34:55 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 28 Oct 2004 01:34:55 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id BA1461B3E5; Wed, 27 Oct 2004 21:35:02 -0400 (EDT)
Date: Thu, 28 Oct 2004 01:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Deimpersonate while accessing HKLM
Message-ID: <20041028013502.GC5371@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00093.txt.bz2

On Wed, Oct 27, 2004 at 08:33:01PM -0400, Pierre A. Humblet wrote:
>This patch should fix the chdir problem reported by Jason Tishler.  It
>deimpersonates while reading the mounts and cygdrive in HKLM.
>
>For ease of initialization, the unused cygheap->user tokens are now set
>to NO_IMPERSONATION (instead of INVALID_HANDLE_VALUE), which is
>#defined as NULL.  If the argument of cygwin_set_impersonation_token()
>is INVALID_HANDLE_VALUE, it is changed to NO_IMPERSONATION.

As mentioned in cygwin-developers, go ahead and check this in, Pierre.

cgf
