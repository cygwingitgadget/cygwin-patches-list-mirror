Return-Path: <cygwin-patches-return-5188-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4828 invoked by alias); 5 Dec 2004 05:37:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4803 invoked from network); 5 Dec 2004 05:37:04 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 5 Dec 2004 05:37:04 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 442C21B491; Sun,  5 Dec 2004 00:37:33 -0500 (EST)
Date: Sun, 05 Dec 2004 05:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] fhandler.cc: Don't worry about SPC in __small_printf-format
Message-ID: <20041205053733.GA21703@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.cou710.3vsjtgl.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cou710.3vsjtgl.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00189.txt.bz2

On Sun, Dec 05, 2004 at 05:44:24AM +0100, Bas van Gompel wrote:
>2004-12-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* fhandler.cc (fhandler_base::read): Remove superfluous check in
>	__small_sprintf format for strace.

Ok.  Please checkin.

Thanks,
cgf
