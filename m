Return-Path: <cygwin-patches-return-5219-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17895 invoked by alias); 16 Dec 2004 16:36:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17863 invoked from network); 16 Dec 2004 16:36:25 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Dec 2004 16:36:25 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id F3F271B401; Thu, 16 Dec 2004 11:37:32 -0500 (EST)
Date: Thu, 16 Dec 2004 16:36:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216163732.GJ23488@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20041216160950.GI23488@trixie.casa.cgf.cx> <0I8T001JLPJWAZ@pmismtp01.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0I8T001JLPJWAZ@pmismtp01.mcilink.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00220.txt.bz2

On Thu, Dec 16, 2004 at 09:23:56AM -0700, Mark Paulus wrote:
>Which is why I did what I did.  If you look, my patch allows for
>checking to see if "............................." was entered as an
>argument, and throws the exception if it was.  THEN, if that is not the
>case, it passes the FULL name to conv_to_win32_path to allow for proper
>demangling rules.

What you did was clear.  It was only a two line change, after all.

Unfortunately, you seemed to assume that all the work that cygwin went
through to figure out that trailing dot stuff was just useless and that
the rest of cygwin will work just fine with files containing trailing
dots regardless of whether the file is managed or not.  That is not the
case.  The point of the section of code that you patched was not just to
"throw the exception" it was to strip off the trailing dots.

cgf
