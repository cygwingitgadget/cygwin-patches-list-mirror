Return-Path: <cygwin-patches-return-3964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11502 invoked by alias); 16 Jun 2003 03:25:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11276 invoked from network); 16 Jun 2003 03:24:58 -0000
Date: Mon, 16 Jun 2003 03:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable dynamic (thread safe) reents
Message-ID: <20030616032457.GA10910@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net> <3EC4D5A0.7020005@gmx.net> <20030613031603.GA12302@redhat.com> <3EE96D3F.5010303@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE96D3F.5010303@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00191.txt.bz2

On Fri, Jun 13, 2003 at 08:20:47AM +0200, Thomas Pfaff wrote:
>Unfortunately stdin, stdout and stderr were defined with _REENT 
>directly. Sigh.

I've checked in this patch.  I'll ask again if it makes sense
to fix this problem in newlib.  Does it?

cgf
