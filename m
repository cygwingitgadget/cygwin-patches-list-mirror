Return-Path: <cygwin-patches-return-4251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9316 invoked by alias); 26 Sep 2003 14:35:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9305 invoked from network); 26 Sep 2003 14:35:58 -0000
Date: Fri, 26 Sep 2003 14:35:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Recent security improvements breaks proftpd
Message-ID: <20030926143557.GP22787@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net> <20030926125328.GB29894@cygbert.vinschen.de> <20030926125834.GL22787@cygbert.vinschen.de> <3F74428A.F832482F@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F74428A.F832482F@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00267.txt.bz2

On Fri, Sep 26, 2003 at 09:43:38AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > On Fri, Sep 26, 2003 at 02:53:28PM +0200, Corinna Vinschen wrote:
> > > Btw., shouldn't that be
> > >
> > >   SetTokenInformation (ptok, TokenDefaultDacl, pdacl, pAcl->AclSize)
> > >                                                       ^^^^^^^^^^^^^
> > >                                                     instead of sizeof(buf)?
> > 
> > Urgh.  What I meant was:
> > 
> >   sizeof *pdacl + pAcl->AclSize
> > 
> That makes for 3 possibilities but there is a 4th one: sizeof (* pdacl) 
> (i.e. 4 bytes).

No, that doesn't make sense.  The buffer is used for the whole data.
We can keep sizeof(acl_buf) if you like this better but I'm wondering
if that could also make a difference when calling SetTokenInformation.
Due to missing source code of Windows, I just have no idea how intelligent
the code behind that function is :-)

> No problem about changing the buffer size, of course, and also #defining a constant.
> Out of curiosity, have you ever seen a long default DACL?

I never looked explicitely for default dacls but I saw 3K SDs returned
from GetFileSecurity on NT4.  AFAIR, the contained data didn't give
any hint why it was that big.  Admitted, though, that it was at a time
I just had started to struggle with NT security...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
