Return-Path: <cygwin-patches-return-4703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2750 invoked by alias); 5 May 2004 00:20:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2729 invoked from network); 5 May 2004 00:20:04 -0000
Date: Wed, 05 May 2004 00:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
Message-ID: <20040505002003.GA8846@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00055.txt.bz2

On Tue, May 04, 2004 at 08:03:59PM -0400, Pierre A. Humblet wrote:
>Here is a simple patch that simplifies chdir processing
>and avoids calling normalized_posix_path multiple times.
>
>If it doesn't break anything it will simplify removing
>trailing dots and spaces, as discussed earlier today.

"If it doesn't break anything" does not leave me filled with confidence
that this patch is appropriate for application as we are anticipating
releasing 1.5.10.

cgf
