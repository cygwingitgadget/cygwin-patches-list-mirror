Return-Path: <cygwin-patches-return-4300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11269 invoked by alias); 15 Oct 2003 08:27:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11253 invoked from network); 15 Oct 2003 08:27:25 -0000
Date: Wed, 15 Oct 2003 08:27:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031015082724.GJ14344@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031014231622.0082c1b0@incoming.verizon.net> <3F8CEE21.9080806@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8CEE21.9080806@student.tue.nl>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00019.txt.bz2

On Wed, Oct 15, 2003 at 08:50:09AM +0200, Micha Nelissen wrote:
> Pierre A. Humblet wrote:
> >FWIW, wouldn't it be cleaner to make "alternate_charset_active" a 
> >member of dev_state instead of introducing a new global variable?
> 
> Yes, although original_codepage was a viable candidate for a global 
> variable?. Never mind, but then either:

Well, think "historically grown code".

> 1) that alternate_charset check which currently is in str_to_con 
> (centralized), needs to dispersed over all calls to str_to_con. 
> (Currently, 1, AFAICS). Prone to bugs, if you ask me because this could 
> be forgotten in the future, unless this one call will remain the only one.
> 2) str_to_con has to become a member of dev_state too.

Point 2 has some merits.  Are you interested to do that change, Micha?
Of course, con_to_str should become a dev_state member then, too.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
