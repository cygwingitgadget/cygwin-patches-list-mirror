Return-Path: <cygwin-patches-return-4658-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27161 invoked by alias); 10 Apr 2004 00:51:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27117 invoked from network); 10 Apr 2004 00:51:15 -0000
Date: Sat, 10 Apr 2004 00:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040410005113.GA4147@coe>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 10 Apr 2004 00:50:08.0541 (UTC) FILETIME=[C57BECD0:01C41E95]
X-SW-Source: 2004-q2/txt/msg00010.txt.bz2

On Sun, Apr 04, 2004 at 11:46:22PM -0400, Pierre A. Humblet wrote:
>2004-04-05  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (path_conv::check): Optimize symlink replacements.

I've checked both of these in and am generating a snapshot now.

Could you advertise its existence on cygwin at cygwin, Pierre?  I think
we need feedback on these changes before we go live with a new release.

cgf
