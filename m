Return-Path: <cygwin-patches-return-3298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5796 invoked by alias); 10 Dec 2002 13:30:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5778 invoked from network); 10 Dec 2002 13:30:05 -0000
Date: Tue, 10 Dec 2002 05:30:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] netdb.cc to use strtok_r
Message-ID: <20021210143002.E7796@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF62D35.8020.1099672B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF62D35.8020.1099672B@localhost>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00249.txt.bz2

On Tue, Dec 10, 2002 at 06:06:45PM +1300, Craig McGeachie wrote:
Content-Description: Mail message body
> 2002-12-10 Craig McGeachie <slapdau@yahoo.com.au>
> 
> * netdb.cc (parse_alias_list, parse_services_line)
> (parse_protocol_line): Change strtok calls to strtok_r.

I've checked this in, but...

>  N.B. This routine relies on side effects due to the nature of
> -strtok().  strtok() initially takes a char * pointing to the start of
> -a line, and then NULL to indicate continued processing.  strtok() does
> +strtok_r().  strtok_r() initially takes a char * pointing to the start of
> +a line, and then NULL to indicate continued processing.  strtok_r() does
>  not provide a mechanism for getting pointer to the unprocessed portion
>  of a line.  Alias processing is done part way through a line after
> -strtok().  This routine relies on further calls to strtok(), passing
> +strtok_r().  This routine relies on further calls to strtok_r(), passing
>  NULL as the first parameter, returning alias names from the line. */

...I think this comment doesn't make any sense now.  strtok_r() doesn't
have side effects on the usage of other strtok() or strtok_r() calls
with different third parameter and it's usage inside of this functions
is completely encapsulated.  So I think we should drop the 'N.B.' comment
now entirely.

Comment?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
