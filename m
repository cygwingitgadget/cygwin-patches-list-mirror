Return-Path: <cygwin-patches-return-3684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1375 invoked by alias); 11 Mar 2003 10:24:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1366 invoked from network); 11 Mar 2003 10:24:33 -0000
Date: Tue, 11 Mar 2003 10:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030311102431.GB13544@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030310200902.007f3100@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00333.txt.bz2

On Mon, Mar 10, 2003 at 08:09:02PM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> Here is a patch to have fhandler_socket::dup return success
> or failure (related to the problem seen by Jason Tishler).

Thanks.  We still don't know *why* that happens, though.  That bugs me.

Anyway, I've made a change to fhandler_socket::dup() so that dup always
uses DuplicateHandle instead of the WinSock2 duplication methods.
Now it works. :-P

I'm seriously concidering to remove all the fixup_before/fixup_after
from fhandler_socket::dup() and just call fhandler_base::dup() on
NT systems.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
