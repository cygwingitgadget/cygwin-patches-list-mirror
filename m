Return-Path: <cygwin-patches-return-4176-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23734 invoked by alias); 8 Sep 2003 08:53:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23711 invoked from network); 8 Sep 2003 08:53:28 -0000
Date: Mon, 08 Sep 2003 08:53:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Export argz/envz functions
Message-ID: <20030908085327.GC1859@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F246153.3020504@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F246153.3020504@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00192.txt.bz2

On Sun, Jul 27, 2003 at 07:33:39PM -0400, Nicholas Wourms wrote:
> 2003-07-27  Nicholas Wourms  <nwourms@netscape.net>
> 
>     * cygwin.din: Export argz_add argz_add_sep argz_append argz_count
>     argz_create argz_create_sep argz_delete argz_extract argz_insert
>     argz_next argz_replace argz_stringify envz_add envz_entry envz_get 
>     envz_merge envz_remove envz_strip
>     * include/cygwin/version.h: Bump api minor number.

Applied (finally ;-)).

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
