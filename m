Return-Path: <cygwin-patches-return-4542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16255 invoked by alias); 30 Jan 2004 15:38:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16230 invoked from network); 30 Jan 2004 15:38:38 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 30 Jan 2004 15:38:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Jiri Malak <Jiri.Malak@geac.cz>
cc: cygwin-patches@cygwin.com
Subject: Re: Patch winuser.h in w32api
In-Reply-To: <CB2B5D9D2710D611A79100025558212EF23A75@geacprg.cz.geac.com>
Message-ID: <Pine.GSO.4.56.0401301029570.20527@slinky.cs.nyu.edu>
References: <CB2B5D9D2710D611A79100025558212EF23A75@geacprg.cz.geac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q1/txt/msg00032.txt.bz2

On Fri, 30 Jan 2004, Jiri Malak wrote:

> I am working on Open Watcom open source project which use w32api.
> I need correct winuser.h header file in w32api.
>
> Original line
>
> #define RT_MANIFEST MAKEINTRESOURCE(24)
>
> to
>
> #ifndef RC_INVOKED
> #define RT_MANIFEST MAKEINTRESOURCE(24)
> #else
> #define RT_MANIFEST 24
> #define CREATEPROCESS_MANIFEST_RESOURCE_ID 1
> #define ISOLATIONAWARE_MANIFEST_RESOURCE_ID 2
> #define ISOLATIONAWARE_NOSTATICIMPORT_MANIFEST_RESOURCE_ID 3
> #endif
>
> Please, could you change it if it is possible.
>
> Thanks
>
> Jiri

1) The above is not a patch.
2) It's missing a ChangeLog.
3) Patches for w32api should be sent to the mingw-patches mailing list
(see <http://mingw.org/>).  FYI, they also have their own rules for
submitting patches -- see <http://lists.sf.net/lists/listinfo/mingw-patches>
for instructions.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
