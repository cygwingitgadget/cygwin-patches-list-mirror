Return-Path: <cygwin-patches-return-4781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31764 invoked by alias); 21 May 2004 20:17:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31624 invoked from network); 21 May 2004 20:17:26 -0000
Message-ID: <cb51e2e0405211317715f04d3@mail.gmail.com>
Date: Fri, 21 May 2004 20:17:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [UG Patch] kmem and check_case typo
In-Reply-To: <Pine.CYG.4.58.0405211012470.3524@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040520141221.GA17516@cygbert.vinschen.de> <Pine.CYG.4.58.0405211012470.3524@fordpc.vss.fsi.com>
X-SW-Source: 2004-q2/txt/msg00133.txt.bz2

On Fri, 21 May 2004 10:22:20 -0500, Brian Ford <ford@vss.fsi.com> wrote:
> 
> On Thu, 20 May 2004, Corinna Vinschen wrote:
> 
> > On May 20 09:22, Igor Pechtchanski wrote:
> > > BTW, should /dev/kmem work also?
> >
> > No, only /dev/mem and /dev/port are working.  /dev/kmem is still looking
> > for a contributor.
> 
> Ok, then shouldn't we apply the following patch to the users guide? (plus
> a typo fix)
> 
> 2004-05-21  Brian Ford  <ford@vss.fsi.com>
> 
>         * pathnames.sgml: Remove /dev/kmem from the supported POSIX device
>         list.
> 
>         * cygwinenv.sgml: Fix typo in check_case description.
> 

Looks good to me, I'll apply this weekend unless someone beats me to it. 

Thanks for the typo catch. I've been spellchecking lately but
ovbiously don't catch them all.
