Return-Path: <cygwin-patches-return-2684-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19913 invoked by alias); 23 Jul 2002 13:53:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19892 invoked from network); 23 Jul 2002 13:53:13 -0000
Message-ID: <3D3D5FBE.EE322E22@ieee.org>
Date: Tue, 23 Jul 2002 06:53:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com> <20020719102328.E6932@cygbert.vinschen.de> <3D382572.5BEF1C2C@ieee.org> <20020719170639.R6932@cygbert.vinschen.de> <20020723145510.C13588@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00132.txt.bz2

Corinna Vinschen wrote:
> 
> it doesn't allow anonymous access to request the group list.
> NetUserGetGroups() returns ERROR_ACCESS_DENIED.  This can happen
> on 2K and .NET servers according to

Yep, I had seen that. I have even observed it at work where I can't
access domains servers in remote sites, other than the DCs of the 
local site where I work.

> So we still have a problem, even if the DC is accessible.  We could
> solve that by not failing silently if the get_user_groups() function
                *** <= you don't mean that!
> fails:


> What do you think?  Somehow I hate to soften the behaviour but it
> seems to be inescapable...

It's inescapable. 

What I don't understand is how mkpasswd/group work in that case (do they work?). 
See NetUserEnum
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/netmgmt/ntlmapi2_10xf.asp

If they don't, how does one enter the relevant sids in /etc/passwd 
and group? That's really where I got stuck at work. I never got to
the point where I could setuid, because I can't get the sids.  

Pierre
