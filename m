Return-Path: <cygwin-patches-return-2748-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13489 invoked by alias); 30 Jul 2002 11:36:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13474 invoked from network); 30 Jul 2002 11:36:02 -0000
Date: Tue, 30 Jul 2002 04:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: setgroups
Message-ID: <20020730133559.I3921@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <3.0.5.32.20020729211608.0081e380@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020729211608.0081e380@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00196.txt.bz2

On Mon, Jul 29, 2002 at 09:16:08PM -0400, Pierre A. Humblet wrote:
> +int     _EXFUN(setgroups, (int ngroups, const gid_t *grouplist ));

Thanks Pierre,

I've added it to libc/include/sys/unistd.h as you proposed originally.
It's better to have all prototypes in one place.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
