Return-Path: <cygwin-patches-return-4048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11121 invoked by alias); 8 Aug 2003 19:31:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11108 invoked from network); 8 Aug 2003 19:31:39 -0000
Date: Fri, 08 Aug 2003 19:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pwdgrp::read_group(): Don't call free() twice with the same address
Message-ID: <20030808193139.GB12540@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <16179.63786.774532.138718@phish.entomo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16179.63786.774532.138718@phish.entomo.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00064.txt.bz2

On Fri, Aug 08, 2003 at 12:25:30PM -0700, David Rothenberger wrote:
>2003-08-08  David Rothenberger  <daveroth@acm.org>
>
>	* grp.cc (read_group): Set __group32.gr_mem pointer back to
>	&null_ptr after free() is called.

Applied.

Thanks for tracking this down.  I know it wasn't easy.

cgf
