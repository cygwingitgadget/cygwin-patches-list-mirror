Return-Path: <cygwin-patches-return-4023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16220 invoked by alias); 21 Jul 2003 13:07:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16192 invoked from network); 21 Jul 2003 13:07:18 -0000
Date: Mon, 21 Jul 2003 13:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix format strings for *_printf in mmap.c
Message-ID: <20030721130717.GL1621@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <14130.1058788870@www45.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14130.1058788870@www45.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00039.txt.bz2

On Mon, Jul 21, 2003 at 02:01:10PM +0200, Pavel Tsekov wrote:
> Hello, 
> 
> Does the following patch make any sense ?
> 
> * 2003-07-21  Pavel Tsekov  <ptsekov@gmx.net>
> 
> 	* mmap.cc: Use proper format specifiers for _off64_t and size_t in
> 	format strings passed to syscall_printf () and debug_printf ()
> 	throughout.

Definitely.  Applied.

Thanks for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
