Return-Path: <cygwin-patches-return-5184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11151 invoked by alias); 5 Dec 2004 00:13:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11126 invoked from network); 5 Dec 2004 00:13:09 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 5 Dec 2004 00:13:09 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C75411B491; Sat,  4 Dec 2004 19:13:37 -0500 (EST)
Date: Sun, 05 Dec 2004 00:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] fhandler.cc: debug_printf when copied_chars is zero.
Message-ID: <20041205001337.GG15990@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.cotj39.3vvb3sh.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cotj39.3vvb3sh.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00185.txt.bz2

On Sun, Dec 05, 2004 at 12:01:02AM +0100, Bas van Gompel wrote:
>2004-12-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* fhandler.cc (fhandler_base::read): Don't debug_printf garbage when
>	copied_chars is zero.

Please checkin.

Thanks.

cgf
