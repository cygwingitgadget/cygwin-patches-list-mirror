Return-Path: <cygwin-patches-return-6322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22287 invoked by alias); 22 Mar 2008 21:05:47 -0000
Received: (qmail 22276 invoked by uid 22791); 22 Mar 2008 21:05:47 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 22 Mar 2008 21:05:29 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 2D3A438C276; Sat, 22 Mar 2008 17:05:28 -0400 (EDT)
Date: Sat, 22 Mar 2008 21:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] QueryDosDevice in handle_to_fn
Message-ID: <20080322210528.GA22407@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCF310.2E2CA04A@dessent.net> <20080316152213.GD29148@calimero.vinschen.de> <20080316153607.GB27448@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080316153607.GB27448@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00096.txt.bz2

On Sun, Mar 16, 2008 at 11:36:07AM -0400, Christopher Faylor wrote:
>This is basically my function.  I'll try to convert it to use Unicode
>today.

I've checked in changes which move handle_to_fn closer to being totally
32-bit aware and fixed one pipe and one tty problem in the process.

cgf
