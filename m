Return-Path: <cygwin-patches-return-4250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18850 invoked by alias); 26 Sep 2003 13:43:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18833 invoked from network); 26 Sep 2003 13:43:49 -0000
Message-ID: <3F74428A.F832482F@phumblet.no-ip.org>
Date: Fri, 26 Sep 2003 13:43:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch] Recent security improvements breaks proftpd
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net> <20030926125328.GB29894@cygbert.vinschen.de> <20030926125834.GL22787@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00266.txt.bz2

Corinna Vinschen wrote:
> 
> On Fri, Sep 26, 2003 at 02:53:28PM +0200, Corinna Vinschen wrote:
> > Btw., shouldn't that be
> >
> >   SetTokenInformation (ptok, TokenDefaultDacl, pdacl, pAcl->AclSize)
> >                                                       ^^^^^^^^^^^^^
> >                                                     instead of sizeof(buf)?
> 
> Urgh.  What I meant was:
> 
>   sizeof *pdacl + pAcl->AclSize
> 
That makes for 3 possibilities but there is a 4th one: sizeof (* pdacl) 
(i.e. 4 bytes).
That's what a strict reading of MS would imply. I think I tried it once
(in another case) and it worked, but I never used it because it was contrary
to Cygwin tradition. 
I may also be mixing up my facts.

No problem about changing the buffer size, of course, and also #defining a constant.
Out of curiosity, have you ever seen a long default DACL?

Pierre
