Return-Path: <cygwin-patches-return-2308-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10379 invoked by alias); 5 Jun 2002 12:09:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10363 invoked from network); 5 Jun 2002 12:09:54 -0000
Date: Wed, 05 Jun 2002 05:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
Message-ID: <20020605140952.W30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <20020605140251.V30892@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020605140251.V30892@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00291.txt.bz2

On Wed, Jun 05, 2002 at 02:02:51PM +0200, cygpatch wrote:
> However, I think calling lookup_name is somewhat useless.  If a process
                                     ^^^
                            from internal_getlogin()

> can't read it's own token, something's really broken (and this is
> in retrospect the reason you investigated in changing the security
> stuff).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
