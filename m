Return-Path: <cygwin-patches-return-5043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25347 invoked by alias); 10 Oct 2004 17:07:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25240 invoked from network); 10 Oct 2004 17:07:25 -0000
Date: Sun, 10 Oct 2004 17:07:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck (add_path): A little memory-leak.
Message-ID: <20041010170741.GC14377@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckajsj.3vv9689.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckajsj.3vv9689.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00044.txt.bz2

On Sun, Oct 10, 2004 at 08:36:36AM +0200, Bas van Gompel wrote:
>2004-10-10  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>	* cygcheck.cc (add_path): Don't leak memory when path is already in
>	``paths''.

Applied.  Thanks.

cgf
