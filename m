Return-Path: <cygwin-patches-return-4388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6497 invoked by alias); 14 Nov 2003 21:24:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6481 invoked from network); 14 Nov 2003 21:24:08 -0000
Date: Fri, 14 Nov 2003 21:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc (build_fh_pc): serial port handling
Message-ID: <20031114212404.GD24177@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos> <20031112092733.GB7542@cygbert.vinschen.de> <Pine.GSO.4.56.0311121307230.9584@eos> <20031114013739.GC2631@redhat.com> <Pine.GSO.4.56.0311141425120.9584@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311141425120.9584@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00107.txt.bz2

On Fri, Nov 14, 2003 at 02:41:06PM -0600, Brian Ford wrote:
>However, it certainly looked like an obvious and logical bug fix.

It's only logical and obvious if you assume that the com file device
handling is the same as other devices.  I needed to reaquaint myself
with whether that was true or not.  Saying "and this makes /dev/ttyS0
work" goes a long way to alleviating any concerns.

cgf
