Return-Path: <cygwin-patches-return-5156-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28751 invoked by alias); 22 Nov 2004 15:24:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28353 invoked from network); 22 Nov 2004 15:24:36 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 22 Nov 2004 15:24:36 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 18EC41B422; Mon, 22 Nov 2004 10:25:18 -0500 (EST)
Date: Mon, 22 Nov 2004 15:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading the registry hive on Win9x (part 2)
Message-ID: <20041122152518.GD25781@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041121215538.008217f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041121215538.008217f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00157.txt.bz2

On Sun, Nov 21, 2004 at 09:55:38PM -0500, Pierre A. Humblet wrote:
>-  got_something_from_registry = regopt ("default");
>   if (myself->progname[0])
>-    got_something_from_registry = regopt (myself->progname) || got_something_from_registry;
>+    got_something_from_registry = regopt (myself->progname);
>+  got_something_from_registry =  got_something_from_registry || regopt ("default");

Doesn't this change the sense of the "default" key so that it will never
get used if a key exists for myself->progname rather than always get
used, regardless?  Maybe I'm the only person in the world who relies on
that behavior, but I do rely on it.

Other than that, the change looks fine.

cgf
