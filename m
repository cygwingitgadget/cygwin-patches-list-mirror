Return-Path: <cygwin-patches-return-3171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11984 invoked by alias); 14 Nov 2002 10:03:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11934 invoked from network); 14 Nov 2002 10:03:43 -0000
Date: Thu, 14 Nov 2002 02:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114110340.G10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00122.txt.bz2

On Wed, Nov 13, 2002 at 10:35:09PM -0500, Pierre A. Humblet wrote:
> I would say that the comparison (on your example) of the existing method 
> and the current patch show that the current patch better reflects the 
> "reality", because it only tries to do so when the actual current token 
> groups are known and the "reality" is well defined (*). 

> (*) I just noticed that getgroups32 should read the impersonation token
> if it exists.

Isn't the impersonation token automatically read by OpenProcessToken()
when an impersonation took place?

> Thus I suggest that we use the method of the patch for now, and think
> of improving is_grp_member if/as we get specific reports of problems. 
> What do you think?

Do you mean my one liner?  If so, I agree.  My patch is just a starting
point.  

Could you then please resend the parts of your #1 patch we agreed upon?

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
