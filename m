Return-Path: <cygwin-patches-return-2526-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10161 invoked by alias); 27 Jun 2002 14:18:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10146 invoked from network); 27 Jun 2002 14:18:42 -0000
Date: Thu, 27 Jun 2002 08:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Additional trace printf in pthread::create
Message-ID: <20020627141844.GC4417@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0206270928100.315-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0206270928100.315-200000@algeria.intern.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00509.txt.bz2

On Thu, Jun 27, 2002 at 09:33:01AM +0200, Thomas Pfaff wrote:
>Changelog
>
>2002-06-27  Thomas Pfaff  <tpfaff@gmx.net>
>
>	*thread.cc (pthread::create): Added trace printf to get
>	CreateThread LastError.

Applied, with modification.  The _printf functions interpret '%E' as GetLastError
so I modified your patch to do that.

cgf
