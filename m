Return-Path: <cygwin-patches-return-4007-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6716 invoked by alias); 12 Jul 2003 15:57:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6707 invoked from network); 12 Jul 2003 15:57:09 -0000
Date: Sat, 12 Jul 2003 15:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030712155608.GP12368@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com> <3.0.5.32.20030711200253.00807190@mail.attbi.com> <3.0.5.32.20030712093737.00812900@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030712093737.00812900@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00023.txt.bz2

On Sat, Jul 12, 2003 at 09:37:37AM -0400, Pierre A. Humblet wrote:
> At 10:31 AM 7/12/2003 +0200, Corinna Vinschen wrote:
> 
> >thanks for the patch but it has a problem.  You're comparing tokens against
> >NULL while the correct "NULL" value for tokens is INVALID_HANDLE_VALUE. 
> 
> Corinna,
> 
> That's by design, using of Chris' astute observations. As he once
> pointed out, INVALID_HANDLE_VALUE is the value returned in case of error
> but NULL is not a legal handle value either, as implied by CreateFile
> itself. Microsoft is using NULL handle values all the time. For the 
> specific case of a NULL token handle, see SetThreadToken.

What I don't like is that tokens can get both values now.  Most of the
time they are initialized to INVALID_HANDLE_VALUE, your code introduces
additionally NULL values.  At one point we will suddenly get a problem
because a `if (!foo_token)' doesn't handle the INVALID_HANDLE_VALUE case.

Regardless if INVALID_HANDLE_VALUE or NULL is the correct value, I want
to see only one of them used in Cygwin internally.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
