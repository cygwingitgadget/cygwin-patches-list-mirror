Return-Path: <cygwin-patches-return-4011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31483 invoked by alias); 14 Jul 2003 18:03:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31456 invoked from network); 14 Jul 2003 18:03:17 -0000
Date: Mon, 14 Jul 2003 18:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030714180316.GI12368@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com> <20030714170539.GE12368@cygbert.vinschen.de> <3F12E948.82BBB05C@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F12E948.82BBB05C@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00027.txt.bz2

On Mon, Jul 14, 2003 at 01:32:56PM -0400, Pierre A. Humblet wrote:
> After researching the issue, all cygwin routines I could find (not
> only those ntsec related) initialize their handles to NULL, except
> subauth() and create_token(). Those exceptions make sense because 
> those two must return INVALID_HANDLE_VALUE on error.
> 
> The patch itself avoids initializing any handle (avoiding ambiguity), 
> except the usual automatic initialization to 0 of the cygheap stuff.  
> 
> Do you want my patch anyway (reverting what you have just applied), 
> or do we leave things as they are?

INVALID_HANDLE_VALUE is also used to initialize local variables.
I'd like to keep that value if you don't mind.

Thanks for the offer, though,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
