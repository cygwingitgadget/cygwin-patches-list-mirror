Return-Path: <cygwin-patches-return-2509-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19423 invoked by alias); 25 Jun 2002 01:17:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19405 invoked from network); 25 Jun 2002 01:17:43 -0000
Date: Mon, 24 Jun 2002 18:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: a utils.sgml patch
Message-ID: <20020625011830.GD32490@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206241854510.1244-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206241854510.1244-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00492.txt.bz2

On Mon, Jun 24, 2002 at 06:56:45PM -0500, Joshua Daniel Franklin wrote:
>Mon, 24 Jun 2002 18:56:45 -0500ere is a first patch for utils.sgml.
>This patch simply updates each of the <screen> sections that
>show the --help output to reflect the 1.3.11-3 utils.
>It seems like a good thing to get out of the way before attacking
>the section for each util.

Thanks.  I'e applied this patch.

Btw, in general, you don't need a ChangeLog for documentation since
the change is supposed to be obvious from context (that's the theory
anyway).  We do have a ChangeLog in the doc directory, because, er,
for the Makefile that resides there, yeah, that's it.

cgf
