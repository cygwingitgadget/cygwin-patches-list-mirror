Return-Path: <cygwin-patches-return-4970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6559 invoked by alias); 22 Sep 2004 11:54:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6541 invoked from network); 22 Sep 2004 11:53:59 -0000
Date: Wed, 22 Sep 2004 11:54:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Trailing spaces in cygcheck -cd or -s output.
Message-ID: <20040922115453.GZ17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cibek2.3vvfqsr.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cibek2.3vvfqsr.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00122.txt.bz2

On Sep 16 07:26, Bas van Gompel wrote:
> Hi,
> 
> This (trivial again, IMO) patch avoids trailing spaces in the output
> of cygheck's package-list. (This will reduce the size of
> `cygcheck.out's somewhat, as well.)
> 
> 
> ChangeLog enty:
> 
> 2004-09-16  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
> 
> 	* dump_setup.cc (dump_setup): Avoid trailing spaces on package-list.

Thanks for the patch.  I've applied the patch plus an additional patch which
adds an `if (check_files)' to simplify the expressions in (now two) printf's.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
