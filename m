Return-Path: <cygwin-patches-return-4245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5134 invoked by alias); 26 Sep 2003 12:58:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5124 invoked from network); 26 Sep 2003 12:58:35 -0000
Date: Fri, 26 Sep 2003 12:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Recent security improvements breaks proftpd
Message-ID: <20030926125834.GL22787@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net> <20030926125328.GB29894@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926125328.GB29894@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00261.txt.bz2

On Fri, Sep 26, 2003 at 02:53:28PM +0200, Corinna Vinschen wrote:
> Btw., shouldn't that be
> 
>   SetTokenInformation (ptok, TokenDefaultDacl, pdacl, pAcl->AclSize)
>                                                       ^^^^^^^^^^^^^
> 						      instead of sizeof(buf)?

Urgh.  What I meant was: 

  sizeof *pdacl + pAcl->AclSize

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
