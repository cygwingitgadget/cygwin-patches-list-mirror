Return-Path: <cygwin-patches-return-2886-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 835 invoked by alias); 30 Aug 2002 13:02:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 807 invoked from network); 30 Aug 2002 13:02:05 -0000
Date: Fri, 30 Aug 2002 06:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
Message-ID: <20020830150147.G5475@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97179922214.20020830163339@logos-m.ru>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00334.txt.bz2

On Fri, Aug 30, 2002 at 04:33:39PM +0400, Egor Duda wrote:
> CV> did I miss one?
> 
> btowc, wctob, mbsinit, mbrlen, mbrtowc, mbsttowcs, wcrtomb, wcsrtombs.

Thanks!

I didn't find mbsttowcs and mbstowcs is already defined, though.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
