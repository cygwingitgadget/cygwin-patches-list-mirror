Return-Path: <cygwin-patches-return-5040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18799 invoked by alias); 9 Oct 2004 23:20:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18789 invoked from network); 9 Oct 2004 23:20:13 -0000
Date: Sat, 09 Oct 2004 23:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about trailing (back)slash on mount entries
Message-ID: <20041009232027.GE11984@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00041.txt.bz2

On Wed, Oct 06, 2004 at 03:12:45PM +0200, Bas van Gompel wrote:
>ChangeLog-entry:
>
>2004-10-06  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (dump_sysinfo): Warn about trailing (back)slash on mount
>	entries.

Rather than continue the debate about whether and how paths should
be checked, I've checked in this patch.

Thanks.

cgf
