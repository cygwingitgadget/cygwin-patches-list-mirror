Return-Path: <cygwin-patches-return-3207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11035 invoked by alias); 20 Nov 2002 09:24:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11024 invoked from network); 20 Nov 2002 09:24:19 -0000
Date: Wed, 20 Nov 2002 01:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021120102417.D24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de> <3DD5053C.E50A33@ieee.org> <20021115160223.L24928@cygbert.vinschen.de> <3DD511B4.DBF3846E@ieee.org> <20021115180630.A31146@cygbert.vinschen.de> <3DD52F08.44B62AAE@ieee.org> <3.0.5.32.20021117224255.00830bc0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021117224255.00830bc0@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00158.txt.bz2

On Sun, Nov 17, 2002 at 10:42:55PM -0500, Pierre A. Humblet wrote:
> At 06:56 PM 11/15/2002 +0100, Corinna Vinschen wrote:
> >On Fri, Nov 15, 2002 at 12:29:44PM -0500, Pierre A. Humblet wrote:
> >> Alternatively I could add it, but add a check for group 
> >> sid is SYSTEM, and then skip the step. That would be very easy
> >> to do, and to remove later when ssh is ready.
> >> I like this best actually.
> >
> >Good idea!  Me too.  But that must go into both functions,
> >get_attribute_from_acl() and alloc_sd().
> 
> OK for get_attribute_from_acl (which is where the /var/empty
> problem originates), but why for alloc_sd () ? 
> The patch will do the right thing, whereas the current code 
> can give rise to unexpected results. See below.

Ok.  Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
