Return-Path: <cygwin-patches-return-2586-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16931 invoked by alias); 3 Jul 2002 09:20:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16889 invoked from network); 3 Jul 2002 09:20:37 -0000
Date: Wed, 03 Jul 2002 02:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] 2.try: Interruptable accept
Message-ID: <20020703112036.S21857@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0207030945050.298-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207030945050.298-200000@algeria.intern.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00034.txt.bz2

On Wed, Jul 03, 2002 at 10:05:37AM +0200, Thomas Pfaff wrote:
> 
> This version is based on WSAEventSelect.
> I am working on an interruptable connect now.
> 
> Thomas

Thanks Thomas, that looks good.  I've applied it with two minor changes:

- I've turned around your comparisons to conform to the rest of the code.
  It's hard to read if that suddenly changes in the middle of something.
  I'd appricate if you could do this in your next patch by yourself.

- I've changed your comments to plain-C comments.  The comment after
  the call to ::accept was the only C++ comment in the code anyway and
  I've eliminated it.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
