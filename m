Return-Path: <cygwin-patches-return-3625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28342 invoked by alias); 25 Feb 2003 16:08:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28326 invoked from network); 25 Feb 2003 16:08:22 -0000
Date: Tue, 25 Feb 2003 16:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Silent some more warnings.
Message-ID: <20030225160830.GB9454@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030220230012.I26596-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220230012.I26596-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00274.txt.bz2

On Thu, Feb 20, 2003 at 11:29:32PM +0100, Vaclav Haisman wrote:
>
>Hi,
>this patch silents warnings about strict-aliasing rules breach.
>There are also two hunks that remove obviously always true assert().
>
>Vaclav Haisman
>
>
>2003-02-20  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>
>	* libc/stdio/vfprintf.c (cvt): Fix strict-aliasing rules
>	breach warning.
>	* libc/stdlib/ldtoa.c (_ldtoa_r): Ditto.
>	(_strtold): Ditto.

For the record, newlib problems go to the newlib mailing list.

cgf
