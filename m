Return-Path: <cygwin-patches-return-4253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25220 invoked by alias); 26 Sep 2003 14:57:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25211 invoked from network); 26 Sep 2003 14:57:31 -0000
Message-ID: <3F7453D3.3EBAD319@phumblet.no-ip.org>
Date: Fri, 26 Sep 2003 14:57:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch] Recent security improvements breaks proftpd
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net> <20030926125328.GB29894@cygbert.vinschen.de> <20030926125834.GL22787@cygbert.vinschen.de> <3F74428A.F832482F@phumblet.no-ip.org> <20030926143557.GP22787@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00269.txt.bz2

Corinna Vinschen wrote:
> 
> On Fri, Sep 26, 2003 at 09:43:38AM -0400, Pierre A. Humblet wrote:
> > Corinna Vinschen wrote:
> > >
> > > On Fri, Sep 26, 2003 at 02:53:28PM +0200, Corinna Vinschen wrote:
> > > > Btw., shouldn't that be
> > > >
> > > >   SetTokenInformation (ptok, TokenDefaultDacl, pdacl, pAcl->AclSize)
> > > >                                                       ^^^^^^^^^^^^^
> > > >                                                     instead of sizeof(buf)?
> > >
> > > Urgh.  What I meant was:
> > >
> > >   sizeof *pdacl + pAcl->AclSize
> > >
> > That makes for 3 possibilities but there is a 4th one: sizeof (* pdacl)
> > (i.e. 4 bytes).
> 
> No, that doesn't make sense.  The buffer is used for the whole data.
> We can keep sizeof(acl_buf) if you like this better but I'm wondering
> if that could also make a difference when calling SetTokenInformation.
> Due to missing source code of Windows, I just have no idea how intelligent
> the code behind that function is :-)

I agree that it's somewhat stange, but I just recompiled and it works fine
on NT4.

MS says:
TokenInformationLength 
[in] Specifies the length, in bytes, of the buffer pointed to by TokenInformation. 

(which is the pdacl).

So they must look at the pdacl, which points to the acl, which could be 
non-contiguous (there is no talk about "self-relative" or some such in this case).
Then they must copy the acl, up to AclSize, without bothering to analyze the acl
contents and remove the potentially empty tail. 
As you say, it would be nice (TM) to have the source code.

Of course in the GetTokenInformation the size must be that of the whole buffer in which
both the pdacl and the acl are written contiguously.

Pierre
