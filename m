Return-Path: <cygwin-patches-return-2595-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4262 invoked by alias); 3 Jul 2002 15:50:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4215 invoked from network); 3 Jul 2002 15:50:26 -0000
Date: Wed, 03 Jul 2002 08:50:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: UTF8 patch
Message-ID: <20020703155036.GG24177@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <011a01c2228f$f91fbe30$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011a01c2228f$f91fbe30$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00043.txt.bz2

On Wed, Jul 03, 2002 at 01:48:47PM +0100, Chris January wrote:
>This patch adds UTF8 support to Cygwin. It's a quick hack, so may not be
>complete or perfect.

Is there any way that this could be done with wrapper functions for things
like CreateFile?  I would rather make this change as unintrusive as possible.

cgf
