Return-Path: <cygwin-patches-return-4871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32532 invoked by alias); 22 Jul 2004 04:18:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32523 invoked from network); 22 Jul 2004 04:18:07 -0000
Date: Thu, 22 Jul 2004 04:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040722041721.GA29883@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40FE87D6.3C89AE1F@phumblet.no-ip.org> <40FE87D6.3C89AE1F@phumblet.no-ip.org> <3.0.5.32.20040721232519.00810350@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040721232519.00810350@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00023.txt.bz2

On Wed, Jul 21, 2004 at 11:25:19PM -0400, Pierre A. Humblet wrote:
>Is it worth to delay 1.5.11 until those issues are sorted out? 

No, I don't think so.

We do have people reporting problems with MapViewOfFileEx and with
threads in perl, now, though.  So, 1.5.11 is not quite cooked.

cgf
