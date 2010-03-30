Return-Path: <cygwin-patches-return-7014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22206 invoked by alias); 30 Mar 2010 16:39:46 -0000
Received: (qmail 22191 invoked by uid 22791); 30 Mar 2010 16:39:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 30 Mar 2010 16:39:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7C9BB6D435B; Tue, 30 Mar 2010 18:39:37 +0200 (CEST)
Date: Tue, 30 Mar 2010 16:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20100330163937.GA16571@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>  <20100330095912.GZ18364@calimero.vinschen.de>  <4BB1D83A.8010406@towo.net>  <20100330142200.GA12926@calimero.vinschen.de>  <4BB21CBF.7030701@towo.net>  <20100330161503.GB18364@calimero.vinschen.de>  <416096c61003300936i55764afeqf06d84251cd9a9b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416096c61003300936i55764afeqf06d84251cd9a9b7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00130.txt.bz2

On Mar 30 17:36, Andy Koppe wrote:
> > How can I enforce printing garbage so I
> > can test the reset command?
> 
> echo $'\e(0'

Thanks, works fine.  Just like the reset command now.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
