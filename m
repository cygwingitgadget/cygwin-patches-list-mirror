Return-Path: <cygwin-patches-return-5430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23163 invoked by alias); 6 May 2005 15:07:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22724 invoked from network); 6 May 2005 15:07:27 -0000
Received: from unknown (HELO vms046pub.verizon.net) (206.46.252.46)
  by sourceware.org with SMTP; 6 May 2005 15:07:27 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IG200B92Q05SE93@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Fri, 06 May 2005 10:07:23 -0500 (CDT)
Date: Fri, 06 May 2005 15:07:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <00b101c5524d$4b889990$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com>
 <20050506142213.GA20565@trixie.casa.cgf.cx>
 <00a701c5524b$a66949b0$3e0010ac@wirelessworld.airvananet.com>
 <20050506145838.GD20565@trixie.casa.cgf.cx>
X-SW-Source: 2005-q2/txt/msg00026.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, May 06, 2005 10:58 AM
Subject: Re: [Patch]: mkdir -p and network drives


> On Fri, May 06, 2005 at 10:55:29AM -0400, Pierre A. Humblet wrote:
> >----- Original Message ----- 
> >From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
> >To: <cygwin-patches@cygwin.com>
> >Sent: Friday, May 06, 2005 10:22 AM
> >Subject: Re: [Patch]: mkdir -p and network drives
> >
> >>Well, that was kinda my point.  If we can't remove the "//" handling
> >>because it breaks bash then adding opendir/readdir stuff seems
> >>premature except for the case of ls //foo which is entirely different
> >>from ls //.
> >
> >Sigh.  We need a bash maintainer.  We need to have // working for mkdir
> >-p to work, from what I understand of the code snippet that was sent to
> >the list.
> 
> I thought that Eric Blake implied that // *had* to be translated to /,
> as per POSIX.  I wonder how many programs out there translate a
> standalone '//' to '/'.

That's not Paul Eggert's position, 
http://cygwin.com/ml/cygwin/2005-05/msg00251.html
I don't expect problems with //, we had it working in cvs for a while
and only bash had issues.
Program translating // to / should already have problems and they 
won't be affected if Cygwin keeps //


Pierre
