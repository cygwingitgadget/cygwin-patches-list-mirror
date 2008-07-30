Return-Path: <cygwin-patches-return-6342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28156 invoked by alias); 30 Jul 2008 06:09:06 -0000
Received: (qmail 28143 invoked by uid 22791); 30 Jul 2008 06:09:05 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-80.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.80)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 30 Jul 2008 06:08:41 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 757822B30C7; Wed, 30 Jul 2008 02:08:39 -0400 (EDT)
Date: Wed, 30 Jul 2008 06:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck linking without libz
Message-ID: <20080730060839.GA15880@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <489002C6.6020503@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489002C6.6020503@users.sourceforge.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00005.txt.bz2

On Wed, Jul 30, 2008 at 12:57:26AM -0500, Yaakov (Cygwin Ports) wrote:
>+2008-07-30  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
>+
>+	* Makefile.in: Link cygcheck with -lntdll even without mingw-zlib.

Applied.  Thanks.

(Btw, minor nit: Please don't post ChangeLog entries as a patch.  Just
send the ChangeLog entry as-is)

cgf
