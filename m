Return-Path: <cygwin-patches-return-2630-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28000 invoked by alias); 11 Jul 2002 14:06:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27918 invoked from network); 11 Jul 2002 14:06:06 -0000
Date: Thu, 11 Jul 2002 07:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] was [BUG]  open(): Opening with flags O_RDONLY | O_APPEND positions the file pointer at the end of the file
Message-ID: <20020711160603.B8643@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <823876622.20020710153943@syntrex.com> <20020710163613.GD10966@redhat.com> <20020710184830.J24137@cygbert.vinschen.de> <20020710165014.GB11381@redhat.com> <20020710190459.L24137@cygbert.vinschen.de> <2123565024.20020711153844@syntrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2123565024.20020711153844@syntrex.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00078.txt.bz2

On Thu, Jul 11, 2002 at 03:38:44PM +0200, Pavel Tsekov wrote:
> 2002-07-11  Pavel Tsekov  <ptsekov@gmx.net>
> 
>             * fhandler_disk_file.cc (fhandler_disk_file::open): Don't
>             move the file pointer to the end of file if O_APPEND is
>             specified in the open flags.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
