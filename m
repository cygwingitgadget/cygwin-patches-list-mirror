Return-Path: <cygwin-patches-return-5212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26136 invoked by alias); 16 Dec 2004 15:09:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25775 invoked from network); 16 Dec 2004 15:09:27 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Dec 2004 15:09:27 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C62E41B401; Thu, 16 Dec 2004 10:10:33 -0500 (EST)
Date: Thu, 16 Dec 2004 15:09:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216151033.GB23488@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216023247.GA17763@trixie.casa.cgf.cx> <0I8T00H3VLMIQJ@pmismtp01.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0I8T00H3VLMIQJ@pmismtp01.mcilink.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00213.txt.bz2

On Thu, Dec 16, 2004 at 07:59:05AM -0700, Mark Paulus wrote:
>Other than the way I proposed, I'm not sure how to fix this, since the
>issue seems to be that conv_to_win32_path() needs to get the trailing
>dot in it's input argument, and check() is stripping it out.  The only
>way I can see to fix this behaviour is to leave the trailing dots in
>the string.  Maybe conv_to_win32_path needs to deal/strip with the
>trailing dots, depending upon whether it's a managed filesystem or not?

Yes, *of course* there either has to be special accommodations for
managed mounts or you have to show that your change will not affect
normal cygwin operation for non-managed mounts.

Your patch just essentially nuked most of cygwin's handling of trailing
dots.  Unless you can prove that the previous code was misguided in the
general case of non-managed mounts, doing this is obviously the wrong
solution.

cgf
