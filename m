Return-Path: <cygwin-patches-return-2548-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7676 invoked by alias); 30 Jun 2002 13:10:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7658 invoked from network); 30 Jun 2002 13:10:15 -0000
Date: Sun, 30 Jun 2002 10:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Windows username in get_group_sidlist
Message-ID: <20020630151013.H1247@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3D1726E7.4EC19839@ieee.org> <3.0.5.32.20020623235117.008008f0@mail.attbi.com> <20020624120506.Z22705@cygbert.vinschen.de> <20020624130226.GA19789@redhat.com> <20020624151450.G22705@cygbert.vinschen.de> <3D1726E7.4EC19839@ieee.org> <3.0.5.32.20020629191915.0080d930@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020629191915.0080d930@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00531.txt.bz2

On Sat, Jun 29, 2002 at 07:19:15PM -0400, Pierre A. Humblet wrote:
> 2002-06-29  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	security.cc (extract_nt_dom_user): Check for all buffer overflows.
> 	Call LookupAccountSid after trying to get domain & user from passwd. 
> 	Only accept correct syntax for U-domain\username. 
> 	(get_group_sidlist): Obtain the domain and user by calling 
> 	extract_nt_dom_user instead of LookupAccountSid.

Thanks, Pierre.  I've applied the "soft" version.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
