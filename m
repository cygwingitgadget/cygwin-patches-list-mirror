Return-Path: <cygwin-patches-return-2512-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14669 invoked by alias); 25 Jun 2002 09:25:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14638 invoked from network); 25 Jun 2002 09:25:56 -0000
Date: Tue, 25 Jun 2002 04:52:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Windows username in get_group_sidlist
Message-ID: <20020625112554.V22705@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020623235117.008008f0@mail.attbi.com> <20020624120506.Z22705@cygbert.vinschen.de> <20020624130226.GA19789@redhat.com> <20020624151450.G22705@cygbert.vinschen.de> <3D1726E7.4EC19839@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1726E7.4EC19839@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00495.txt.bz2

On Mon, Jun 24, 2002 at 10:04:23AM -0400, Pierre A. Humblet wrote:
> Corinna 
> 
> Now that get_group_sidlist () knows pw, it would be easy to
> lookup the domain from passwd, instead of using LookupAccountSid.
> This avoids over-the-network lookups for domain users.
> 
> I would actually read passwd by calling extract_nt_dom_user (),
> modifying it to first read the domain from the passwd file, and 
> if that fails, use LookupAccountSid [currently it tries 
> LookupAccountSid first, getting the sid from passwd]. 
> 
> What do you think?

Actually it sounds good.  Do you have a patch?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
