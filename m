Return-Path: <cygwin-patches-return-2511-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24446 invoked by alias); 25 Jun 2002 07:21:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24381 invoked from network); 25 Jun 2002 07:21:32 -0000
Date: Tue, 25 Jun 2002 02:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: uinfo.cc
Message-ID: <20020625092131.A18883@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020624194543.00802da0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020624194543.00802da0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00494.txt.bz2

On Mon, Jun 24, 2002 at 07:45:43PM -0400, Pierre A. Humblet wrote:
> Looks like I had introduced a bug. A child had the wrong 
> uid/gid (but the right token), following setEuid(). This fixes it. 
> Sorry about that.

I already fixed it yesterday.

Thanks anyway,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
