Return-Path: <cygwin-patches-return-4986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28662 invoked by alias); 23 Sep 2004 10:32:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28630 invoked from network); 23 Sep 2004 10:32:47 -0000
Date: Thu, 23 Sep 2004 10:32:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Trailing spaces in cygcheck -cd or -s output.
Message-ID: <20040923103341.GA13736@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cibek2.3vvfqsr.1@buzzy-box.bavag> <20040922115453.GZ17670@cygbert.vinschen.de> <n2m-g.ciu2h5.3vsgpvd.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ciu2h5.3vsgpvd.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00138.txt.bz2

On Sep 23 09:19, Bas van Gompel wrote:
> 	* dump_setup.cc (dump_setup): Remove unneeded strlen when check_files
> 	is not set.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
