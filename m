Return-Path: <cygwin-patches-return-4249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18160 invoked by alias); 26 Sep 2003 13:41:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18149 invoked from network); 26 Sep 2003 13:41:32 -0000
Message-ID: <3F7441FD.8D36D01C@phumblet.no-ip.org>
Date: Fri, 26 Sep 2003 13:41:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
References: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net> <20030926122220.GA29894@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00265.txt.bz2

Corinna Vinschen wrote:
> 
> On Thu, Sep 25, 2003 at 09:47:48PM -0400, Pierre A. Humblet wrote:
> > This patch sets the _pinfo acl in order to allow access after
> > seteuid and exec.
> >
> > While looking at spawn.cc I also noticed oddities in pinfo related
> > error handling, and reworked them. I also restored impersonation in
> > case of CreateProcessAsUser failure.
> 
> Looks ok except for:
> 
> > @@ -42,9 +43,9 @@ pinfo_fixup_after_fork ()
> >  {
> >    if (hexec_proc)
> >      CloseHandle (hexec_proc);
> > -
> > +  /* Keeps the cygpid from being reused. No rights required */
> >    if (!DuplicateHandle (hMainProc, hMainProc, hMainProc, &hexec_proc, 0,
> > -                     TRUE, DUPLICATE_SAME_ACCESS))
> > +                     TRUE, 0))
> >      {
> >        system_printf ("couldn't save current process handle %p, %E", hMainProc);
> >        hexec_proc = NULL;
> 
> Somehow I'm missing a description why that's necessary and the
> implications.
> 
I am getting paranoid. Most often we duplicate DUPLICATE_SAME_ACCESS
without thinking about what access is really needed. It would be a good
discipline to ask ourselves what is needed and give just that. Here nothing
is needed at all. 
Also, if you use sysinternals you can see the access mask. Setting it
properly creates differentiating features that help distinguish between
all the handles.


Pierre
