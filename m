Return-Path: <cygwin-patches-return-4221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12072 invoked by alias); 16 Sep 2003 09:40:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12061 invoked from network); 16 Sep 2003 09:39:59 -0000
Date: Tue, 16 Sep 2003 09:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Part 2 of Fixing a security hole in pinfo.
Message-ID: <20030916093958.GN9981@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030914023055.GA10962@redhat.com> <3.0.5.32.20030913220742.0082d260@incoming.verizon.net> <20030914023055.GA10962@redhat.com> <3.0.5.32.20030915210152.0081a860@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030915210152.0081a860@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00237.txt.bz2

On Mon, Sep 15, 2003 at 09:01:52PM -0400, Pierre A. Humblet wrote:
> There is also a change I'd like to make eventually: the original_sid
> and the sid are cmalloc'ed. As they have a fixed size and every process
> needs them, we might as well make them cygsid's in the user structure.
> That would be safer and would simplify a few things.

While I tend to like the idea in itself, I don't see the simplification.
Except for not having to cmalloc in cygheap_user::set_sid() and
cygheap_user::set_saved_sid(), what's the deal?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
