Return-Path: <cygwin-patches-return-1899-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2091 invoked by alias); 25 Feb 2002 18:23:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2023 invoked from network); 25 Feb 2002 18:23:00 -0000
Date: Mon, 25 Feb 2002 10:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Big checkin to allow 64bit file access
Message-ID: <20020225192258.Y23094@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020225190107.W23094@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225190107.W23094@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00256.txt.bz2

Btw., this introduces two new datatypes, defined by SUSv2
but not yet defined in newlib, blkcnt_t and blksize_t, both
used in struct stat.  I added the definition of these types 
to cygwin/include/cygwin/types.h not to trouble newlib for
now.

Corinna
