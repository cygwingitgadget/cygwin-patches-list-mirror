Return-Path: <cygwin-patches-return-2704-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21803 invoked by alias); 24 Jul 2002 11:07:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21789 invoked from network); 24 Jul 2002 11:07:55 -0000
Date: Wed, 24 Jul 2002 04:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
Message-ID: <20020724130753.N13588@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020724073803.17255.qmail@sources.redhat.com> <145518762130.20020724122337@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145518762130.20020724122337@logos-m.ru>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00152.txt.bz2

On Wed, Jul 24, 2002 at 12:23:37PM +0400, Egor Duda wrote:
> 2002-07-24  Egor Duda  <deo@logos-m.ru>
> 
>         * Makefile.in: Check if API version is updated when exports
>         from dll are changed and stop if not so.
>         * include/cygwin/version.h: Bump minor API version.

I'm sorry.  I usually forget this when applying somebody elses patch
which adds new symbols.

I've applied the version.h patch.  I'm waiting for Chris before
changing the Makefile.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
