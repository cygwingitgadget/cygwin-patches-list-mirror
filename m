Return-Path: <cygwin-patches-return-6397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13293 invoked by alias); 19 Dec 2008 14:32:55 -0000
Received: (qmail 13281 invoked by uid 22791); 19 Dec 2008 14:32:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Dec 2008 14:32:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9000B6D434C; Fri, 19 Dec 2008 15:32:11 +0100 (CET)
Date: Fri, 19 Dec 2008 14:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow access to /proc/registry/HKEY_PERFORMANCE_DATA
Message-ID: <20081219143211.GT6830@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <494BA890.8000004@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494BA890.8000004@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00041.txt.bz2

On Dec 19 14:58, Christian Franke wrote:
> 	* fhandler_registry.cc (perf_data_files): New table.
> 	(PERF_DATA_FILE_COUNT): New constant.
> 	(fhandler_registry::exists): Add check for HKEY_PERFORMANCE_DATA
> 	value names.
> 	(fhandler_registry::fstat): For HKEY_PERFORMANCE_DATA, return
> 	default values only.
> 	(fhandler_registry::readdir): For HKEY_PERFORMANCE_DATA, list
> 	names from perf_data_files only.
> 	(fhandler_registry::fill_filebuf): Use larger buffer to speed up
> 	access to HKEY_PERFORMANCE_DATA values.  Remove check for possible
> 	subkey.  Add RegCloseKey ().
> 	(open_key): Replace goto by break, remove label.  Do not try to
> 	open subkey of HKEY_PERFORMANCE_DATA.  Add missing RegCloseKey ()
> 	after open subkey error.

Looks good.  Works fine AFAICS.  Applied.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
