Return-Path: <cygwin-patches-return-5078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15264 invoked by alias); 25 Oct 2004 15:51:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15242 invoked from network); 25 Oct 2004 15:51:33 -0000
Date: Mon, 25 Oct 2004 15:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: More complete helptext on drive-list.
Message-ID: <20041025155132.GA8428@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cl9oca.3vve76d.1@buzzy-box.bavag> <20041022000805.GF28112@trixie.casa.cgf.cx> <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag> <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag> <n2m-g.clektf.3vvfh6r.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.clektf.3vvfh6r.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00079.txt.bz2

On Sat, Oct 23, 2004 at 10:17:02PM +0200, Bas van Gompel wrote:
>Op Fri, 22 Oct 2004 04:34:05 +0200 (MET DST) schreef Bas van Gompel
>in <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag>:
>[...]
>
>:  D**n, the leading newline was lost...

I fixed this and checked it in.  In general, you don't add ChangeLog entries
about the ChangeLog.

I also removed a stray trailing space from the ChangeLog and, while I was at
it, did my standard sweep through the sources to put back tab indentation and
remove trailing whitespace where appropriate.

Go ahead and can check in the leading newline change.

Thanks.

cgf

>2004-10-23  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* ChangeLog: Fix line-endings on previous entry.
>	* cygcheck.cc (dump_sysinfo): Add leading newline before legend for
>	drive-list.
