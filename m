Return-Path: <cygwin-patches-return-5102-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20398 invoked by alias); 30 Oct 2004 23:42:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20389 invoked from network); 30 Oct 2004 23:42:15 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 30 Oct 2004 23:42:15 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 118E41B3E5; Sat, 30 Oct 2004 19:42:17 -0400 (EDT)
Date: Sat, 30 Oct 2004 23:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: Don't use keyeprint if GetLastError is irrelevant.
Message-ID: <20041030234216.GA10907@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.clsnoj.3vvasbt.1@buzzy-box.bavag> <20041029152238.GG29869@trixie.casa.cgf.cx> <n2m-g.clva3u.3vvcmfh.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.clva3u.3vvcmfh.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00103.txt.bz2

On Sat, Oct 30, 2004 at 11:32:27PM +0200, Bas van Gompel wrote:
>2004-10-28  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (get_dword): Fix errormessage.
>	(cygwin_info): Ditto.
>	(track_down): Ditto.
>	(check_keys): Ditto.

Go ahead and check these in.

Thanks,
cgf
